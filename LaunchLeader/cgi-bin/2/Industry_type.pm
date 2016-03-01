sub read_industry_type
{

   $industry_type->{'industry_type_id'} = clean('int', $_query->param('industry_type_id'));
   $industry_type->{'industry_type_name'} = $_query->param('industry_type_name');

   return;
}

sub select_industry_types
{
   my $where = shift;

   my $statement = "SELECT
industry_type.industry_type_id,industry_type.industry_type_name         
	FROM industry_type
         $where";

   $industry_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_industry_type
{
   $industry_type = HFetch($industry_type_sth);

   return $industry_type->{'industry_type_id'} ne "";
}

sub select_industry_type
{
   my $id = shift;

   my $statement = "SELECT 
industry_type_id,industry_type_name                 
		FROM industry_type
                 WHERE industry_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $industry_type = HFetchone($sth);

   return $industry_type->{'industry_type_id'} ne "";
}

sub insert_industry_type
{
   $industry_type->{'industry_type_name'} = $dbh->quote($industry_type->{'industry_type_name'});

   my $statement = "INSERT INTO industry_type ( 
industry_type_id,industry_type_name
	)
	VALUES (
$industry_type->{'industry_type_id'},$industry_type->{'industry_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(industry_type_id) FROM industry_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_industry_type
{
    my $setstr = shift;
    my $statement;

   $industry_type->{'industry_type_name'} = $dbh->quote($industry_type->{'industry_type_name'});

    if($setstr)
      {  $statement = "UPDATE industry_type SET $setstr WHERE industry_type_id = $industry_type->{'industry_type_id'}";  }
    else
      {
        $statement = "UPDATE industry_type SET
		industry_type_id = $industry_type->{'industry_type_id'},
		industry_type_name = $industry_type->{'industry_type_name'}               
		WHERE industry_type_id = $industry_type->{'industry_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_industry_type
{
my $id = shift;

my $statement = "DELETE FROM industry_type
                 WHERE industry_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
