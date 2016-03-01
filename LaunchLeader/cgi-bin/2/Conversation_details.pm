sub read_conversation_details
{

   $conversation_details->{'conversation_details_id'} = clean('int', $_query->param('conversation_details_id'));
   $conversation_details->{'account_id'} = clean('int', $_query->param('account_id'));
   $conversation_details->{'conversation_details_text'} = $_query->param('conversation_details_text');
   $conversation_details->{'conversation_type'} = clean('int', $_query->param('conversation_type'));
   $conversation_details->{'conversation_email'} = $_query->param('conversation_email');
   $conversation_details->{'conversation_details_datetime'} = $_query->param('conversation_details_datetime');

   return;
}

sub select_conversation_detailss
{
   my $where = shift;

   my $statement = "SELECT
conversation_details.conversation_details_id,conversation_details.account_id,conversation_details.conversation_details_text,conversation_details.conversation_type,conversation_details.conversation_email,conversation_details.conversation_details_datetime         
	FROM conversation_details
         $where";

   $conversation_details_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_conversation_details
{
   $conversation_details = HFetch($conversation_details_sth);

   return $conversation_details->{'conversation_details_id'} ne "";
}

sub select_conversation_details
{
   my $id = shift;

   my $statement = "SELECT 
conversation_details_id,account_id,conversation_details_text,conversation_type,conversation_email,conversation_details_datetime                 
		FROM conversation_details
                 WHERE conversation_details_id = $id";
   my $sth = Execute($statement,$dbh);

   $conversation_details = HFetchone($sth);

   return $conversation_details->{'conversation_details_id'} ne "";
}

sub insert_conversation_details
{
   $conversation_details->{'conversation_details_text'} = $dbh->quote($conversation_details->{'conversation_details_text'});
   $conversation_details->{'conversation_email'} = $dbh->quote($conversation_details->{'conversation_email'});

   my $statement = "INSERT INTO conversation_details ( 
conversation_details_id,account_id,conversation_details_text,conversation_type,conversation_email,conversation_details_datetime
	)
	VALUES (
$conversation_details->{'conversation_details_id'},$conversation_details->{'account_id'},$conversation_details->{'conversation_details_text'},$conversation_details->{'conversation_type'},$conversation_details->{'conversation_email'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(conversation_details_id) FROM conversation_details";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_conversation_details
{
    my $setstr = shift;
    my $statement;

   $conversation_details->{'conversation_details_text'} = $dbh->quote($conversation_details->{'conversation_details_text'});
   $conversation_details->{'conversation_email'} = $dbh->quote($conversation_details->{'conversation_email'});

    if($setstr)
      {  $statement = "UPDATE conversation_details SET $setstr WHERE conversation_details_id = $conversation_details->{'conversation_details_id'}";  }
    else
      {
        $statement = "UPDATE conversation_details SET
		conversation_details_id = $conversation_details->{'conversation_details_id'},
		account_id = $conversation_details->{'account_id'},
		conversation_details_text = $conversation_details->{'conversation_details_text'},
		conversation_type = $conversation_details->{'conversation_type'},
		conversation_email = $conversation_details->{'conversation_email'},
		conversation_details_datetime = NOW()               
		WHERE conversation_details_id = $conversation_details->{'conversation_details_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_conversation_details
{
my $id = shift;

my $statement = "DELETE FROM conversation_details
                 WHERE conversation_details_id = $id";

Execute($statement,$dbh);

return;
}

1;
