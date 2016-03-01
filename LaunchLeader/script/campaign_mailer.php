<?php

require_once '../social/dbconfig.php'; 
require_once '../social/pconfig.php';
/*
select * from  funding_details group by account_id, element_id order by funding_details_datetime;

Find element_amount using element_id  X

Find element fund using element_id and account_id  Y

find earliest payment date :: DATE_A
if( deadline_crossed && Y < X) 
	Lets shoot an email
	
*/

$EXECUTE = 0;

if($EXECUTE){

    $default_milestone = DEFAULT_MILESTONE;
    #$filterStr = " WHERE funding_failure_emailed = '0'  AND funding_milestones_id = 19 ";
    $filterStr = " WHERE funding_failure_emailed = '0' ";
    $result1 = mysql_query("select* from funding_milestones $filterStr ") or die("mysql error @ ___funding_milestones___");
    while($row1 = mysql_fetch_array($result1)){
        $funding_milestones_id= $row1['funding_milestones_id'];
        $funding_milestones_datetime= $row1['funding_milestones_datetime'];
        $aID = $row1['account_id'];
        $eID = $row1['element_id'];
        
        $todate = date("Y-m-d H:i:s");
        $daydiff = $default_milestone + 1 - floor( (strtotime($todate) - strtotime($funding_milestones_datetime))/(3600*24) );
        list ($campaignAmount, $campaignRaised) = getCampaignAmount($eID, $aID);
    
        if($campaignRaised < $campaignAmount && $daydiff <= 0){
            ## Campaign Failed
                $result2 = mysql_query("select funding_details_id, account_funder_id, fund_amount from funding_details where element_id='$eID' AND account_id = '$aID'") or die("mysql error @ ___");
                
                while($row2 = mysql_fetch_array($result2)){
                        $funding_details_id = $row2['funding_details_id'];
                        $account_funder_id = $row2['account_funder_id'];
                        $fund_amount = $row2['fund_amount'];
                        #$funding_details_datetime= $row2['funding_details_datetime'];
                        list ($fullName, $email) = getDonorFullName($account_funder_id);
                        sendMailToDonor($fullName, $email, $fund_amount/100, $aID, getCampaignName($eID));
                }
                sendMailToEntrepreneur('', $email, $campaignRaised, $aID, getCampaignName($eID));
                $result = mysql_query("UPDATE funding_milestones SET funding_failure_emailed = '1' WHERE funding_milestones_id = '$funding_milestones_id' ") or die("mysql error updating funding_milestones_mailed");            
        }
       else{
            ##Successful Campaign
            continue;
        }
    }
}
function sendMailToDonor($fullName, $email,$amount, $userid, $campaign_name){

$from_address = FROM_EMAIL_ADDRESS; 
$bcc_address = SIVI_ADMIN_EMAIL;
$to = $email;
global $funding_for;

$server = 'https://'.$_SERVER['HTTP_HOST'];

list($first_name, $last_name, $username, $account_email) = getAccountDetails($userid);
$name_of_project = getProjectName($userid);
#$name_of_campaign

$subject = "Unfortunately, $first_name $last_name was Not Successfully Funded on LaunchLeader";
$message = "<html><body>
Hi $fullName,<br> 
<br>
Thank you for pledging to donate to $campaign_name for <a href=\"$server/profile?u=$username\">$name_of_project</a> by $first_name $last_name.<br>
<br>
Unfortunately, this campaign did not reach its funding goal by the deadline. Because<br>
campaigns on LaunchLeader must reach their minimum goal in order to receive funding, your pledge of<br>
\$$amount USD has been cancelled and your credit card will not be charged.<br>
<br>
Even though this campaign did not reach its goal, your show of support is still highly appreciated.<br>
Entrepreneurship is about overcoming small failures to achieve overall success. We encourage you<br>
to continue showing your support by going back to the <a href=\"$server/profile?u=$username\">project page</a> and making another campaign pledge,<br>
providing feedback and sharing with your community.<br>
<br>
Thanks again,<br>
<br>
The LaunchLeader Team<br>
</body></html>
";
//     'Reply-To: webmaster@example.com' . "\r\n" .

$headers = "From: $from_address" . "\r\n";
$headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
if($bcc_address != "") $headers .= "Bcc: $bcc_address\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

mail($to, $subject, $message, $headers);
}

