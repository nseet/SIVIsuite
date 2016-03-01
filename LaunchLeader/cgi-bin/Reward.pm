sub read_reward
{

   $reward->{'reward_id'} = clean('int', $_query->param('reward_id'));
   $reward->{'reward_name'} = $_query->param('reward_name');
   $reward->{'reward_desc'} = $_query->param('reward_desc');
   $reward->{'reward_note'} = $_query->param('reward_note');
   $reward->{'reward_by'} = $_query->param('reward_by');
   $reward->{'reward_url'} = $_query->param('reward_url');
   $reward->{'reward_category'} = $_query->param('reward_category');
   $reward->{'reward_points'} = clean('int', $_query->param('reward_points'));
   $reward->{'reward_value'} = clean('int', $_query->param('reward_value'));
   $reward->{'reward_added'} = $_query->param('reward_added');
   $reward->{'reward_expires'} = $_query->param('reward_expires');
   $reward->{'reward_type'} = clean('int', $_query->param('reward_type'));
   $reward->{'reward_status'} = clean('int', $_query->param('reward_status'));

   return;
}

sub select_rewards
{
   my $where = shift;

   my $statement = "SELECT
reward.reward_id,reward.reward_name,reward.reward_desc,reward.reward_note,reward.reward_by,reward.reward_url,reward.reward_category,reward.reward_points,reward.reward_value,reward.reward_added,reward.reward_expires,reward.reward_type,reward.reward_status         
	FROM reward
         $where";

   $reward_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_reward
{
   $reward = HFetch($reward_sth);

   return $reward->{'reward_id'} ne "";
}

sub select_reward
{
   my $id = shift;

   my $statement = "SELECT 
reward_id,reward_name,reward_desc,reward_note,reward_by,reward_url,reward_category,reward_points,reward_value,reward_added,reward_expires,reward_type,reward_status                 
		FROM reward
                 WHERE reward_id = $id";
   my $sth = Execute($statement,$dbh);

   $reward = HFetchone($sth);

   return $reward->{'reward_id'} ne "";
}

sub insert_reward
{
   $reward->{'reward_name'} = $dbh->quote($reward->{'reward_name'});
   $reward->{'reward_desc'} = $dbh->quote($reward->{'reward_desc'});
   $reward->{'reward_note'} = $dbh->quote($reward->{'reward_note'});
   $reward->{'reward_by'} = $dbh->quote($reward->{'reward_by'});
   $reward->{'reward_url'} = $dbh->quote($reward->{'reward_url'});
   $reward->{'reward_category'} = $dbh->quote($reward->{'reward_category'});

   my $statement = "INSERT INTO reward ( 
reward_id,reward_name,reward_desc,reward_note,reward_by,reward_url,reward_category,reward_points,reward_value,reward_added,reward_expires,reward_type,reward_status
	)
	VALUES (
$reward->{'reward_id'},$reward->{'reward_name'},$reward->{'reward_desc'},$reward->{'reward_note'},$reward->{'reward_by'},$reward->{'reward_url'},$reward->{'reward_category'},$reward->{'reward_points'},$reward->{'reward_value'},NOW(),NOW(),$reward->{'reward_type'},$reward->{'reward_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(reward_id) FROM reward";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_reward
{
    my $setstr = shift;
    my $statement;

   $reward->{'reward_name'} = $dbh->quote($reward->{'reward_name'});
   $reward->{'reward_desc'} = $dbh->quote($reward->{'reward_desc'});
   $reward->{'reward_note'} = $dbh->quote($reward->{'reward_note'});
   $reward->{'reward_by'} = $dbh->quote($reward->{'reward_by'});
   $reward->{'reward_url'} = $dbh->quote($reward->{'reward_url'});
   $reward->{'reward_category'} = $dbh->quote($reward->{'reward_category'});

    if($setstr)
      {  $statement = "UPDATE reward SET $setstr WHERE reward_id = $reward->{'reward_id'}";  }
    else
      {
        $statement = "UPDATE reward SET
		reward_id = $reward->{'reward_id'},
		reward_name = $reward->{'reward_name'},
		reward_desc = $reward->{'reward_desc'},
		reward_note = $reward->{'reward_note'},
		reward_by = $reward->{'reward_by'},
		reward_url = $reward->{'reward_url'},
		reward_category = $reward->{'reward_category'},
		reward_points = $reward->{'reward_points'},
		reward_value = $reward->{'reward_value'},
		reward_added = NOW(),
		reward_expires = NOW(),
		reward_type = $reward->{'reward_type'},
		reward_status = $reward->{'reward_status'}               
		WHERE reward_id = $reward->{'reward_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_reward
{
my $id = shift;

my $statement = "DELETE FROM reward
                 WHERE reward_id = $id";

Execute($statement,$dbh);

return;
}

1;
