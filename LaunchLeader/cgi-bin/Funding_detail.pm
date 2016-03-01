sub select_funding_details
{
   my $where = shift;

   my $statement = "SELECT 
   funding_details.funding_details_id,funding_details.account_funder_id,funding_details.account_id,funding_details.element_id,
   funding_details.fund_amount,funding_details.funding_details_datetime
   
	FROM funding_details
         $where ";

   $funding_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_funding
{
   $funding_detail = HFetch($funding_detail_sth);

   return $funding_detail->{'funding_details_id'} ne "";
}

=begin
sub select_total_funding_detail_byuser
{
    myt $account_id = shift;
    
   my $statement = " SELECT 
       SUM(funding_details.fund_amount) as total_fund,
       account_funder.account_funder_name,
       account_funder.account_funder_id
   FROM funding_details, account_funder
   WHERE 
    funding_details.account_id = '$account_id' AND 
    account_funder.account_funder_id = funding_details.account_funder_id 
   
   GROUP BY funding_details.account_funder_id
   ORDER BY total_fund DESC
		 ";
         
   my $sth = Execute($statement,$dbh);
   $funder_detail = HFetchone($sth);
   return $funder_detail->{'account_funder_id'} ne "";
}
=cut

sub select_funding_detail
{
   my $eid = shift;
   my $aid = shift;

   my $statement = "SELECT 
  funding_details.funding_details_id,funding_details.account_funder_id,funding_details.account_id,funding_details.element_id,
   funding_details.fund_amount,funding_details.funding_details_datetime
   	FROM funding_details
                 WHERE element_id = $eid AND
                 account_id = $aid
		 ";
   my $sth = Execute($statement,$dbh);

   $funding_detail = HFetchone($sth);

   return $funding_detail->{'funding_details_id'} ne "";
}

sub select_funder_detail_by_user_and_element
{
   my $uid = shift;
   my $anonymous = shift || 0;
   
   my $sql_str = "AND funding_details.funding_details_anonymous = '0' GROUP BY account_funder_id,element_id";   
   $sql_str = "AND funding_details.funding_details_anonymous = '1'" if($anonymous == 1);

   my $statement = "SELECT 
   funding_details.funding_details_id,funding_details.account_funder_id,funding_details.account_id,funding_details.element_id,
   funding_details.fund_amount,funding_details.funding_details_anonymous, funding_details.funding_details_datetime,
   account_funder.account_funder_name, 
   account_funder.account_funder_avatar, 
   account_funder.account_funder_name,
   account_funder.account_funder_email
   FROM funding_details, account_funder
   WHERE 
   funding_details.account_id = '$uid' 	AND 
   account_funder.account_funder_id = funding_details.account_funder_id    
   $sql_str
   ";

   $funding_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub select_funder_detail_by_user
{
   my $uid = shift;
   my $byname = shift;
   my $order_by = shift;
   my $byname_str = "";
   
   my $order_str = "funding_details.account_funder_id, funding_details.funding_details_datetime";
   $order_str = "funding_details.funding_details_id" if($order_by eq 'DATE');
   
   if($byname ne ''){
	$byname_str = " AND account_funder.account_funder_name LIKE '%$byname%'";
   }
   my $statement = "SELECT 
   funding_details.funding_details_id,funding_details.account_funder_id,funding_details.account_id,funding_details.element_id,
   funding_details.fund_amount,funding_details.funding_details_datetime,
   account_funder.account_funder_name, 
   account_funder.account_funder_avatar, 
   account_funder.account_funder_name,
   account_funder.account_funder_email
   FROM funding_details, account_funder
   WHERE 
   funding_details.account_id = '$uid' AND 
   account_funder.account_funder_id = funding_details.account_funder_id 
   $byname_str 
   ORDER BY $order_str
   ";
		 

   $funding_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_funder_details
{
   $funding_detail = HFetch($funding_detail_sth);

   return $funding_detail->{'funding_details_id'} ne "";
}


sub select_funder_detail_by_id
{
   my $WHERE = shift;
   my $statement = "SELECT account_funder.account_funder_id, account_funder.account_funder_name, account_funder.account_funder_avatar, account_funder.account_funder_social_id,	account_funder.account_funder_username,	account_funder.account_funder_email FROM account_funder $WHERE ";
   $funder_detail_sth = Execute($statement,$dbh);
   print STDERR $statement if($DEBUG);
   return;
}

sub next_funder_detail_byid
{
   $funder_detail = HFetch($funder_detail_sth);
   return $funder_detail->{'account_funder_id	'} ne "";
}

sub total_funded
{
   my $WHERE = shift;

   my $statement = "SELECT SUM(fund_amount / 100) FROM funding_details, element_detail
	         $WHERE AND 
             funding_details.account_id = element_detail.account_id AND
             funding_details.element_id = element_detail.element_id AND
             element_detail.element_detail_status = 1 
             ";
			    
   Execute($statement,$dbh);

   my $sum = Fetchone(Execute($statement,$dbh));	          
	
   return $sum;
	  
}

sub total_funders
{
   my $WHERE = shift;

   my $statement = "SELECT COUNT(DISTINCT account_funder_id) FROM funding_details, element_detail
	         $WHERE AND 
             funding_details.account_id = element_detail.account_id AND
             funding_details.element_id = element_detail.element_id AND
             element_detail.element_detail_status = 1 
            ";
			    
   Execute($statement,$dbh);

   my $count = Fetchone(Execute($statement,$dbh));	          
	
   return $count;
	  
}


sub card_already_processed
{
   my $aID = shift;
   my $eID = shift;
   my $status = shift;

   my $statement = "SELECT COUNT(fund_disbursed_id) as count FROM fund_disbursed
             WHERE 
             fund_disbursed.account_id = '$aID' AND
             fund_disbursed.element_id = '$eID' AND
             fund_disbursed.disburse_status = '$status' AND
             fund_disbursed.fund_disbursed_status = '1'
            ";
			    
   Execute($statement,$dbh);

   my $count = Fetchone(Execute($statement,$dbh));	          
	
   return $count;
	  
}

sub last_application_fee
{
   my $aID = shift;
   my $eID = shift;

   my $statement = "select application_fee FROM fund_disbursed 
     WHERE 
   element_id='$eID' AND 
   account_id = '$aID' AND 
   fund_disbursed_status = '1' LIMIT 1";
			    
   Execute($statement,$dbh);

   my $application_fee = Fetchone(Execute($statement,$dbh));	          
	
   return $application_fee;
	  
}


sub pledge_count
{
   my $aID = shift;
   my $eID = shift;

   my $statement = "SELECT COUNT(funding_details_id) as count FROM funding_details
             WHERE 
             funding_details.account_id = '$aID' AND
             funding_details.element_id = '$eID'
            ";
			    
   Execute($statement,$dbh);

   my $count = Fetchone(Execute($statement,$dbh));	          
	
   return $count;
	  
}


=begin 

To find all launchleader funders ID

=cut
sub find_launchleader_funders
{
   my $WHERE = shift;

   my $statement = "SELECT GROUP_CONCAT(account_funder_id) FROM account_funder 
    $WHERE ";
			    
   Execute($statement,$dbh);

   my $llbackers = Fetchone(Execute($statement,$dbh));	          
	
   return $llbackers;
	  
}



sub first_funding_date
{
   my $account_id = shift;
   my $element_id = shift;

   my $statement = "SELECT funding_milestones_datetime FROM funding_milestones
	         WHERE account_id='$account_id' AND element_id = '$element_id'";
			    
   Execute($statement,$dbh);

   my $first_funding_date = Fetchone(Execute($statement,$dbh));	          
	
   return $first_funding_date;
	  
}

sub first_funding_date_by_account
{
   my $account_id = shift;
   

   my $statement = "SELECT MIN(funding_milestones_datetime) FROM funding_milestones
	         WHERE account_id='$account_id' ";
			    
   Execute($statement,$dbh);

   my $first_funding_date = Fetchone(Execute($statement,$dbh));	          
	
   return $first_funding_date;
	  
}

sub funding_group_by_date
{
   my $account_id = shift;
   my $element_id = shift || 0;
   my $element_str = '';
   
   $element_str = "AND funding_details.element_id = '$element_id'" if($element_id);

   my $statement = "select SUM(fund_amount)/100 as fund_amount_total ,  DATE(funding_details_datetime) as date  
                from funding_details , element_detail 
                WHERE funding_details.account_id='$account_id'
                $element_str AND           
                funding_details.account_id = element_detail.account_id AND
                funding_details.element_id = element_detail.element_id AND
                element_detail.element_detail_status = 1 
                GROUP BY date ";

   $funding_group_by_date_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_funding_group_by_date
{
   $funding_group_by_date = HFetch($funding_group_by_date_sth);

   return $funding_group_by_date->{'fund_amount_total'} ne "";
}
1;
