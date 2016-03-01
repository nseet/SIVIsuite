sub read_account_verification
{

   $account_verification->{'account_verification_id'} = clean('int', $_query->param('account_verification_id'));
   $account_verification->{'account_verification_username'} = $_query->param('account_verification_username');
   $account_verification->{'account_verification_token'} = $_query->param('account_verification_token');
   $account_verification->{'account_verification_taken'} = clean('int', $_query->param('account_verification_taken'));
   $account_verification->{'account_verification_expire'} = $_query->param('account_verification_expire');

   return;
}

sub select_account_verifications
{
   my $where = shift;

   my $statement = "SELECT
account_verification.account_verification_id,account_verification.account_verification_username,account_verification.account_verification_token,account_verification.account_verification_taken,account_verification.account_verification_expire         
	FROM account_verification
         $where";

   $account_verification_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_verification
{
   $account_verification = HFetch($account_verification_sth);

   return $account_verification->{'account_verification_id'} ne "";
}

sub select_account_verification
{
   my $id = shift;

   my $statement = "SELECT 
account_verification_id,account_verification_username,account_verification_token,account_verification_taken,account_verification_expire                 
		FROM account_verification
                 WHERE account_verification_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_verification = HFetchone($sth);

   return $account_verification->{'account_verification_id'} ne "";
}

sub insert_account_verification
{
   $account_verification->{'account_verification_username'} = $dbh->quote($account_verification->{'account_verification_username'});
   $account_verification->{'account_verification_token'} = $dbh->quote($account_verification->{'account_verification_token'});

   my $statement = "INSERT INTO account_verification ( 
account_verification_id,account_verification_username,account_verification_token,account_verification_taken,account_verification_expire
	)
	VALUES (
$account_verification->{'account_verification_id'},$account_verification->{'account_verification_username'},$account_verification->{'account_verification_token'},$account_verification->{'account_verification_taken'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_verification_id) FROM account_verification";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_verification
{
    my $setstr = shift;
    my $statement;

   $account_verification->{'account_verification_username'} = $dbh->quote($account_verification->{'account_verification_username'});
   $account_verification->{'account_verification_token'} = $dbh->quote($account_verification->{'account_verification_token'});

    if($setstr)
      {  $statement = "UPDATE account_verification SET $setstr WHERE account_verification_id = $account_verification->{'account_verification_id'}";  }
    else
      {
        $statement = "UPDATE account_verification SET
		account_verification_id = $account_verification->{'account_verification_id'},
		account_verification_username = $account_verification->{'account_verification_username'},
		account_verification_token = $account_verification->{'account_verification_token'},
		account_verification_taken = $account_verification->{'account_verification_taken'},
		account_verification_expire = NOW()               
		WHERE account_verification_id = $account_verification->{'account_verification_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_verification
{
my $id = shift;

my $statement = "DELETE FROM account_verification
                 WHERE account_verification_id = $id";

Execute($statement,$dbh);

return;
}

1;
