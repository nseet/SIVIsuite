sub read_account_partner
{

   $account_partner->{'account_partner_id'} = clean('int', $_query->param('account_partner_id'));
   $account_partner->{'account_partner_name'} = $_query->param('account_partner_name');
   $account_partner->{'account_partner_crumb'} = $_query->param('account_partner_crumb');
   $account_partner->{'account_partner_details'} = $_query->param('account_partner_details');
   $account_partner->{'account_partner_thumbnail'} = $_query->param('account_partner_thumbnail');
   $account_partner->{'account_partner_status'} = clean('int', $_query->param('account_partner_status'));

   return;
}

sub select_account_partners
{
   my $where = shift;

   my $statement = "SELECT
account_partner.account_partner_id,account_partner.account_partner_name,account_partner.account_partner_crumb,account_partner.account_partner_details,account_partner.account_partner_thumbnail,account_partner.account_partner_status         
	FROM account_partner
         $where";

   $account_partner_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_partner
{
   $account_partner = HFetch($account_partner_sth);

   return $account_partner->{'account_partner_id'} ne "";
}

sub select_account_partner
{
   my $id = shift;

   my $statement = "SELECT 
account_partner_id,account_partner_name,account_partner_crumb,account_partner_details,account_partner_thumbnail,account_partner_status                 
		FROM account_partner
                 WHERE account_partner_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_partner = HFetchone($sth);

   return $account_partner->{'account_partner_id'} ne "";
}

sub insert_account_partner
{
   $account_partner->{'account_partner_name'} = $dbh->quote($account_partner->{'account_partner_name'});
   $account_partner->{'account_partner_crumb'} = $dbh->quote($account_partner->{'account_partner_crumb'});
   $account_partner->{'account_partner_details'} = $dbh->quote($account_partner->{'account_partner_details'});
   $account_partner->{'account_partner_thumbnail'} = $dbh->quote($account_partner->{'account_partner_thumbnail'});

   my $statement = "INSERT INTO account_partner ( 
account_partner_id,account_partner_name,account_partner_crumb,account_partner_details,account_partner_thumbnail,account_partner_status
	)
	VALUES (
$account_partner->{'account_partner_id'},$account_partner->{'account_partner_name'},$account_partner->{'account_partner_crumb'},$account_partner->{'account_partner_details'},$account_partner->{'account_partner_thumbnail'},$account_partner->{'account_partner_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_partner_id) FROM account_partner";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_partner
{
    my $setstr = shift;
    my $statement;

   $account_partner->{'account_partner_name'} = $dbh->quote($account_partner->{'account_partner_name'});
   $account_partner->{'account_partner_crumb'} = $dbh->quote($account_partner->{'account_partner_crumb'});
   $account_partner->{'account_partner_details'} = $dbh->quote($account_partner->{'account_partner_details'});
   $account_partner->{'account_partner_thumbnail'} = $dbh->quote($account_partner->{'account_partner_thumbnail'});

    if($setstr)
      {  $statement = "UPDATE account_partner SET $setstr WHERE account_partner_id = $account_partner->{'account_partner_id'}";  }
    else
      {
        $statement = "UPDATE account_partner SET
		account_partner_id = $account_partner->{'account_partner_id'},
		account_partner_name = $account_partner->{'account_partner_name'},
		account_partner_crumb = $account_partner->{'account_partner_crumb'},
		account_partner_details = $account_partner->{'account_partner_details'},
		account_partner_thumbnail = $account_partner->{'account_partner_thumbnail'},
		account_partner_status = $account_partner->{'account_partner_status'}               
		WHERE account_partner_id = $account_partner->{'account_partner_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_partner
{
my $id = shift;

my $statement = "DELETE FROM account_partner
                 WHERE account_partner_id = $id";

Execute($statement,$dbh);

return;
}

1;
