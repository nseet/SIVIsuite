sub read_company
{

   $company->{'company_id'} = clean('int', $_query->param('company_id'));
   $company->{'company_name'} = $_query->param('company_name');
   $company->{'company_site'} = $_query->param('company_site');
   $company->{'company_phone'} = $_query->param('company_phone');
   $company->{'company_email'} = $_query->param('company_email');
   $company->{'company_desc'} = $_query->param('company_desc');
   $company->{'company_note'} = $_query->param('company_note');
   $company->{'company_agree'} = clean('int', $_query->param('company_agree'));
   $company->{'company_type'} = clean('int', $_query->param('company_type'));
   $company->{'company_status'} = clean('int', $_query->param('company_status'));

   return;
}

sub select_companys
{
   my $where = shift;

   my $statement = "SELECT
company.company_id,company.company_name,company.company_site,company.company_phone,company.company_email,company.company_desc,company.company_note,company.company_agree,company.company_type,company.company_status         
	FROM company
         $where";

   $company_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_company
{
   $company = HFetch($company_sth);

   return $company->{'company_id'} ne "";
}

sub select_company
{
   my $id = shift;

   my $statement = "SELECT 
company_id,company_name,company_site,company_phone,company_email,company_desc,company_note,company_agree,company_type,company_status                 
		FROM company
                 WHERE company_id = $id";
   my $sth = Execute($statement,$dbh);

   $company = HFetchone($sth);

   return $company->{'company_id'} ne "";
}

sub insert_company
{
   $company->{'company_name'} = $dbh->quote($company->{'company_name'});
   $company->{'company_site'} = $dbh->quote($company->{'company_site'});
   $company->{'company_phone'} = $dbh->quote($company->{'company_phone'});
   $company->{'company_email'} = $dbh->quote($company->{'company_email'});
   $company->{'company_desc'} = $dbh->quote($company->{'company_desc'});
   $company->{'company_note'} = $dbh->quote($company->{'company_note'});

   my $statement = "INSERT INTO company ( 
company_id,company_name,company_site,company_phone,company_email,company_desc,company_note,company_agree,company_type,company_status
	)
	VALUES (
$company->{'company_id'},$company->{'company_name'},$company->{'company_site'},$company->{'company_phone'},$company->{'company_email'},$company->{'company_desc'},$company->{'company_note'},$company->{'company_agree'},$company->{'company_type'},$company->{'company_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(company_id) FROM company";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_company
{
    my $setstr = shift;
    my $statement;

   $company->{'company_name'} = $dbh->quote($company->{'company_name'});
   $company->{'company_site'} = $dbh->quote($company->{'company_site'});
   $company->{'company_phone'} = $dbh->quote($company->{'company_phone'});
   $company->{'company_email'} = $dbh->quote($company->{'company_email'});
   $company->{'company_desc'} = $dbh->quote($company->{'company_desc'});
   $company->{'company_note'} = $dbh->quote($company->{'company_note'});

    if($setstr)
      {  $statement = "UPDATE company SET $setstr WHERE company_id = $company->{'company_id'}";  }
    else
      {
        $statement = "UPDATE company SET
		company_id = $company->{'company_id'},
		company_name = $company->{'company_name'},
		company_site = $company->{'company_site'},
		company_phone = $company->{'company_phone'},
		company_email = $company->{'company_email'},
		company_desc = $company->{'company_desc'},
		company_note = $company->{'company_note'},
		company_agree = $company->{'company_agree'},
		company_type = $company->{'company_type'},
		company_status = $company->{'company_status'}               
		WHERE company_id = $company->{'company_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_company
{
my $id = shift;

my $statement = "DELETE FROM company
                 WHERE company_id = $id";

Execute($statement,$dbh);

return;
}

1;
