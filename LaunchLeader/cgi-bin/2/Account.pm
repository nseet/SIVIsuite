sub read_account
{

   $account->{'account_id'} = clean('int', $_query->param('account_id'));
   $account->{'account_username'} = $_query->param('account_username');
   $account->{'account_password'} = $_query->param('account_password');
   $account->{'account_name_first'} = $_query->param('account_name_first');
   $account->{'account_name_last'} = $_query->param('account_name_last');
   $account->{'account_phone'} = $_query->param('account_phone');
   $account->{'account_email'} = $_query->param('account_email');
   $account->{'account_desc'} = $_query->param('account_desc');
   $account->{'account_note'} = $_query->param('account_note');
   $account->{'account_agree'} = clean('int', $_query->param('account_agree'));
   $account->{'account_created'} = $_query->param('account_created');
   $account->{'account_accessed'} = $_query->param('account_accessed');
   $account->{'account_type'} = clean('int', $_query->param('account_type'));
   $account->{'account_verified'} = clean('int', $_query->param('account_verified'));
   $account->{'account_status'} = clean('int', $_query->param('account_status'));
   $account->{'account_partnercrumb'} = $_query->param('account_partnercrumb');

   return;
}

sub select_accounts
{
   my $where = shift;

   my $statement = "SELECT
account.account_id,account.account_username,account.account_password,account.account_name_first,account.account_name_last,account.account_phone,account.account_email,account.account_desc,account.account_note,account.account_agree,account.account_created,account.account_accessed,account.account_type,account.account_verified,account.account_status,account.account_partnercrumb         
	FROM account
         $where";

   $account_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account
{
   $account = HFetch($account_sth);

   return $account->{'account_id'} ne "";
}

sub select_account
{
   my $id = shift;

   my $statement = "SELECT 
account_id,account_username,account_password,account_name_first,account_name_last,account_phone,account_email,account_desc,account_note,account_agree,account_created,account_accessed,account_type,account_verified,account_status,account_partnercrumb                 
		FROM account
                 WHERE account_id = $id";
   my $sth = Execute($statement,$dbh);

   $account = HFetchone($sth);

   return $account->{'account_id'} ne "";
}

sub insert_account
{
   $account->{'account_username'} = $dbh->quote($account->{'account_username'});
   $account->{'account_password'} = $dbh->quote($account->{'account_password'});
   $account->{'account_name_first'} = $dbh->quote($account->{'account_name_first'});
   $account->{'account_name_last'} = $dbh->quote($account->{'account_name_last'});
   $account->{'account_phone'} = $dbh->quote($account->{'account_phone'});
   $account->{'account_email'} = $dbh->quote($account->{'account_email'});
   $account->{'account_desc'} = $dbh->quote($account->{'account_desc'});
   $account->{'account_note'} = $dbh->quote($account->{'account_note'});
   $account->{'account_partnercrumb'} = $dbh->quote($account->{'account_partnercrumb'});

   my $statement = "INSERT INTO account ( 
account_id,account_username,account_password,account_name_first,account_name_last,account_phone,account_email,account_desc,account_note,account_agree,account_created,account_accessed,account_type,account_verified,account_status,account_partnercrumb
	)
	VALUES (
$account->{'account_id'},$account->{'account_username'},$account->{'account_password'},$account->{'account_name_first'},$account->{'account_name_last'},$account->{'account_phone'},$account->{'account_email'},$account->{'account_desc'},$account->{'account_note'},$account->{'account_agree'},NOW(),NOW(),$account->{'account_type'},$account->{'account_verified'},$account->{'account_status'},$account->{'account_partnercrumb'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_id) FROM account";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account
{
    my $setstr = shift;
    my $statement;

   $account->{'account_username'} = $dbh->quote($account->{'account_username'});
   $account->{'account_password'} = $dbh->quote($account->{'account_password'});
   $account->{'account_name_first'} = $dbh->quote($account->{'account_name_first'});
   $account->{'account_name_last'} = $dbh->quote($account->{'account_name_last'});
   $account->{'account_phone'} = $dbh->quote($account->{'account_phone'});
   $account->{'account_email'} = $dbh->quote($account->{'account_email'});
   $account->{'account_desc'} = $dbh->quote($account->{'account_desc'});
   $account->{'account_note'} = $dbh->quote($account->{'account_note'});
   $account->{'account_partnercrumb'} = $dbh->quote($account->{'account_partnercrumb'});

    if($setstr)
      {  $statement = "UPDATE account SET $setstr WHERE account_id = $account->{'account_id'}";  }
    else
      {
        $statement = "UPDATE account SET
		account_id = $account->{'account_id'},
		account_username = $account->{'account_username'},
		account_password = $account->{'account_password'},
		account_name_first = $account->{'account_name_first'},
		account_name_last = $account->{'account_name_last'},
		account_phone = $account->{'account_phone'},
		account_email = $account->{'account_email'},
		account_desc = $account->{'account_desc'},
		account_note = $account->{'account_note'},
		account_agree = $account->{'account_agree'},
		account_created = NOW(),
		account_accessed = NOW(),
		account_type = $account->{'account_type'},
		account_verified = $account->{'account_verified'},
		account_status = $account->{'account_status'},
		account_partnercrumb = $account->{'account_partnercrumb'}               
		WHERE account_id = $account->{'account_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account
{
my $id = shift;

my $statement = "DELETE FROM account
                 WHERE account_id = $id";

Execute($statement,$dbh);

return;
}

1;
