sub read_account_detail_status
{

   $account_detail_status->{'account_detail_status_id'} = clean('int', $_query->param('account_detail_status_id'));
   $account_detail_status->{'account_detail_status_name'} = $_query->param('account_detail_status_name');

   return;
}

sub select_account_detail_statuss
{
   my $where = shift;

   my $statement = "SELECT
account_detail_status.account_detail_status_id,account_detail_status.account_detail_status_name         
	FROM account_detail_status
         $where";

   $account_detail_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_detail_status
{
   $account_detail_status = HFetch($account_detail_status_sth);

   return $account_detail_status->{'account_detail_status_id'} ne "";
}

sub select_account_detail_status
{
   my $id = shift;

   my $statement = "SELECT 
account_detail_status_id,account_detail_status_name                 
		FROM account_detail_status
                 WHERE account_detail_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_detail_status = HFetchone($sth);

   return $account_detail_status->{'account_detail_status_id'} ne "";
}

sub insert_account_detail_status
{
   $account_detail_status->{'account_detail_status_name'} = $dbh->quote($account_detail_status->{'account_detail_status_name'});

   my $statement = "INSERT INTO account_detail_status ( 
account_detail_status_id,account_detail_status_name
	)
	VALUES (
$account_detail_status->{'account_detail_status_id'},$account_detail_status->{'account_detail_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_detail_status_id) FROM account_detail_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_detail_status
{
    my $setstr = shift;
    my $statement;

   $account_detail_status->{'account_detail_status_name'} = $dbh->quote($account_detail_status->{'account_detail_status_name'});

    if($setstr)
      {  $statement = "UPDATE account_detail_status SET $setstr WHERE account_detail_status_id = $account_detail_status->{'account_detail_status_id'}";  }
    else
      {
        $statement = "UPDATE account_detail_status SET
		account_detail_status_id = $account_detail_status->{'account_detail_status_id'},
		account_detail_status_name = $account_detail_status->{'account_detail_status_name'}               
		WHERE account_detail_status_id = $account_detail_status->{'account_detail_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_detail_status
{
my $id = shift;

my $statement = "DELETE FROM account_detail_status
                 WHERE account_detail_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
