sub read_reward_type
{

   $reward_type->{'reward_type_id'} = clean('int', $_query->param('reward_type_id'));
   $reward_type->{'reward_type_name'} = $_query->param('reward_type_name');

   return;
}

sub select_reward_types
{
   my $where = shift;

   my $statement = "SELECT
reward_type.reward_type_id,reward_type.reward_type_name         
	FROM reward_type
         $where";

   $reward_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_reward_type
{
   $reward_type = HFetch($reward_type_sth);

   return $reward_type->{'reward_type_id'} ne "";
}

sub select_reward_type
{
   my $id = shift;

   my $statement = "SELECT 
reward_type_id,reward_type_name                 
		FROM reward_type
                 WHERE reward_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $reward_type = HFetchone($sth);

   return $reward_type->{'reward_type_id'} ne "";
}

sub insert_reward_type
{
   $reward_type->{'reward_type_name'} = $dbh->quote($reward_type->{'reward_type_name'});

   my $statement = "INSERT INTO reward_type ( 
reward_type_id,reward_type_name
	)
	VALUES (
$reward_type->{'reward_type_id'},$reward_type->{'reward_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(reward_type_id) FROM reward_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_reward_type
{
    my $setstr = shift;
    my $statement;

   $reward_type->{'reward_type_name'} = $dbh->quote($reward_type->{'reward_type_name'});

    if($setstr)
      {  $statement = "UPDATE reward_type SET $setstr WHERE reward_type_id = $reward_type->{'reward_type_id'}";  }
    else
      {
        $statement = "UPDATE reward_type SET
		reward_type_id = $reward_type->{'reward_type_id'},
		reward_type_name = $reward_type->{'reward_type_name'}               
		WHERE reward_type_id = $reward_type->{'reward_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_reward_type
{
my $id = shift;

my $statement = "DELETE FROM reward_type
                 WHERE reward_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
