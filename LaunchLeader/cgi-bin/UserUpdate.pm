
sub select_user_updates
{
   my $where = shift;

   my $statement = "SELECT 
		 user_update.user_update_id, user_update.account_id, user_update.campaign_id, user_update.user_update_title, user_update.user_update_text, 
		 user_update.user_update_public, user_update.user_update_datetime, user_update.user_update_sendemail
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
   my $account_id = shift;
   my $update_id = shift;

   my $statement = "SELECT 
		 user_update.user_update_id, user_update.account_id, user_update.campaign_id, user_update.user_update_title, user_update.user_update_text, 
		 user_update.user_update_public, user_update.user_update_datetime, user_update.user_update_sendemail
   	FROM user_update
                 WHERE user_update_id = $update_id AND
                 account_id = $account_id 
		 ";
   my $sth = Execute($statement,$dbh);

   $user_update = HFetchone($sth);

   return $user_update->{'user_update_id'} ne "";
}

sub insert_user_update
{
   $user_update->{'user_update_id'} = $dbh->quote($user_update->{'user_update_id'});
   $user_update->{'campaign_id'} = $dbh->quote($user_update->{'campaign_id'});
   $user_update->{'account_id'} = $dbh->quote($user_update->{'account_id'});
   $user_update->{'user_update_title'} = $dbh->quote($user_update->{'user_update_title'});
   $user_update->{'user_update_text'} = $dbh->quote($user_update->{'user_update_text'});   
   $user_update->{'user_update_public'} = $dbh->quote($user_update->{'user_update_public'});
   $user_update->{'user_update_sendemail'} = $dbh->quote($user_update->{'user_update_sendemail'});
   #$user_update->{'user_update_datetime'} = $dbh->quote($user_update->{'user_update_datetime'});

   my $statement = "INSERT INTO user_update ( 
		user_update_id,campaign_id,account_id,user_update_title, user_update_text, user_update_public,user_update_sendemail,user_update_datetime
		)
	VALUES (
   $user_update->{'user_update_id'}, $user_update->{'campaign_id'}, $user_update->{'account_id'},$user_update->{'user_update_title'}, $user_update->{'user_update_text'}, $user_update->{'user_update_public'}, $user_update->{'user_update_sendemail'}, $user_update->{'user_update_datetime'}
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
    
   $user_update->{'user_update_id'} = $dbh->quote($user_update->{'user_update_id'});
   $user_update->{'campaign_id'} = $dbh->quote($user_update->{'campaign_id'});
   $user_update->{'account_id'} = $dbh->quote($user_update->{'account_id'});
   $user_update->{'user_update_title'} = $dbh->quote($user_update->{'user_update_title'});   
   $user_update->{'user_update_text'} = $dbh->quote($user_update->{'user_update_text'});   
   $user_update->{'user_update_public'} = $dbh->quote($user_update->{'user_update_public'});
   $user_update->{'user_update_sendemail'} = $dbh->quote($user_update->{'user_update_sendemail'});
   #$user_update->{'user_update_datetime'} = $dbh->quote($user_update->{'user_update_datetime'});

    if($setstr)
      {  $statement = "UPDATE user_update SET $setstr WHERE user_update_id = $user_update->{'user_update_id'}";  }
    else
      {
        $statement = "UPDATE user_update SET
               user_update_title = $user_update->{'user_update_title'},
               user_update_text = $user_update->{'user_update_text'},
               user_update_public = $user_update->{'user_update_public'},
               user_update_sendemail = $user_update->{'user_update_sendemail'},
               user_update_datetime = $user_update->{'user_update_datetime'}
        WHERE user_update_id = $user_update->{'user_update_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_user_update
{
my $update_id = shift;

my $statement = "DELETE FROM user_update
                 WHERE user_update_id = $update_id";

Execute($statement,$dbh);

return;
}


sub select_completed_tools
{
   my $where = shift;

   my $statement = "SELECT completed_tools.completed_tools_id, completed_tools.account_id, completed_tools.project_id,completed_tools.element_id,completed_tools.completed_tools_title, completed_tools.completed_tools_url,completed_tools.completed_tools_datetime FROM completed_tools
        $where
		 ";
   $completed_tools_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_completed_tools
{
   $completed_tools = HFetch($completed_tools_sth);

   return $completed_tools->{'completed_tools_id'} ne "";
}


sub insert_completed_tools
{
   $completed_tools->{'completed_tools_id'} = $dbh->quote($completed_tools->{'completed_tools_id'});
   $completed_tools->{'project_id'} = $dbh->quote($completed_tools->{'project_id'});
   $completed_tools->{'account_id'} = $dbh->quote($completed_tools->{'account_id'});
   $completed_tools->{'element_id'} = $dbh->quote($completed_tools->{'element_id'});
   $completed_tools->{'completed_tools_title'} = $dbh->quote($completed_tools->{'completed_tools_title'});
   $completed_tools->{'completed_tools_url'} = $dbh->quote($completed_tools->{'completed_tools_url'});   
   $completed_tools->{'completed_tools_datetime'} = "NOW()";   

   my $statement = "INSERT INTO completed_tools ( 
		completed_tools_id,project_id,element_id, account_id,completed_tools_title, completed_tools_url, completed_tools_datetime
		)
	VALUES (
   $completed_tools->{'completed_tools_id'}, $completed_tools->{'project_id'},$completed_tools->{'element_id'}, $completed_tools->{'account_id'}, 
   $completed_tools->{'completed_tools_title'}, $completed_tools->{'completed_tools_url'}, $completed_tools->{'completed_tools_datetime'}
   )";
   Execute($statement,$dbh);

   $statement = "SELECT max(completed_tools_id) FROM completed_tools";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_completed_tools
{
    my $setstr = shift;
    my $statement;
    
   $completed_tools->{'completed_tools_id'} = $dbh->quote($completed_tools->{'completed_tools_id'});
   $completed_tools->{'project_id'} = $dbh->quote($completed_tools->{'project_id'});
   $completed_tools->{'account_id'} = $dbh->quote($completed_tools->{'account_id'});
   $completed_tools->{'completed_tools_title'} = $dbh->quote($completed_tools->{'completed_tools_title'});
   $completed_tools->{'completed_tools_url'} = $dbh->quote($completed_tools->{'completed_tools_url'});   

    if($setstr)
      {  $statement = "UPDATE completed_tools SET $setstr WHERE completed_tools_id = $completed_tools->{'completed_tools_id'}";  }
    else
      {
        $statement = "UPDATE completed_tools SET
               completed_tools_title = $completed_tools->{'completed_tools_title'},
               completed_tools_url = $completed_tools->{'completed_tools_url'},
               completed_tools_datetime = $completed_tools->{'completed_tools_datetime'}
        WHERE completed_tools_id = $completed_tools->{'completed_tools_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub insert_email_disburse
{
   $email_disburse->{'email_disburse_id'} = $dbh->quote($email_disburse->{'email_disburse_id'});
   $email_disburse->{'email_type'} = $dbh->quote($email_disburse->{'email_type'});
   $email_disburse->{'email_disburse_ref'} = $dbh->quote($email_disburse->{'email_disburse_ref'});
   $email_disburse->{'email_disburse_status'} = $dbh->quote($email_disburse->{'email_disburse_status'});
#   $email_disburse->{'email_disburse_datetime'} = $dbh->quote($email_disburse->{'email_disburse_datetime'});   

   my $statement = "INSERT INTO email_disburse ( 
    email_disburse_id, email_type, email_disburse_ref, email_disburse_status, email_disburse_datetime
		)
	VALUES (
    $email_disburse->{'email_disburse_id'}, $email_disburse->{'email_type'}, $email_disburse->{'email_disburse_ref'}, $email_disburse->{'email_disburse_status'}, $email_disburse->{'email_disburse_datetime'}
   )";
   Execute($statement,$dbh);

   $statement = "SELECT max(email_disburse_id) FROM email_disburse";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}


sub select_subscriber_by_user
{
   my $account_id = shift;
   my $project_id = shift;

   my $statement = "SELECT 
                    subscriber.subscriber_id,subscriber.account_id, subscriber.project_id, subscriber.subscriber_email, subscriber.subscriber_status, subscriber.subscriber_datetime
                 FROM subscriber
                    WHERE account_id = '$account_id' AND
                    project_id = '$project_id' 
		 ";
         
   $select_subscriber_sth = Execute($statement,$dbh);
   
   print STDERR $statement if($DEBUG);
   return;
}


sub next_subscriber
{
   $subscriber = HFetch($select_subscriber_sth);

   return $subscriber->{'subscriber_id'} ne "";
}
1;
