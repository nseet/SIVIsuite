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
   $account->{'account_agree'} = clean('boolean', $_query->param('account_agree'));
   $account->{'account_created'} = $_query->param('account_created');
   $account->{'account_accessed'} = $_query->param('account_accessed');
   $account->{'account_type'} = clean('int', $_query->param('account_type'));
   $account->{'account_verified'} = clean('int', $_query->param('account_verified'));
   $account->{'account_status'} = clean('int', $_query->param('account_status'));
   $account->{'account_partnercrumb'} =  $_query->param('account_partnercrumb');

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


sub select_funded_accounts
{
   my $where = shift;

   my $statement = "SELECT
    account.account_id,account.account_username,account.account_password,account.account_name_first,account.account_name_last,account.account_phone,account.account_email,account.account_desc,account.account_note,account.account_agree,account.account_created,account.account_accessed,account.account_type,account.account_verified,account.account_status,account.account_partnercrumb         
	FROM account, funding_details
      $where
    AND account.account_id = funding_details.account_id 
    GROUP BY account.account_id    
    ORDER BY account_name_first ASC    
      ";

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
account_id,account_username,account_password,account_name_first,account_name_last,account_phone,account_email,account_desc,account_note,account_agree,account_created,account_accessed,account_verified,account_type,account_status,account_partnercrumb                 
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
account_id,account_username,account_password,account_name_first,account_name_last,account_phone,account_email,account_desc,account_note,account_agree,account_created,account_accessed,account_type,account_status, account_partnercrumb
	)
	VALUES (
$account->{'account_id'},$account->{'account_username'},$account->{'account_password'},$account->{'account_name_first'},$account->{'account_name_last'},$account->{'account_phone'},$account->{'account_email'},$account->{'account_desc'},$account->{'account_note'},$account->{'account_agree'},NOW(),NOW(),$account->{'account_type'},$account->{'account_status'},$account->{'account_partnercrumb'}
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

sub insert_account_verification
{
   $account_verification->{'account_verification_id'} = "NULL";
   $account_verification->{'account_verification_username'} = $dbh->quote($account_verification->{'account_verification_username'});
   $account_verification->{'account_verification_token'} = $dbh->quote($account_verification->{'account_verification_token'});
   $account_verification->{'account_verification_taken'} = 0;
   $account_verification->{'account_verification_expire'} = $dbh->quote($account_verification->{'account_verification_expire'});

   my $statement = "INSERT INTO account_verification ( account_verification_id,account_verification_username,account_verification_token,account_verification_taken,account_verification_expire)
	VALUES ('NULL', $account_verification->{'account_verification_username'}, $account_verification->{'account_verification_token'}, $account_verification->{'account_verification_taken'}, $account_verification->{'account_verification_expire'})";
	
   Execute($statement,$dbh);
   
   #print STDERR $statement ;
   #print  $statement ;

   $statement = "SELECT max(account_verification_id) FROM account_verification";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}


sub select_account_verification
{
   my $where = shift;

   my $statement = "SELECT
            account_verification_id FROM account_verification
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

sub insert_password_reset
{
   $password_reset->{'password_reset_id'} = "NULL";
   $password_reset->{'password_reset_username'} = $dbh->quote($password_reset->{'password_reset_username'});
   $password_reset->{'password_reset_token'} = $dbh->quote($password_reset->{'password_reset_token'});
   $password_reset->{'password_reset_taken'} = 0;
   $password_reset->{'password_reset_expire'} = $dbh->quote($password_reset->{'password_reset_expire'});

   my $statement = "INSERT INTO password_reset ( password_reset_id,password_reset_username,password_reset_token,password_reset_taken,password_reset_expire)
	VALUES ('NULL', $password_reset->{'password_reset_username'}, $password_reset->{'password_reset_token'}, $password_reset->{'password_reset_taken'}, $password_reset->{'password_reset_expire'})";
	
   Execute($statement,$dbh);
   
   #print STDERR $statement ;

   $statement = "SELECT max(password_reset_id) FROM password_reset";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}


sub select_account_partners
{
   my $where = shift || "WHERE 1";

   my $statement = "SELECT
		account_partner.account_partner_id, account_partner.account_partner_name, account_partner.account_partner_crumb, account_partner.account_partner_details, account_partner.account_partner_thumbnail, account_partner.account_partner_status
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

=begin
sub update_password_reset
{
    my $setstr = shift;
    my $statement;

   $password_reset->{'password_reset_username'} = $dbh->quote($password_reset->{'password_reset_username'});
   $password_reset->{'password_reset_token'} = $dbh->quote($password_reset->{'password_reset_token'});
   $password_reset->{'password_reset_taken'} =  $dbh->quote($password_reset->{'password_reset_taken'});
   $password_reset->{'password_reset_expire'} = $dbh->quote($password_reset->{'password_reset_expire'});

    if($setstr)
      {  $statement = "UPDATE password_reset SET $setstr WHERE password_reset_id = $password_reset->{'password_reset_id'}";  }
    else
      {
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub select_password_reset
{
   my $where = shift;

   my $statement = "SELECT
            password_reset_id,  password_reset_username, password_reset_token, password_reset_taken, password_reset_expire datetime	FROM password_reset
         $where";

   $password_reset_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_password_reset
{
   $account = HFetch($account_sth);

   return $password_reset->{'password_reset_id'} ne "";
}
=cut
1;
