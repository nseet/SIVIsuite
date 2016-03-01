sub read_reward_status
{

   $reward_status->{'reward_status_id'} = clean('int', $_query->param('reward_status_id'));
   $reward_status->{'reward_status_name'} = $_query->param('reward_status_name');

   return;
}

sub select_reward_statuss
{
   my $where = shift;

   my $statement = "SELECT
reward_status.reward_status_id,reward_status.reward_status_name         
	FROM reward_status
         $where";

   $reward_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_reward_status
{
   $reward_status = HFetch($reward_status_sth);

   return $reward_status->{'reward_status_id'} ne "";
}

sub select_reward_status
{
   my $id = shift;

   my $statement = "SELECT 
reward_status_id,reward_status_name                 
		FROM reward_status
                 WHERE reward_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $reward_status = HFetchone($sth);

   return $reward_status->{'reward_status_id'} ne "";
}

sub insert_reward_status
{
   $reward_status->{'reward_status_name'} = $dbh->quote($reward_status->{'reward_status_name'});

   my $statement = "INSERT INTO reward_status ( 
reward_status_id,reward_status_name
	)
	VALUES (
$reward_status->{'reward_status_id'},$reward_status->{'reward_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(reward_status_id) FROM reward_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_reward_status
{
    my $setstr = shift;
    my $statement;

   $reward_status->{'reward_status_name'} = $dbh->quote($reward_status->{'reward_status_name'});

    if($setstr)
      {  $statement = "UPDATE reward_status SET $setstr WHERE reward_status_id = $reward_status->{'reward_status_id'}";  }
    else
      {
        $statement = "UPDATE reward_status SET
		reward_status_id = $reward_status->{'reward_status_id'},
		reward_status_name = $reward_status->{'reward_status_name'}               
		WHERE reward_status_id = $reward_status->{'reward_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_reward_status
{
my $id = shift;

my $statement = "DELETE FROM reward_status
                 WHERE reward_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
