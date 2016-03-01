sub read_conversation_type
{

   $conversation_type->{'conversation_type_id'} = clean('int', $_query->param('conversation_type_id'));
   $conversation_type->{'conversation_type_name'} = $_query->param('conversation_type_name');

   return;
}

sub select_conversation_types
{
   my $where = shift;

   my $statement = "SELECT
conversation_type.conversation_type_id,conversation_type.conversation_type_name         
	FROM conversation_type
         $where";

   $conversation_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_conversation_type
{
   $conversation_type = HFetch($conversation_type_sth);

   return $conversation_type->{'conversation_type_id'} ne "";
}

sub select_conversation_type
{
   my $id = shift;

   my $statement = "SELECT 
conversation_type_id,conversation_type_name                 
		FROM conversation_type
                 WHERE conversation_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $conversation_type = HFetchone($sth);

   return $conversation_type->{'conversation_type_id'} ne "";
}

sub insert_conversation_type
{
   $conversation_type->{'conversation_type_name'} = $dbh->quote($conversation_type->{'conversation_type_name'});

   my $statement = "INSERT INTO conversation_type ( 
conversation_type_id,conversation_type_name
	)
	VALUES (
$conversation_type->{'conversation_type_id'},$conversation_type->{'conversation_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(conversation_type_id) FROM conversation_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_conversation_type
{
    my $setstr = shift;
    my $statement;

   $conversation_type->{'conversation_type_name'} = $dbh->quote($conversation_type->{'conversation_type_name'});

    if($setstr)
      {  $statement = "UPDATE conversation_type SET $setstr WHERE conversation_type_id = $conversation_type->{'conversation_type_id'}";  }
    else
      {
        $statement = "UPDATE conversation_type SET
		conversation_type_id = $conversation_type->{'conversation_type_id'},
		conversation_type_name = $conversation_type->{'conversation_type_name'}               
		WHERE conversation_type_id = $conversation_type->{'conversation_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_conversation_type
{
my $id = shift;

my $statement = "DELETE FROM conversation_type
                 WHERE conversation_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
