sub select_conversation
{
   my $conversation_email = shift;
   my $account_id = shift;

   my $statement = "SELECT 
    conversation_details.conversation_details_id,
    conversation_details.account_id,
    conversation_details.conversation_details_text,
    conversation_details.conversation_type,
    conversation_details.conversation_email,
    conversation_details.conversation_details_datetime
	FROM conversation_details
   WHERE conversation_details.conversation_email = '$conversation_email' AND 
   conversation_details.account_id = '$account_id'
   ORDER BY conversation_details_id ASC";

   $conversation_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_conversation
{
   $conversation = HFetch($conversation_detail_sth);

   return $conversation->{'conversation_details_id'} ne "";
}

sub insert_conversation_details
{
   $conversation->{'conversation_details_id'} = $dbh->quote($conversation->{'conversation_details_id'});
   $conversation->{'account_id'} = $dbh->quote($conversation->{'account_id'});
   $conversation->{'conversation_type'} = $dbh->quote($conversation->{'conversation_type'});
   $conversation->{'conversation_details_text'} = $dbh->quote($conversation->{'conversation_details_text'});
   $conversation->{'conversation_email'} = $dbh->quote($conversation->{'conversation_email'});

   my $statement = "INSERT INTO conversation_details ( 
        conversation_details_id,account_id,conversation_details_text,conversation_type,conversation_email,conversation_details_datetime
	)
	VALUES (
        $conversation->{'conversation_details_id'},$conversation->{'account_id'},$conversation->{'conversation_details_text'},$conversation->{'conversation_type'},$conversation->{'conversation_email'}, NOW()
	)";
   Execute($statement,$dbh);
   
   $statement = "SELECT max(conversation_details_id) FROM conversation_details";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub total_conversation
{
   my $email = shift;
   my $account_id = shift;

   my $statement = "SELECT COUNT(conversation_details_id) FROM conversation_details WHERE account_id = '$account_id' AND conversation_email = '$email' ";
			    
   Execute($statement,$dbh);
   print STDERR $statement."\n";

   my $count = Fetchone(Execute($statement,$dbh));	          
	
   return $count;
}


sub select_conversation_track
{
   my $funder_id = shift;
   my $account_id = shift;

   my $statement = "SELECT 
    conversation_track.conversation_track_id,
    conversation_track.account_id,
    conversation_track.funder_id,
    conversation_track.conversation_track_token,
    conversation_track.conversation_track_datetime
	FROM conversation_track
   WHERE conversation_track.account_id = '$account_id' AND 
   conversation_track.funder_id = '$funder_id'";

	$conversation_track_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_conversation_track
{
   $conversation_track = HFetch($conversation_track_sth);

   return $conversation_track->{'conversation_track_id'} ne "";
}

sub insert_conversation_track
{
   $conversation_track->{'account_id'} = $dbh->quote($conversation_track->{'account_id'});
   $conversation_track->{'funder_id'} = $dbh->quote($conversation_track->{'funder_id'});
   $conversation_track->{'conversation_track_token'} = $dbh->quote($conversation_track->{'conversation_track_token'});

   my $statement = "INSERT INTO conversation_track ( 
      conversation_track.conversation_track_id,conversation_track.account_id, conversation_track.funder_id, conversation_track.conversation_track_token, conversation_track.conversation_track_datetime	
    )
	VALUES (
        '',$conversation_track->{'account_id'}, $conversation_track->{'funder_id'}, $conversation_track->{'conversation_track_token'}, NOW()
	)";
   Execute($statement,$dbh);
   
   $statement = "SELECT max(conversation_track_id) FROM conversation_track";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

1;
