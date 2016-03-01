sub read_industry_status
{

   $industry_status->{'industry_status_id'} = clean('int', $_query->param('industry_status_id'));
   $industry_status->{'industry_status_name'} = $_query->param('industry_status_name');

   return;
}

sub select_industry_statuss
{
   my $where = shift;

   my $statement = "SELECT
industry_status.industry_status_id,industry_status.industry_status_name         
	FROM industry_status
         $where";

   $industry_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_industry_status
{
   $industry_status = HFetch($industry_status_sth);

   return $industry_status->{'industry_status_id'} ne "";
}

sub select_industry_status
{
   my $id = shift;

   my $statement = "SELECT 
industry_status_id,industry_status_name                 
		FROM industry_status
                 WHERE industry_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $industry_status = HFetchone($sth);

   return $industry_status->{'industry_status_id'} ne "";
}

sub insert_industry_status
{
   $industry_status->{'industry_status_name'} = $dbh->quote($industry_status->{'industry_status_name'});

   my $statement = "INSERT INTO industry_status ( 
industry_status_id,industry_status_name
	)
	VALUES (
$industry_status->{'industry_status_id'},$industry_status->{'industry_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(industry_status_id) FROM industry_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_industry_status
{
    my $setstr = shift;
    my $statement;

   $industry_status->{'industry_status_name'} = $dbh->quote($industry_status->{'industry_status_name'});

    if($setstr)
      {  $statement = "UPDATE industry_status SET $setstr WHERE industry_status_id = $industry_status->{'industry_status_id'}";  }
    else
      {
        $statement = "UPDATE industry_status SET
		industry_status_id = $industry_status->{'industry_status_id'},
		industry_status_name = $industry_status->{'industry_status_name'}               
		WHERE industry_status_id = $industry_status->{'industry_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_industry_status
{
my $id = shift;

my $statement = "DELETE FROM industry_status
                 WHERE industry_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
