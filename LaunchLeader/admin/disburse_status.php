<?php
require_once 'dbconfig.php'; 

if (isset($_GET['aID'])) {
    $aID = $_GET['aID'];
} 
if (isset($_GET['eID'])) {
    $eID = $_GET['eID'];
} 
if (isset($_GET['pID'])) {
    $project_id = $_GET['pID'];
} 

$table_content = "<table id=\"t01\">
  <tr>
    <th>Funder Name</th>
    <th>Pledged</th> 
    <th>Disburse/Authorized Date</th>
    <th>Disburse Status</th>
    <th>Pledge Status</th>
  </tr>
";

$table_element_content  = "";

## Here we are going to do all that stuff!!!
$gotDateDiff = 0;
$result = mysql_query("select fund_amount, disburse_status, application_fee, funding_details_id, fund_disbursed_datetime from fund_disbursed where element_id='$eID' AND account_id = '$aID' ORDER BY fund_disbursed_datetime") or die("mysql error @ 72");
while($row = mysql_fetch_row($result)){
    $fund_amount = number_format(round($row[0]/100), 2);
    $disburse_status = $row[1];
    $application_fee = $row[2];    
    $funding_details_id = $row[3];    
    $fund_disbursed_datetime = $row[4]; 
    if(!$gotDateDiff && $disburse_status == 'authorized') {
        $gotDateDiff = 1;
        $dateDiff = 0;
        $dateDiff =  round(( strtotime("now") - strtotime($fund_disbursed_datetime) )/86400);
    }
    
    list($funder_id, $funding_details_status) = getFunderDetails($funding_details_id);
    list($funder_name,$email)   = getFullName($funder_id);    
   $pledge_status = "Deleted";
   if($funding_details_status) $pledge_status = "Active";

   $table_element_content .= "
  <tr>
    <td>$funder_name</td>
    <td align=center>USD $fund_amount</td>
    <td align=center>$fund_disbursed_datetime</td>
    <td align=center>$disburse_status</td>
    <td align=center>$pledge_status</td>
  </tr>   
   ";  
}

$funding_count = getFundingDetailsCount($aID, $eID);

$stripeConnectToken = getStripeConnectToken($aID);
$stripeUserobj = json_decode($stripeConnectToken);
$stripeUserID = $stripeUserobj->{'stripe_user_id'};
    
$dateDiff  = $dateDiff * 1;
$funding_count = $funding_count *1;
$table_header = "<table width='400px' border=1 cellpadding=10 BORDERCOLOR=\"009900\">";
if($dateDiff) $table_header .= "<tr><td>Last Authorized</td><td>$dateDiff days ago </td></tr>";
if($application_fee) $table_header .= "<tr><td>Application Fee</td><td>&nbsp;&nbsp;$application_fee % </td></tr>";

$table_header .= "
<tr><td>Project ID </td><td>&nbsp;&nbsp;$aID </td></tr>
<tr><td>Campaign ID </td><td>&nbsp;&nbsp;$eID </td></tr>
<tr><td>Stripe Account ID </td><td>&nbsp;&nbsp;$stripeUserID </td></tr>
<tr><td>Pledge Count </td><td>&nbsp;&nbsp;$funding_count</td></tr>
</table>
";


print $table_header;
print "<br><br>";
if($table_element_content != '') {
    print $table_content;
    print $table_element_content;
    print "</table><br>";
}
exit;

#$ch = Stripe_Charge::retrieve({CHARGE_ID});
#$ch->capture();


function getFundingDetailsCount($aID, $eID){
	$result = mysql_query(" select count(*) as count from funding_details where element_id = '$eID' and account_id = '$aID' ") or die("mysql error @ getFundingDetailsCount");
	$row = mysql_fetch_row($result);
	$count = trim($row[0]);
	return $count;
}

function getStripeConnectToken($aID){
	$result = mysql_query("select stripe_token_data from stripe_connect where account_id='$aID'") or die("mysql error @ getStripeConnectToken");
	$row = mysql_fetch_row($result);
	$stripe_token_data = $row[0];
	return $stripe_token_data;
}

function getFunderSocialID($funder_id){
	$result = mysql_query("select account_funder_social_id from account_funder where account_funder_id='$funder_id'") or die("mysql error @ getFunderSocialID");
	$row = mysql_fetch_row($result);
	$account_funder_social_id = $row[0];
	return $account_funder_social_id;
}

function getFunderDetails($funding_details_id){
	$result = mysql_query("select account_funder_id,funding_details_status from funding_details where funding_details_id='$funding_details_id'") or die("mysql error @ getFunderDetails");
	$row = mysql_fetch_row($result);
	$account_funder_id = $row[0];
	$funding_details_status = $row[1];
	return array ($account_funder_id, $funding_details_status);
}

function getRaisedCampaignAmount($eID, $aID){
	$result = mysql_query("select sum(fund_amount / 100) from funding_details where element_id='$eID' AND account_id = '$aID'") or die("mysql error @ getRaisedCampaignAmount");
	$row = mysql_fetch_row($result);
	$raisedAmount = $row[0];
	return $raisedAmount;
}

function getCampaignAmount($eID){
	$result = mysql_query("select element_amount from element where element_id='$eID'") or die("mysql error @ getCampaignAmount");
	$row = mysql_fetch_row($result);
	$amount = $row[0];
	return $amount;
}

function getStripeCustomerId($account_funder_social_id){
  	$result = mysql_query("select customer_id from stripe_customers where account_funder_social_id='$account_funder_social_id'") or die("mysql erro @ getStripeCustomerId");
	$row = mysql_fetch_row($result);
	$customerId = $row[0];
	return $customerId;
}


function getAccountFunderId($account_funder_social_id){
  	$result = mysql_query("select account_funder_id from account_funder where account_funder_social_id='$account_funder_social_id'") or die("mysql error@ finding account funder id @ line # 207");
	$row = mysql_fetch_row($result);
    $account_funder_id = $row[0];
    return $account_funder_id;
}

function getAccountId($username){
  	$result = mysql_query("select account_id from account where account_username='$username'") or die("mysql error@ finding account_id @ line # getAccountId");
	$row = mysql_fetch_row($result);
    $account_id = $row[0];
    return $account_id;
}

function getProjectName($user_id){
  	$resultAD = mysql_query("SELECT account_detail_desc from account_detail WHERE account_id='$user_id' AND detail_id=36 AND account_detail_status=1 ORDER BY account_detail_id desc LIMIT 1") or die("mysql error@ getProjectName");
	$row = mysql_fetch_row($resultAD);
    $account_detail_desc = $row[0];    
    return $account_detail_desc;

}

function getAccountDetails($aID){
  	$result = mysql_query("select account_name_first,account_name_last, account_username, account_email from account where account_id='$aID'") or die("mysql error@ getAccountDetails");
	$row = mysql_fetch_row($result);
    $first_name = $row[0];
    $last_name = $row[1];
    $user_name = $row[2];
    $account_email = $row[3];
    return array($first_name, $last_name, $user_name, $account_email);
}


function getFullName($account_funder_id){
  	$result = mysql_query("select account_funder_name,account_funder_email from account_funder where account_funder_id='$account_funder_id'") or die("mysql error@ finding customer @ line getFullName");
	$row = mysql_fetch_row($result);
    $fullName = $row[0];
    $email = $row[1];
    return array($fullName,$email );
}

function getCampaignName($element_id) {
  	$result = mysql_query("select element_name from element where element_id='$element_id'") or die("mysql error@ finding customer @ line getCampaignName");
	$row = mysql_fetch_row($result);
    $campaign_name = $row[0];
    return $campaign_name;
}

?>
