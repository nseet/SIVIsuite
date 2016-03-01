sub read_stripe_customers
{

   $stripe_customers->{'stripe_customers_id'} = clean('int', $_query->param('stripe_customers_id'));
   $stripe_customers->{'customer_id'} = $_query->param('customer_id');
   $stripe_customers->{'account_funder_social_id'} = $_query->param('account_funder_social_id');
   $stripe_customers->{'stripe_customers_datetime'} = $_query->param('stripe_customers_datetime');

   return;
}

sub select_stripe_customerss
{
   my $where = shift;

   my $statement = "SELECT
stripe_customers.stripe_customers_id,stripe_customers.customer_id,stripe_customers.account_funder_social_id,stripe_customers.stripe_customers_datetime         
	FROM stripe_customers
         $where";

   $stripe_customers_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_stripe_customers
{
   $stripe_customers = HFetch($stripe_customers_sth);

   return $stripe_customers->{'stripe_customers_id'} ne "";
}

sub select_stripe_customers
{
   my $id = shift;

   my $statement = "SELECT 
stripe_customers_id,customer_id,account_funder_social_id,stripe_customers_datetime                 
		FROM stripe_customers
                 WHERE stripe_customers_id = $id";
   my $sth = Execute($statement,$dbh);

   $stripe_customers = HFetchone($sth);

   return $stripe_customers->{'stripe_customers_id'} ne "";
}

sub insert_stripe_customers
{
   $stripe_customers->{'customer_id'} = $dbh->quote($stripe_customers->{'customer_id'});
   $stripe_customers->{'account_funder_social_id'} = $dbh->quote($stripe_customers->{'account_funder_social_id'});

   my $statement = "INSERT INTO stripe_customers ( 
stripe_customers_id,customer_id,account_funder_social_id,stripe_customers_datetime
	)
	VALUES (
$stripe_customers->{'stripe_customers_id'},$stripe_customers->{'customer_id'},$stripe_customers->{'account_funder_social_id'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(stripe_customers_id) FROM stripe_customers";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_stripe_customers
{
    my $setstr = shift;
    my $statement;

   $stripe_customers->{'customer_id'} = $dbh->quote($stripe_customers->{'customer_id'});
   $stripe_customers->{'account_funder_social_id'} = $dbh->quote($stripe_customers->{'account_funder_social_id'});

    if($setstr)
      {  $statement = "UPDATE stripe_customers SET $setstr WHERE stripe_customers_id = $stripe_customers->{'stripe_customers_id'}";  }
    else
      {
        $statement = "UPDATE stripe_customers SET
		stripe_customers_id = $stripe_customers->{'stripe_customers_id'},
		customer_id = $stripe_customers->{'customer_id'},
		account_funder_social_id = $stripe_customers->{'account_funder_social_id'},
		stripe_customers_datetime = NOW()               
		WHERE stripe_customers_id = $stripe_customers->{'stripe_customers_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_stripe_customers
{
my $id = shift;

my $statement = "DELETE FROM stripe_customers
                 WHERE stripe_customers_id = $id";

Execute($statement,$dbh);

return;
}

1;
