sub read_account_funder
{

   $account_funder->{'account_funder_id'} = clean('int', $_query->param('account_funder_id'));
   $account_funder->{'account_funder_name'} = $_query->param('account_funder_name');
   $account_funder->{'account_funder_avatar'} = $_query->param('account_funder_avatar');
   $account_funder->{'account_funder_social_id'} = $_query->param('account_funder_social_id');
   $account_funder->{'account_funder_username'} = $_query->param('account_funder_username');
   $account_funder->{'account_funder_password'} = $_query->param('account_funder_password');
   $account_funder->{'account_funder_email'} = $_query->param('account_funder_email');

   return;
}

sub select_account_funders
{
   my $where = shift;

   my $statement = "SELECT
account_funder.account_funder_id,account_funder.account_funder_name,account_funder.account_funder_avatar,account_funder.account_funder_social_id,account_funder.account_funder_username,account_funder.account_funder_password,account_funder.account_funder_email         
	FROM account_funder
         $where";

   $account_funder_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_funder
{
   $account_funder = HFetch($account_funder_sth);

   return $account_funder->{'account_funder_id'} ne "";
}

sub select_account_funder
{
   my $id = shift;

   my $statement = "SELECT 
account_funder_id,account_funder_name,account_funder_avatar,account_funder_social_id,account_funder_username,account_funder_password,account_funder_email                 
		FROM account_funder
                 WHERE account_funder_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_funder = HFetchone($sth);

   return $account_funder->{'account_funder_id'} ne "";
}

sub insert_account_funder
{
   $account_funder->{'account_funder_name'} = $dbh->quote($account_funder->{'account_funder_name'});
   $account_funder->{'account_funder_avatar'} = $dbh->quote($account_funder->{'account_funder_avatar'});
   $account_funder->{'account_funder_social_id'} = $dbh->quote($account_funder->{'account_funder_social_id'});
   $account_funder->{'account_funder_username'} = $dbh->quote($account_funder->{'account_funder_username'});
   $account_funder->{'account_funder_password'} = $dbh->quote($account_funder->{'account_funder_password'});
   $account_funder->{'account_funder_email'} = $dbh->quote($account_funder->{'account_funder_email'});

   my $statement = "INSERT INTO account_funder ( 
account_funder_id,account_funder_name,account_funder_avatar,account_funder_social_id,account_funder_username,account_funder_password,account_funder_email
	)
	VALUES (
$account_funder->{'account_funder_id'},$account_funder->{'account_funder_name'},$account_funder->{'account_funder_avatar'},$account_funder->{'account_funder_social_id'},$account_funder->{'account_funder_username'},$account_funder->{'account_funder_password'},$account_funder->{'account_funder_email'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_funder_id) FROM account_funder";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_funder
{
    my $setstr = shift;
    my $statement;

   $account_funder->{'account_funder_name'} = $dbh->quote($account_funder->{'account_funder_name'});
   $account_funder->{'account_funder_avatar'} = $dbh->quote($account_funder->{'account_funder_avatar'});
   $account_funder->{'account_funder_social_id'} = $dbh->quote($account_funder->{'account_funder_social_id'});
   $account_funder->{'account_funder_username'} = $dbh->quote($account_funder->{'account_funder_username'});
   $account_funder->{'account_funder_password'} = $dbh->quote($account_funder->{'account_funder_password'});
   $account_funder->{'account_funder_email'} = $dbh->quote($account_funder->{'account_funder_email'});

    if($setstr)
      {  $statement = "UPDATE account_funder SET $setstr WHERE account_funder_id = $account_funder->{'account_funder_id'}";  }
    else
      {
        $statement = "UPDATE account_funder SET
		account_funder_id = $account_funder->{'account_funder_id'},
		account_funder_name = $account_funder->{'account_funder_name'},
		account_funder_avatar = $account_funder->{'account_funder_avatar'},
		account_funder_social_id = $account_funder->{'account_funder_social_id'},
		account_funder_username = $account_funder->{'account_funder_username'},
		account_funder_password = $account_funder->{'account_funder_password'},
		account_funder_email = $account_funder->{'account_funder_email'}               
		WHERE account_funder_id = $account_funder->{'account_funder_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_funder
{
my $id = shift;

my $statement = "DELETE FROM account_funder
                 WHERE account_funder_id = $id";

Execute($statement,$dbh);

return;
}

1;
