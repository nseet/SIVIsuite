sub read_stripe_connect
{

   $stripe_connect->{'stripe_connect_id'} = clean('int', $_query->param('stripe_connect_id'));
   $stripe_connect->{'account_id'} = clean('int', $_query->param('account_id'));
   $stripe_connect->{'stripe_token_data'} = $_query->param('stripe_token_data');
   $stripe_connect->{'stripe_connect_datetime'} = $_query->param('stripe_connect_datetime');

   return;
}

sub select_stripe_connects
{
   my $where = shift;

   my $statement = "SELECT
stripe_connect.stripe_connect_id,stripe_connect.account_id,stripe_connect.stripe_token_data,stripe_connect.stripe_connect_datetime         
	FROM stripe_connect
         $where";

   $stripe_connect_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_stripe_connect
{
   $stripe_connect = HFetch($stripe_connect_sth);

   return $stripe_connect->{'stripe_connect_id'} ne "";
}

sub select_stripe_connect
{
   my $id = shift;

   my $statement = "SELECT 
stripe_connect_id,account_id,stripe_token_data,stripe_connect_datetime                 
		FROM stripe_connect
                 WHERE stripe_connect_id = $id";
   my $sth = Execute($statement,$dbh);

   $stripe_connect = HFetchone($sth);

   return $stripe_connect->{'stripe_connect_id'} ne "";
}

sub insert_stripe_connect
{
   $stripe_connect->{'stripe_token_data'} = $dbh->quote($stripe_connect->{'stripe_token_data'});

   my $statement = "INSERT INTO stripe_connect ( 
stripe_connect_id,account_id,stripe_token_data,stripe_connect_datetime
	)
	VALUES (
$stripe_connect->{'stripe_connect_id'},$stripe_connect->{'account_id'},$stripe_connect->{'stripe_token_data'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(stripe_connect_id) FROM stripe_connect";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_stripe_connect
{
    my $setstr = shift;
    my $statement;

   $stripe_connect->{'stripe_token_data'} = $dbh->quote($stripe_connect->{'stripe_token_data'});

    if($setstr)
      {  $statement = "UPDATE stripe_connect SET $setstr WHERE stripe_connect_id = $stripe_connect->{'stripe_connect_id'}";  }
    else
      {
        $statement = "UPDATE stripe_connect SET
		stripe_connect_id = $stripe_connect->{'stripe_connect_id'},
		account_id = $stripe_connect->{'account_id'},
		stripe_token_data = $stripe_connect->{'stripe_token_data'},
		stripe_connect_datetime = NOW()               
		WHERE stripe_connect_id = $stripe_connect->{'stripe_connect_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_stripe_connect
{
my $id = shift;

my $statement = "DELETE FROM stripe_connect
                 WHERE stripe_connect_id = $id";

Execute($statement,$dbh);

return;
}

1;
