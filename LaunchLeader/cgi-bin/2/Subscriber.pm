sub read_subscriber
{

   $subscriber->{'subscriber_id'} = clean('int', $_query->param('subscriber_id'));
   $subscriber->{'account_id'} = clean('int', $_query->param('account_id'));
   $subscriber->{'project_id'} = clean('int', $_query->param('project_id'));
   $subscriber->{'subscriber_email'} = $_query->param('subscriber_email');
   $subscriber->{'subscriber_status'} = clean('int', $_query->param('subscriber_status'));
   $subscriber->{'subscriber_datetime'} = $_query->param('subscriber_datetime');

   return;
}

sub select_subscribers
{
   my $where = shift;

   my $statement = "SELECT
subscriber.subscriber_id,subscriber.account_id,subscriber.project_id,subscriber.subscriber_email,subscriber.subscriber_status,subscriber.subscriber_datetime         
	FROM subscriber
         $where";

   $subscriber_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_subscriber
{
   $subscriber = HFetch($subscriber_sth);

   return $subscriber->{'subscriber_id'} ne "";
}

sub select_subscriber
{
   my $id = shift;

   my $statement = "SELECT 
subscriber_id,account_id,project_id,subscriber_email,subscriber_status,subscriber_datetime                 
		FROM subscriber
                 WHERE subscriber_id = $id";
   my $sth = Execute($statement,$dbh);

   $subscriber = HFetchone($sth);

   return $subscriber->{'subscriber_id'} ne "";
}

sub insert_subscriber
{
   $subscriber->{'subscriber_email'} = $dbh->quote($subscriber->{'subscriber_email'});

   my $statement = "INSERT INTO subscriber ( 
subscriber_id,account_id,project_id,subscriber_email,subscriber_status,subscriber_datetime
	)
	VALUES (
$subscriber->{'subscriber_id'},$subscriber->{'account_id'},$subscriber->{'project_id'},$subscriber->{'subscriber_email'},$subscriber->{'subscriber_status'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(subscriber_id) FROM subscriber";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_subscriber
{
    my $setstr = shift;
    my $statement;

   $subscriber->{'subscriber_email'} = $dbh->quote($subscriber->{'subscriber_email'});

    if($setstr)
      {  $statement = "UPDATE subscriber SET $setstr WHERE subscriber_id = $subscriber->{'subscriber_id'}";  }
    else
      {
        $statement = "UPDATE subscriber SET
		subscriber_id = $subscriber->{'subscriber_id'},
		account_id = $subscriber->{'account_id'},
		project_id = $subscriber->{'project_id'},
		subscriber_email = $subscriber->{'subscriber_email'},
		subscriber_status = $subscriber->{'subscriber_status'},
		subscriber_datetime = NOW()               
		WHERE subscriber_id = $subscriber->{'subscriber_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_subscriber
{
my $id = shift;

my $statement = "DELETE FROM subscriber
                 WHERE subscriber_id = $id";

Execute($statement,$dbh);

return;
}

1;