function sendMailToEntrepreneur($user_id, $email,$amount, $user_id, $campaign_name){

$from_address = FROM_EMAIL_ADDRESS; 
$bcc_address = SIVI_ADMIN_EMAIL;

$to = $email;
global $funding_for, $pledged, $pledgegoal;

$so_far_pledged = $pledged + $amount;

$server = 'https://'.$_SERVER['HTTP_HOST'];

list($first_name, $last_name, $username, $account_email) = getAccountDetails($user_id);
$name_of_project = getProjectName($user_id);
$email = $account_email;
#$name_of_campaign
#$subject = "New Donation Alert! $fullName Just Pledged \$$amount USD to $name_of_project on LaunchLeader";

$subject = "Unfortunately, $first_name $last_name, Your Campaign was Not Successfully Funded on LaunchLeader";
$message = "<html><body>
Hi $first_name,<br> 
<br>
Thank you for creating your $campaign_name campaign for <a href=\"$server/profile?u=$username\">$name_of_project</a>. <br>
Unfortunately, this campaign did not reach its funding goal by the deadline. Because campaigns on LaunchLeader<br>
must reach their minimum goal in order to receive funding, your donation pledges of \$$amount USD have been<br>
cancelled and your donor's credit cards will not be charged<br>
<br>
Even though this campaign did not reach its goal, your entrepreneurial spirit is still highly appreciated.<br>
Entrepreneurship is about overcoming small failures to achieve overall success. We encourage you to<br>
continue engaging your community by going back to the <a href=\"$server/profile?u=$username\">project page</a> and creating new campaigns,<br>
updating your profile and posting updates.<br><br>
As always, please <a href=\mailto:support@launchleader.com\">let us know</a> if there’s anything we can do to help!<br>
<br>
Best wishes!<br>
<br>
 The LaunchLeader Team<br>
</body></html>
";
//     'Reply-To: webmaster@example.com' . "\r\n" .

$headers = "From: $from_address" . "\r\n";
$headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
if($bcc_address != "") $headers .= "Bcc: $bcc_address\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

mail($to, $subject, $message, $headers);
}


function getCampaignAmount($element_id, $account_id){
  	$result = mysql_query("select element_amount  from element where element_id='$element_id'") or die("mysql error@ getCampaignAmount");
	$row = mysql_fetch_row($result);
    $campaignAmount = $row[0];

  	$result = mysql_query("select sum(fund_amount) AS funded_total  from funding_details where element_id='$element_id' AND account_id = '$account_id'  ") or die("mysql error@ getCampaignAmount");
	$row = mysql_fetch_row($result);
    $campaignRaised = $row[0];

    return array($campaignAmount, floor($campaignRaised / 100));
}

function getCampaignName($element_id){
  	$result = mysql_query("select element_name from element where element_id='$element_id'") or die("mysql error@ getCampaignName");
	$row = mysql_fetch_row($result);
    $campaign_name = $row[0];
    return $campaign_name;
}

function getAccountFunderId($account_funder_social_id){
  	$result = mysql_query("select account_funder_id from account_funder where account_funder_social_id='$account_funder_social_id'") or die("mysql error@ finding account funder id @ line # 207");
	$row = mysql_fetch_row($result);
    $account_funder_id = $row[0];
    return $account_funder_id;
}

function getProjectName($user_id){
  	$resultAD = mysql_query("SELECT account_detail_desc from account_detail WHERE account_id='$user_id' AND detail_id=36 AND account_detail_status=1 ORDER BY account_detail_id desc LIMIT 1") or die("mysql error@ getProjectName");
	$row = mysql_fetch_row($resultAD);
    $account_detail_desc = $row[0];
    
    return $account_detail_desc;

}

function getAccountDetails($user_id){
  	$result = mysql_query("select account_name_first,account_name_last,account_username, account_email from account where account_id='$user_id'") or die("mysql error@ getAccountDetails");
	$row = mysql_fetch_row($result);
    $first_name = $row[0];
    $last_name = $row[1];
    $username = $row[2];
    $email = $row[3];
    return array($first_name, $last_name, $username, $email);
}

function getDonorFullName($account_funder_id){
  	$result = mysql_query("select account_funder_name,account_funder_email from account_funder where account_funder_id='$account_funder_id'") or die("mysql error@ finding customer @ line getFullName");
	$row = mysql_fetch_row($result);
    $fullName = $row[0];
    $email = $row[1];
    return array($fullName,$email );
}


?>
