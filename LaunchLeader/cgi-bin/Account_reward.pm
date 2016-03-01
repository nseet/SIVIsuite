sub read_account_reward
{

   $account_reward->{'account_reward_id'} = clean('int', $_query->param('account_reward_id'));
   $account_reward->{'account_id'} = clean('int', $_query->param('account_id'));
   $account_reward->{'reward_id'} = clean('int', $_query->param('reward_id'));
   $account_reward->{'account_reward_added'} = $_query->param('account_reward_added');
   $account_reward->{'account_reward_status'} = clean('int', $_query->param('account_reward_status'));

   return;
}

sub select_account_rewards
{
   my $where = shift;

   my $statement = "SELECT
account_reward.account_reward_id,account_reward.account_id,account_reward.reward_id,account_reward.account_reward_added,account_reward.account_reward_status         
	FROM account_reward
         $where";

   $account_reward_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_reward
{
   $account_reward = HFetch($account_reward_sth);

   return $account_reward->{'account_reward_id'} ne "";
}

sub select_account_reward
{
   my $id = shift;

   my $statement = "SELECT 
account_reward_id,account_id,reward_id,account_reward_added,account_reward_status                 
		FROM account_reward
                 WHERE account_reward_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_reward = HFetchone($sth);

   return $account_reward->{'account_reward_id'} ne "";
}

sub insert_account_reward
{

   my $statement = "INSERT INTO account_reward ( 
account_reward_id,account_id,reward_id,account_reward_added,account_reward_status
	)
	VALUES (
$account_reward->{'account_reward_id'},$account_reward->{'account_id'},$account_reward->{'reward_id'},NOW(),$account_reward->{'account_reward_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_reward_id) FROM account_reward";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_reward
{
    my $setstr = shift;
    my $statement;


    if($setstr)
      {  $statement = "UPDATE account_reward SET $setstr WHERE account_reward_id = $account_reward->{'account_reward_id'}";  }
    else
      {
        $statement = "UPDATE account_reward SET
		account_reward_id = $account_reward->{'account_reward_id'},
		account_id = $account_reward->{'account_id'},
		reward_id = $account_reward->{'reward_id'},
		account_reward_added = NOW(),
		account_reward_status = $account_reward->{'account_reward_status'}               
		WHERE account_reward_id = $account_reward->{'account_reward_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_reward
{
my $id = shift;

my $statement = "DELETE FROM account_reward
                 WHERE account_reward_id = $id";

Execute($statement,$dbh);

return;
}

1;
