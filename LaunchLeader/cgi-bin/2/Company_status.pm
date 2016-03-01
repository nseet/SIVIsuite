sub read_company_status
{

   $company_status->{'company_status_id'} = clean('int', $_query->param('company_status_id'));
   $company_status->{'company_status_name'} = $_query->param('company_status_name');

   return;
}

sub select_company_statuss
{
   my $where = shift;

   my $statement = "SELECT
company_status.company_status_id,company_status.company_status_name         
	FROM company_status
         $where";

   $company_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_company_status
{
   $company_status = HFetch($company_status_sth);

   return $company_status->{'company_status_id'} ne "";
}

sub select_company_status
{
   my $id = shift;

   my $statement = "SELECT 
company_status_id,company_status_name                 
		FROM company_status
                 WHERE company_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $company_status = HFetchone($sth);

   return $company_status->{'company_status_id'} ne "";
}

sub insert_company_status
{
   $company_status->{'company_status_name'} = $dbh->quote($company_status->{'company_status_name'});

   my $statement = "INSERT INTO company_status ( 
company_status_id,company_status_name
	)
	VALUES (
$company_status->{'company_status_id'},$company_status->{'company_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(company_status_id) FROM company_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_company_status
{
    my $setstr = shift;
    my $statement;

   $company_status->{'company_status_name'} = $dbh->quote($company_status->{'company_status_name'});

    if($setstr)
      {  $statement = "UPDATE company_status SET $setstr WHERE company_status_id = $company_status->{'company_status_id'}";  }
    else
      {
        $statement = "UPDATE company_status SET
		company_status_id = $company_status->{'company_status_id'},
		company_status_name = $company_status->{'company_status_name'}               
		WHERE company_status_id = $company_status->{'company_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_company_status
{
my $id = shift;

my $statement = "DELETE FROM company_status
                 WHERE company_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
