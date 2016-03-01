sub read_account_status
{

   $account_status->{'account_status_id'} = clean('int', $_query->param('account_status_id'));
   $account_status->{'account_status_name'} = $_query->param('account_status_name');

   return;
}

sub select_account_statuss
{
   my $where = shift;

   my $statement = "SELECT
account_status.account_status_id,account_status.account_status_name         
	FROM account_status
         $where";

   $account_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_status
{
   $account_status = HFetch($account_status_sth);

   return $account_status->{'account_status_id'} ne "";
}

sub select_account_status
{
   my $id = shift;

   my $statement = "SELECT 
account_status_id,account_status_name                 
		FROM account_status
                 WHERE account_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_status = HFetchone($sth);

   return $account_status->{'account_status_id'} ne "";
}

sub insert_account_status
{
   $account_status->{'account_status_name'} = $dbh->quote($account_status->{'account_status_name'});

   my $statement = "INSERT INTO account_status ( 
account_status_id,account_status_name
	)
	VALUES (
$account_status->{'account_status_id'},$account_status->{'account_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_status_id) FROM account_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_status
{
    my $setstr = shift;
    my $statement;

   $account_status->{'account_status_name'} = $dbh->quote($account_status->{'account_status_name'});

    if($setstr)
      {  $statement = "UPDATE account_status SET $setstr WHERE account_status_id = $account_status->{'account_status_id'}";  }
    else
      {
        $statement = "UPDATE account_status SET
		account_status_id = $account_status->{'account_status_id'},
		account_status_name = $account_status->{'account_status_name'}               
		WHERE account_status_id = $account_status->{'account_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_status
{
my $id = shift;

my $statement = "DELETE FROM account_status
                 WHERE account_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
