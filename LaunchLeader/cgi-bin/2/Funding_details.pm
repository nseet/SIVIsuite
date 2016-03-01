sub read_funding_details
{

   $funding_details->{'funding_details_id'} = clean('int', $_query->param('funding_details_id'));
   $funding_details->{'account_funder_id'} = clean('int', $_query->param('account_funder_id'));
   $funding_details->{'account_id'} = clean('int', $_query->param('account_id'));
   $funding_details->{'element_id'} = clean('int', $_query->param('element_id'));
   $funding_details->{'fund_amount'} = clean('int', $_query->param('fund_amount'));
   $funding_details->{'funding_details_anonymous'} = clean('int', $_query->param('funding_details_anonymous'));
   $funding_details->{'funding_details_status'} = clean('int', $_query->param('funding_details_status'));
   $funding_details->{'funding_details_datetime'} = $_query->param('funding_details_datetime');

   return;
}

sub select_funding_detailss
{
   my $where = shift;

   my $statement = "SELECT
funding_details.funding_details_id,funding_details.account_funder_id,funding_details.account_id,funding_details.element_id,funding_details.fund_amount,funding_details.funding_details_anonymous,funding_details.funding_details_status,funding_details.funding_details_datetime         
	FROM funding_details
         $where";

   $funding_details_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_funding_details
{
   $funding_details = HFetch($funding_details_sth);

   return $funding_details->{'funding_details_id'} ne "";
}

sub select_funding_details
{
   my $id = shift;

   my $statement = "SELECT 
funding_details_id,account_funder_id,account_id,element_id,fund_amount,funding_details_anonymous,funding_details_status,funding_details_datetime                 
		FROM funding_details
                 WHERE funding_details_id = $id";
   my $sth = Execute($statement,$dbh);

   $funding_details = HFetchone($sth);

   return $funding_details->{'funding_details_id'} ne "";
}

sub insert_funding_details
{

   my $statement = "INSERT INTO funding_details ( 
funding_details_id,account_funder_id,account_id,element_id,fund_amount,funding_details_anonymous,funding_details_status,funding_details_datetime
	)
	VALUES (
$funding_details->{'funding_details_id'},$funding_details->{'account_funder_id'},$funding_details->{'account_id'},$funding_details->{'element_id'},$funding_details->{'fund_amount'},$funding_details->{'funding_details_anonymous'},$funding_details->{'funding_details_status'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(funding_details_id) FROM funding_details";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_funding_details
{
    my $setstr = shift;
    my $statement;


    if($setstr)
      {  $statement = "UPDATE funding_details SET $setstr WHERE funding_details_id = $funding_details->{'funding_details_id'}";  }
    else
      {
        $statement = "UPDATE funding_details SET
		funding_details_id = $funding_details->{'funding_details_id'},
		account_funder_id = $funding_details->{'account_funder_id'},
		account_id = $funding_details->{'account_id'},
		element_id = $funding_details->{'element_id'},
		fund_amount = $funding_details->{'fund_amount'},
		funding_details_anonymous = $funding_details->{'funding_details_anonymous'},
		funding_details_status = $funding_details->{'funding_details_status'},
		funding_details_datetime = NOW()               
		WHERE funding_details_id = $funding_details->{'funding_details_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_funding_details
{
my $id = shift;

my $statement = "DELETE FROM funding_details
                 WHERE funding_details_id = $id";

Execute($statement,$dbh);

return;
}

1;
