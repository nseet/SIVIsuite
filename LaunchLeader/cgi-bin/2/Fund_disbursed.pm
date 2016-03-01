sub read_fund_disbursed
{

   $fund_disbursed->{'fund_disbursed_id'} = clean('int', $_query->param('fund_disbursed_id'));
   $fund_disbursed->{'account_id'} = clean('int', $_query->param('account_id'));
   $fund_disbursed->{'project_id'} = clean('int', $_query->param('project_id'));
   $fund_disbursed->{'element_id'} = clean('int', $_query->param('element_id'));
   $fund_disbursed->{'fund_amount'} = clean('int', $_query->param('fund_amount'));
   $fund_disbursed->{'disburse_status'} = $_query->param('disburse_status');
   $fund_disbursed->{'application_fee'} = $_query->param('application_fee');
   $fund_disbursed->{'disburse_token'} = $_query->param('disburse_token');
   $fund_disbursed->{'funding_details_id'} = clean('int', $_query->param('funding_details_id'));
   $fund_disbursed->{'fund_disbursed_status'} = clean('int', $_query->param('fund_disbursed_status'));
   $fund_disbursed->{'fund_disbursed_datetime'} = $_query->param('fund_disbursed_datetime');

   return;
}

sub select_fund_disburseds
{
   my $where = shift;

   my $statement = "SELECT
fund_disbursed.fund_disbursed_id,fund_disbursed.account_id,fund_disbursed.project_id,fund_disbursed.element_id,fund_disbursed.fund_amount,fund_disbursed.disburse_status,fund_disbursed.application_fee,fund_disbursed.disburse_token,fund_disbursed.funding_details_id,fund_disbursed.fund_disbursed_status,fund_disbursed.fund_disbursed_datetime         
	FROM fund_disbursed
         $where";

   $fund_disbursed_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_fund_disbursed
{
   $fund_disbursed = HFetch($fund_disbursed_sth);

   return $fund_disbursed->{'fund_disbursed_id'} ne "";
}

sub select_fund_disbursed
{
   my $id = shift;

   my $statement = "SELECT 
fund_disbursed_id,account_id,project_id,element_id,fund_amount,disburse_status,application_fee,disburse_token,funding_details_id,fund_disbursed_status,fund_disbursed_datetime                 
		FROM fund_disbursed
                 WHERE fund_disbursed_id = $id";
   my $sth = Execute($statement,$dbh);

   $fund_disbursed = HFetchone($sth);

   return $fund_disbursed->{'fund_disbursed_id'} ne "";
}

sub insert_fund_disbursed
{
   $fund_disbursed->{'disburse_status'} = $dbh->quote($fund_disbursed->{'disburse_status'});
   $fund_disbursed->{'disburse_token'} = $dbh->quote($fund_disbursed->{'disburse_token'});

   my $statement = "INSERT INTO fund_disbursed ( 
fund_disbursed_id,account_id,project_id,element_id,fund_amount,disburse_status,application_fee,disburse_token,funding_details_id,fund_disbursed_status,fund_disbursed_datetime
	)
	VALUES (
$fund_disbursed->{'fund_disbursed_id'},$fund_disbursed->{'account_id'},$fund_disbursed->{'project_id'},$fund_disbursed->{'element_id'},$fund_disbursed->{'fund_amount'},$fund_disbursed->{'disburse_status'},$fund_disbursed->{'application_fee'},$fund_disbursed->{'disburse_token'},$fund_disbursed->{'funding_details_id'},$fund_disbursed->{'fund_disbursed_status'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(fund_disbursed_id) FROM fund_disbursed";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_fund_disbursed
{
    my $setstr = shift;
    my $statement;

   $fund_disbursed->{'disburse_status'} = $dbh->quote($fund_disbursed->{'disburse_status'});
   $fund_disbursed->{'disburse_token'} = $dbh->quote($fund_disbursed->{'disburse_token'});

    if($setstr)
      {  $statement = "UPDATE fund_disbursed SET $setstr WHERE fund_disbursed_id = $fund_disbursed->{'fund_disbursed_id'}";  }
    else
      {
        $statement = "UPDATE fund_disbursed SET
		fund_disbursed_id = $fund_disbursed->{'fund_disbursed_id'},
		account_id = $fund_disbursed->{'account_id'},
		project_id = $fund_disbursed->{'project_id'},
		element_id = $fund_disbursed->{'element_id'},
		fund_amount = $fund_disbursed->{'fund_amount'},
		disburse_status = $fund_disbursed->{'disburse_status'},
		application_fee = $fund_disbursed->{'application_fee'},
		disburse_token = $fund_disbursed->{'disburse_token'},
		funding_details_id = $fund_disbursed->{'funding_details_id'},
		fund_disbursed_status = $fund_disbursed->{'fund_disbursed_status'},
		fund_disbursed_datetime = NOW()               
		WHERE fund_disbursed_id = $fund_disbursed->{'fund_disbursed_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_fund_disbursed
{
my $id = shift;

my $statement = "DELETE FROM fund_disbursed
                 WHERE fund_disbursed_id = $id";

Execute($statement,$dbh);

return;
}

1;
