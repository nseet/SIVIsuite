sub read_conversation_track
{

   $conversation_track->{'conversation_track_id'} = clean('int', $_query->param('conversation_track_id'));
   $conversation_track->{'account_id'} = clean('int', $_query->param('account_id'));
   $conversation_track->{'funder_id'} = clean('int', $_query->param('funder_id'));
   $conversation_track->{'conversation_track_token'} = $_query->param('conversation_track_token');
   $conversation_track->{'conversation_track_datetime'} = $_query->param('conversation_track_datetime');

   return;
}

sub select_conversation_tracks
{
   my $where = shift;

   my $statement = "SELECT
conversation_track.conversation_track_id,conversation_track.account_id,conversation_track.funder_id,conversation_track.conversation_track_token,conversation_track.conversation_track_datetime         
	FROM conversation_track
         $where";

   $conversation_track_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_conversation_track
{
   $conversation_track = HFetch($conversation_track_sth);

   return $conversation_track->{'conversation_track_id'} ne "";
}

sub select_conversation_track
{
   my $id = shift;

   my $statement = "SELECT 
conversation_track_id,account_id,funder_id,conversation_track_token,conversation_track_datetime                 
		FROM conversation_track
                 WHERE conversation_track_id = $id";
   my $sth = Execute($statement,$dbh);

   $conversation_track = HFetchone($sth);

   return $conversation_track->{'conversation_track_id'} ne "";
}

sub insert_conversation_track
{
   $conversation_track->{'conversation_track_token'} = $dbh->quote($conversation_track->{'conversation_track_token'});

   my $statement = "INSERT INTO conversation_track ( 
conversation_track_id,account_id,funder_id,conversation_track_token,conversation_track_datetime
	)
	VALUES (
$conversation_track->{'conversation_track_id'},$conversation_track->{'account_id'},$conversation_track->{'funder_id'},$conversation_track->{'conversation_track_token'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(conversation_track_id) FROM conversation_track";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_conversation_track
{
    my $setstr = shift;
    my $statement;

   $conversation_track->{'conversation_track_token'} = $dbh->quote($conversation_track->{'conversation_track_token'});

    if($setstr)
      {  $statement = "UPDATE conversation_track SET $setstr WHERE conversation_track_id = $conversation_track->{'conversation_track_id'}";  }
    else
      {
        $statement = "UPDATE conversation_track SET
		conversation_track_id = $conversation_track->{'conversation_track_id'},
		account_id = $conversation_track->{'account_id'},
		funder_id = $conversation_track->{'funder_id'},
		conversation_track_token = $conversation_track->{'conversation_track_token'},
		conversation_track_datetime = NOW()               
		WHERE conversation_track_id = $conversation_track->{'conversation_track_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_conversation_track
{
my $id = shift;

my $statement = "DELETE FROM conversation_track
                 WHERE conversation_track_id = $id";

Execute($statement,$dbh);

return;
}

1;
