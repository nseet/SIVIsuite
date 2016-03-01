sub read_company_type
{

   $company_type->{'company_type_id'} = clean('int', $_query->param('company_type_id'));
   $company_type->{'company_type_name'} = $_query->param('company_type_name');

   return;
}

sub select_company_types
{
   my $where = shift;

   my $statement = "SELECT
company_type.company_type_id,company_type.company_type_name         
	FROM company_type
         $where";

   $company_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_company_type
{
   $company_type = HFetch($company_type_sth);

   return $company_type->{'company_type_id'} ne "";
}

sub select_company_type
{
   my $id = shift;

   my $statement = "SELECT 
company_type_id,company_type_name                 
		FROM company_type
                 WHERE company_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $company_type = HFetchone($sth);

   return $company_type->{'company_type_id'} ne "";
}

sub insert_company_type
{
   $company_type->{'company_type_name'} = $dbh->quote($company_type->{'company_type_name'});

   my $statement = "INSERT INTO company_type ( 
company_type_id,company_type_name
	)
	VALUES (
$company_type->{'company_type_id'},$company_type->{'company_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(company_type_id) FROM company_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_company_type
{
    my $setstr = shift;
    my $statement;

   $company_type->{'company_type_name'} = $dbh->quote($company_type->{'company_type_name'});

    if($setstr)
      {  $statement = "UPDATE company_type SET $setstr WHERE company_type_id = $company_type->{'company_type_id'}";  }
    else
      {
        $statement = "UPDATE company_type SET
		company_type_id = $company_type->{'company_type_id'},
		company_type_name = $company_type->{'company_type_name'}               
		WHERE company_type_id = $company_type->{'company_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_company_type
{
my $id = shift;

my $statement = "DELETE FROM company_type
                 WHERE company_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
