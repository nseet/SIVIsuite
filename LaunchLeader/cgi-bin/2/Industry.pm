sub read_industry
{

   $industry->{'industry_id'} = clean('int', $_query->param('industry_id'));
   $industry->{'industry_name'} = $_query->param('industry_name');
   $industry->{'industry_desc'} = $_query->param('industry_desc');
   $industry->{'industry_note'} = $_query->param('industry_note');
   $industry->{'industry_type'} = clean('int', $_query->param('industry_type'));
   $industry->{'industry_status'} = clean('int', $_query->param('industry_status'));

   return;
}

sub select_industrys
{
   my $where = shift;

   my $statement = "SELECT
industry.industry_id,industry.industry_name,industry.industry_desc,industry.industry_note,industry.industry_type,industry.industry_status         
	FROM industry
         $where";

   $industry_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_industry
{
   $industry = HFetch($industry_sth);

   return $industry->{'industry_id'} ne "";
}

sub select_industry
{
   my $id = shift;

   my $statement = "SELECT 
industry_id,industry_name,industry_desc,industry_note,industry_type,industry_status                 
		FROM industry
                 WHERE industry_id = $id";
   my $sth = Execute($statement,$dbh);

   $industry = HFetchone($sth);

   return $industry->{'industry_id'} ne "";
}

sub insert_industry
{
   $industry->{'industry_name'} = $dbh->quote($industry->{'industry_name'});
   $industry->{'industry_desc'} = $dbh->quote($industry->{'industry_desc'});
   $industry->{'industry_note'} = $dbh->quote($industry->{'industry_note'});

   my $statement = "INSERT INTO industry ( 
industry_id,industry_name,industry_desc,industry_note,industry_type,industry_status
	)
	VALUES (
$industry->{'industry_id'},$industry->{'industry_name'},$industry->{'industry_desc'},$industry->{'industry_note'},$industry->{'industry_type'},$industry->{'industry_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(industry_id) FROM industry";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_industry
{
    my $setstr = shift;
    my $statement;

   $industry->{'industry_name'} = $dbh->quote($industry->{'industry_name'});
   $industry->{'industry_desc'} = $dbh->quote($industry->{'industry_desc'});
   $industry->{'industry_note'} = $dbh->quote($industry->{'industry_note'});

    if($setstr)
      {  $statement = "UPDATE industry SET $setstr WHERE industry_id = $industry->{'industry_id'}";  }
    else
      {
        $statement = "UPDATE industry SET
		industry_id = $industry->{'industry_id'},
		industry_name = $industry->{'industry_name'},
		industry_desc = $industry->{'industry_desc'},
		industry_note = $industry->{'industry_note'},
		industry_type = $industry->{'industry_type'},
		industry_status = $industry->{'industry_status'}               
		WHERE industry_id = $industry->{'industry_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_industry
{
my $id = shift;

my $statement = "DELETE FROM industry
                 WHERE industry_id = $id";

Execute($statement,$dbh);

return;
}

1;
