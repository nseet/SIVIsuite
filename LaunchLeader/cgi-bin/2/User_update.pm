sub read_user_update
{

   $user_update->{'user_update_id'} = clean('int', $_query->param('user_update_id'));
   $user_update->{'account_id'} = clean('int', $_query->param('account_id'));
   $user_update->{'campaign_id'} = clean('int', $_query->param('campaign_id'));
   $user_update->{'user_update_title'} = $_query->param('user_update_title');
   $user_update->{'user_update_text'} = $_query->param('user_update_text');
   $user_update->{'user_update_public'} = clean('int', $_query->param('user_update_public'));
   $user_update->{'user_update_sendemail'} = clean('int', $_query->param('user_update_sendemail'));
   $user_update->{'user_update_datetime'} = $_query->param('user_update_datetime');

   return;
}

sub select_user_updates
{
   my $where = shift;

   my $statement = "SELECT
user_update.user_update_id,user_update.account_id,user_update.campaign_id,user_update.user_update_title,user_update.user_update_text,user_update.user_update_public,user_update.user_update_sendemail,user_update.user_update_datetime         
	FROM user_update
         $where";

   $user_update_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_user_update
{
   $user_update = HFetch($user_update_sth);

   return $user_update->{'user_update_id'} ne "";
}

sub select_user_update
{
   my $id = shift;

   my $statement = "SELECT 
user_update_id,account_id,campaign_id,user_update_title,user_update_text,user_update_public,user_update_sendemail,user_update_datetime                 
		FROM user_update
                 WHERE user_update_id = $id";
   my $sth = Execute($statement,$dbh);

   $user_update = HFetchone($sth);

   return $user_update->{'user_update_id'} ne "";
}

sub insert_user_update
{
   $user_update->{'user_update_title'} = $dbh->quote($user_update->{'user_update_title'});
   $user_update->{'user_update_text'} = $dbh->quote($user_update->{'user_update_text'});

   my $statement = "INSERT INTO user_update ( 
user_update_id,account_id,campaign_id,user_update_title,user_update_text,user_update_public,user_update_sendemail,user_update_datetime
	)
	VALUES (
$user_update->{'user_update_id'},$user_update->{'account_id'},$user_update->{'campaign_id'},$user_update->{'user_update_title'},$user_update->{'user_update_text'},$user_update->{'user_update_public'},$user_update->{'user_update_sendemail'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(user_update_id) FROM user_update";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_user_update
{
    my $setstr = shift;
    my $statement;

   $user_update->{'user_update_title'} = $dbh->quote($user_update->{'user_update_title'});
   $user_update->{'user_update_text'} = $dbh->quote($user_update->{'user_update_text'});

    if($setstr)
      {  $statement = "UPDATE user_update SET $setstr WHERE user_update_id = $user_update->{'user_update_id'}";  }
    else
      {
        $statement = "UPDATE user_update SET
		user_update_id = $user_update->{'user_update_id'},
		account_id = $user_update->{'account_id'},
		campaign_id = $user_update->{'campaign_id'},
		user_update_title = $user_update->{'user_update_title'},
		user_update_text = $user_update->{'user_update_text'},
		user_update_public = $user_update->{'user_update_public'},
		user_update_sendemail = $user_update->{'user_update_sendemail'},
		user_update_datetime = NOW()               
		WHERE user_update_id = $user_update->{'user_update_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_user_update
{
my $id = shift;

my $statement = "DELETE FROM user_update
                 WHERE user_update_id = $id";

Execute($statement,$dbh);

return;
}

1;
