sub select_stripe_connect
{
   my $where = shift;

   my $statement = "SELECT 
			stripe_connect_id, account_id, stripe_token_data, stripe_connect_datetime
		FROM stripe_connect
			$where";

   $stripe_connect_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_stripe_connect
{
   $stripe_connect_detail = HFetch($stripe_connect_sth);
   return $stripe_connect_detail->{'stripe_connect_id'} ne "";
}


sub insert_stripe_connect
{
   $stripe_connect_detail->{'stripe_connect_id'} = $dbh->quote($stripe_connect_detail->{'stripe_connect_id'});
   $stripe_connect_detail->{'account_id'} = $dbh->quote($stripe_connect_detail->{'account_id'});
   $stripe_connect_detail->{'stripe_token_data'} = $dbh->quote($stripe_connect_detail->{'stripe_token_data'});
   #$stripe_connect_detail->{'stripe_connect_datetime'} = ;

   my $statement = "INSERT INTO stripe_connect ( 
		stripe_connect_id,  account_id,  stripe_token_data,   stripe_connect_datetime
		)
	VALUES (
		$stripe_connect_detail->{'stripe_connect_id'},$stripe_connect_detail->{'account_id'},$stripe_connect_detail->{'stripe_token_data'},NOW()
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
    
   $stripe_connect_detail->{'stripe_connect_id'} = $dbh->quote($stripe_connect_detail->{'stripe_connect_id'});
   $stripe_connect_detail->{'account_id'} = $dbh->quote($stripe_connect_detail->{'account_id'});
   $stripe_connect_detail->{'stripe_token_data'} = $dbh->quote($stripe_connect_detail->{'stripe_token_data'});
   #$stripe_connect_detail->{'stripe_connect_datetime'} = $dbh->quote($stripe_connect_detail->{'stripe_connect_datetime'});

    if($setstr)
      {  $statement = "UPDATE stripe_connect SET $setstr WHERE account_id = $stripe_connect_detail->{'account_id'}";  }
    else
      {
        $statement = "UPDATE stripe_connect SET
        stripe_token_data = $stripe_connect_detail->{'stripe_token_data'},
        stripe_connect_datetime = NOW()
	
        WHERE account_id = $stripe_connect_detail->{'account_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

1;

