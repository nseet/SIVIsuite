<?php

/*
+------------------------------------------------------------------------------------------+
# STEP1:: Check whether its 100%^ funded or not: If not someone trying to pushing nose.
## Send an email to admin immediately

# STEP2:  Check whether already disbursed or not 

# STEP3:  Authorize The Fund

# STEP 4: If successfully can authorize everyone show that successfully authorize and 
put a button to release the fund

# STEP4 : Disable the Disburse Button

# STEP 5: Do not show the button at all on refresh.

+------------------------------------------------------------------------------------------+
*/

define('SIVI_ADMIN_EMAIL', 'admin@mydomain.com');
define('FROM_EMAIL_ADDRESS', 'info@mydomain.com');

require_once '../social/lib/Stripe.php';
require_once 'dbconfig.php'; 


$DEBUG = 0;

if (isset($_GET['aID'])) {
    $aID = $_GET['aID'];
} 
if (isset($_GET['eID'])) {
    $eID = $_GET['eID'];
} 
if (isset($_GET['pID'])) {
    $project_id = $_GET['pID'];
} 

if (isset($_GET['action'])) {
    $action = $_GET['action'];
} 
if (isset($_GET['application_fee'])) {
    $application_fee = $_GET['application_fee'];
} 
/*
print "action: $action\n";
print "eID: $eID\n";
print "aID: $aID";
print "application_fee: $application_fee\n";
exit;
*/
error_log ("action [$action]", 0);
// exit;
#$action = 'authorize';

$paid_this_time = 0;
$authorized_this_time = 0;
$declined_this_time = 0;

if($project_id == '')    $project_id = $aID;
if($application_fee == '')    $application_fee = 5;

## Find total campaign amount using element_id 
$totalCampaignAmount = getCampaignAmount($eID);

## Find raised amount using element_id and account_id
$raisedAmount = round(getRaisedCampaignAmount($eID, $aID));

if($raisedAmount < $totalCampaignAmount){
    ## Its time to Say Goodbye
    print "morphed";
    //sendMailToSIVI();
    exit;
}


if($DEBUG){
    print "raisedAmount: $raisedAmount\n";
    print "totalCampaignAmount: $totalCampaignAmount\n";
}

#reauthorize
#reauthorize_all
#force_disburse
#remove_declined

$force_disburse = 0;
$sql_str = "";

if($action == 'reauthorize'){
    $action = 'authorize';
    $query = "UPDATE fund_disbursed  SET fund_disbursed_status  = '0' WHERE  (disburse_status  = 'authfailed' OR  disburse_status  = 'declined' )  AND account_id = '$aID' AND element_id = '$eID' ";
    mysql_query($query) or die("mysql error @ reauthorize update");
    #print "reauthorized";
    #exit;
}
else if($action == 'reauthorize_all'){
    $action = 'authorize';
    $query = "UPDATE fund_disbursed  SET fund_disbursed_status  = '0' WHERE  disburse_status  != 'captured'  AND account_id = '$aID' AND element_id = '$eID' ";
    mysql_query($query) or die("mysql error @ reauthorize_all update");
    #print "reauthorized_all";
}

else if($action == 'remove_declined'){
    $if_deleted = 0;
   $result = mysql_query("select funding_details_id  from fund_disbursed where element_id='$eID' AND account_id = '$aID' AND fund_disbursed_status = '1' AND (disburse_status = 'declined' OR disburse_status = 'authfailed') ") or die("mysql error @ 72");
   while($row = mysql_fetch_row($result)){ 
        $funding_details_id = $row[0];
        $query = "UPDATE funding_details  SET funding_details_status  = '0' WHERE  funding_details_id  = '$funding_details_id'  AND account_id = '$aID' AND element_id = '$eID' ";
        mysql_query($query) or die("mysql error @ remove_declined update");    
        $if_deleted  = 1;
   }
  if($if_deleted) { print "removed"; }
  else{ print "not_removed"; }
  exit;
}
else if($action == 'force_disburse'){
 $action = 'capture';
 $force_disburse = 1;
}

## Here we are going to do all that stuff!!!
$result = mysql_query("select funding_details_id, account_funder_id, fund_amount from funding_details where element_id='$eID' AND account_id = '$aID' AND funding_details_status = '1' ") or die("mysql error @ 72");
while($row = mysql_fetch_row($result)){
    $funding_details_id = $row[0];
    $funder_id = $row[1];
    $fund_amount = $row[2];    
    $funder_sid = getFunderSocialID($funder_id);
    $customer_id = getStripeCustomerId($funder_sid);
    $card_token = getStripeTransactionToken($funding_details_id);
    $stripeConnectToken = getStripeConnectToken($aID);
    $applicable_fee = ($fund_amount * $application_fee / 100);
    
    $stripeUserobj = json_decode($stripeConnectToken);
    $stripeUserAccessToken = $stripeUserobj->{'access_token'};
    $errors = array();
    
    ## Find alreaddy disursed or not
    if(alreadyDisbursed($funding_details_id)){
        if($DEBUG) print "Already funded! Morphed Call!"; 
        error_log("Already funded! Morphed Call!");
        continue;
    }
    
    if($DEBUG){
        if($DEBUG)  print "alreadyDisbursed: $alreadyDisbursed\n";
    }
    $stripe_debug_print = " funder_id: $funder_id || fund_amount: $fund_amount || funding_details_id: $funding_details_id || funder_sid: $funder_sid\customer_id: $customer_id || stripeConnectToken: $stripeConnectToken || applicable_fee: $applicable_fee || stripeUserAccessToken: $stripeUserAccessToken || ";
    error_log($stripe_debug_print, 0);    
    error_log("card token [$card_token]", 0);

   if($DEBUG){
        print "funder_id: $funder_id\n";
        print "fund_amount: $fund_amount\n";
        print "funding_details_id: $funding_details_id\n";
        print "funder_sid: $funder_sid\n";
        print "customer_id: $customer_id\n";
        print "stripeConnectToken: $stripeConnectToken\n";
        print "applicable_fee: $applicable_fee\n";
        print "stripeUserAccessToken: $stripeUserAccessToken\n";
     }
    try{
    #exit;
   # Create Stripe Token for the user 
   
   if($card_token == ''){
	    $token =  Stripe_Token::create(
		array("customer" => $customer_id),
		$stripeUserAccessToken // user's access token from the Stripe Connect flow
	    );
	}
    else{
	    $token =  Stripe_Token::create(
		array("customer" => $customer_id, "card" => $card_token),
		$stripeUserAccessToken // user's access token from the Stripe Connect flow
	    );
    
    }
    error_log("TKCREATION: customer [$customer_id] card [$card_token]\n\n");
    $charge = array();


    #print_r($token);    
    if($DEBUG) { print"<br><br>";    print $token["id"];  }
    if($action == 'authorize'){
            error_log( "<<<<<<<<<<AUTHORIZED>>>>>>>>>>>>>.", 0);  
           // Authorize on Stripe's servers - this will authorize his card
            list ($charge_id,$authstatus)  = getPreviousTokenID($funding_details_id);
            if($authstatus == 'authorized') continue;
            
            $charge = Stripe_Charge::create(array(
                  "amount" => $fund_amount, // amount in cents
                  "currency" => "usd",
                  "card" => $token["id"],
                  "description" => "LaunchLeader Fund Disbursement",
                  "capture"  => "false",
                  "application_fee" => $applicable_fee // amount in cents
              ),
              $stripeUserAccessToken // user's access token from the Stripe Connect flow
            );   

            if($DEBUG){
                print "<<<<<<<<<<CHARGE >>>>>>>>>>>>>>>>>>.";
                print_r($charge);      print "\n\n";    print "\n\n";
                print $charge["captured"];        print "\n\n";    print "\n\n";
                print $charge["id"];
            }
            error_log( print_r($charge, true), 0);  
                    
            if( $charge["id"] != '' &&  ($charge["captured"] == '' or $charge["captured"] == 'false')){
                ##Save the Authorize Token Here   [authorized]      
                $query = "INSERT INTO fund_disbursed (fund_disbursed_id,account_id,project_id, element_id,fund_amount, disburse_status, application_fee, disburse_token,funding_details_id, fund_disbursed_datetime )
                VALUES ('', '$aID', '$aID', '$eID', '$fund_amount','authorized', '$application_fee', '".$charge["id"] ."', '$funding_details_id', NOW())";
                mysql_query($query) or die("mysql error @ insert authorize");
                $authorized_this_time++;
            }            
            
            else{
                ##Save the Authorize Token Here   [authfailed]
                $query = "INSERT INTO fund_disbursed (fund_disbursed_id,account_id,project_id, element_id,fund_amount, disburse_status, application_fee, disburse_token, fund_disbursed_datetime )
                VALUES ('', '$aID', '$aID', '$eID', '$fund_amount','authfailed', '$application_fee' , '".$charge["id"] ."', NOW())";
                mysql_query($query) or die("mysql error @ insert authfailed");
            }
    }
    else if($action == 'capture'){
        list ($charge_id,$authstatus)  = getAuthorizeTokenID($funding_details_id);
        error_log( "<<<<<charge_id [$charge_id]>>>>><<<<<authstatus [$authstatus]>>>>>", 0);  
        if($authstatus == 'authfailed' or $authstatus == 'declined') continue;

        if($charge_id != ''){
            Stripe::setApiKey($stripeUserAccessToken);
            $ch = Stripe_Charge::retrieve($charge_id);
            $charge = $ch->capture();
            
            if($DEBUG) {
                print_r($charge);    
                print_r($ch);
                print $ch['captured'];
            }
            if($charge['captured'] == 1 or $charge['captured'] == 'true'){
                    ## Update Status in database;
                    $query = "UPDATE fund_disbursed  SET disburse_status  = 'captured' WHERE funding_details_id = '$funding_details_id' AND disburse_token = '$charge_id' ";
                    mysql_query($query) or die("mysql error @ capture update");
                    $paid_this_time++;
                    
                    $query = "UPDATE element_detail  SET element_detail_disbursed = '1' WHERE element_id  = '$eID' AND account_id = '$aID' ";
                    mysql_query($query) or die("mysql error @ capture update");
                    
                    sendSuccessMailToDonor($funding_details_id, $fund_amount/100, $funder_id);
#                         sendSuccessMailToEntrepreneur($funding_details_id, $fund_amount/100, $funder_id);
            }
        }
        else{
            $errors['stripe'] = "Could not get Authorized Token ID for [$funding_details_id] \n";
        }
   } 
 }
	catch (Stripe_CardError $e) {
	    // Card was declined.
		$e_json = $e->getJsonBody();
		$err = $e_json['error'];
		$errors['stripe'] = $err['message'];
        $query = "INSERT INTO fund_disbursed (fund_disbursed_id,account_id,project_id, element_id,fund_amount, disburse_status, application_fee, disburse_token,funding_details_id, fund_disbursed_datetime )
                VALUES ('', '$aID', '$aID', '$eID', '$fund_amount','declined', '$application_fee', '', '$funding_details_id', NOW())";
        mysql_query($query) or die("mysql error @ insert declined");
        $declined_this_time++;           
        
        sendDeclinedMailToDonor($funding_details_id, $fund_amount/100, $funder_id);
        sendDeclinedMailToEntrepreneur($funding_details_id, $fund_amount/100, $funder_id);
        error_log( "<<<<<<<<<<<<CARD_ERROR>>>>>>>>>>>>", 0);  
        error_log( print_r($e, true), 0);  
        
	} catch (Stripe_ApiConnectionError $e) {
	    // Network problem, perhaps try again.
	    $errors['stripe'] = "Network problem, perhaps try again.";
	} catch (Stripe_InvalidRequestError $e) {
	    // You screwed up in your programming. Shouldn't happen!
	    $errors['stripe'] = "You screwed up in your programming. Shouldn't happen!";
	} catch (Stripe_ApiError $e) {
	    // Stripe's servers are down!
        $errors['stripe'] = "Stripe's servers are down!";
	} catch (Stripe_CardError $e) {
	    // Something else that's not the customer's fault.
		$errors['stripe'] =  "Something else that's not the customer's fault.";
	}
    // A user form submission error occurred, handled below.

    if($errors['stripe']  != '') {
        ##  print $errors['stripe'] ."\n";
        error_log($errors['stripe'] , 0); 
        ## print $errors['stripe']; 
        error_log( print_r($e, true), 0);
        #print "error";
    }
}

if($declined_this_time){
    refreshMilestone($aID, $eID);
}
$totalFundingCount = getFundingDetailsCount($aID, $eID);
$authorizedCount = getFundingDisbursedCount($aID, $eID,'authorized');
$capturedCount = getFundingDisbursedCount($aID, $eID,'captured');
$declinedCount = getFundingDisbursedCount($aID, $eID,'declined');
#print "[$totalFundingCount] [$authorizedCount] [$capturedCount] [$declinedCount]";
if($authorizedCount){
    if($authorizedCount < $totalFundingCount) print "authfailed";
    if($authorizedCount == $totalFundingCount) {
            if($authorized_this_time)  print "success_authorized_now";
            else  print "success_authorized";
    }
}
else if ($capturedCount){
   $mailSend = 0; 
  if($force_disburse && $capturedCount == ($totalFundingCount - $declinedCount) ) { 
    print "success_captured_now";
    $mailSend = 1;
  }
  else if($capturedCount == $totalFundingCount) {
    if($paid_this_time)  {
        print "success_captured_now";
        $mailSend = 1;
    }
     else  print "success_captured";
   }
   if($mailSend){
        sendSuccessMailToEntrepreneur();
    }
}

exit;

function sendSuccessMailToDonor($funding_details_id, $fund_amount, $funder_id){

    $from_address = FROM_EMAIL_ADDRESS; 
    $cc_address = SIVI_ADMIN_EMAIL;

    global $eID , $aID;

    $server = '//'.$_SERVER['HTTP_HOST'];

    list($first_name, $last_name, $username, $aemail, $pmode) = getAccountDetails($aID);
    $campaign_name = getCampaignName($eID);
    list($funder_name,$email) = getFullName($funder_id);

    $to = $email;

    $name_of_project = getProjectName($aID);
    #$name_of_campaign

    $subject = "Thanks to You, $first_name $last_name was Successfully Funded on LaunchLeader!";
    $message = "<html><body>
    Hi $funder_name,<br>
    <br>
    Congratulations! <br>
    <br>
    Thanks to you and other donors, $campaign_name for <a href=\"$server/profile?u=$username&pmode=$pmode\">$name_of_project</a><br>
    by $first_name $last_name was successfully funded on LaunchLeader!<br>
    <br>
    Stripe will now charge your credit card for the amount pledged: \$$fund_amount USD<br>
    <br>
    Go back to the <a href=\"$server/profile?u=$username&pmode=$pmode\">project page</a> to continue showing your support.<br>
    <br>
    Thanks again!<br>
    <br>
    The LaunchLeader Team<br>
    </body></html>
    ";
    //     'Reply-To: webmaster@example.com' . "\r\n" .

    $headers = "From: $from_address" . "\r\n";
    $headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
    if($cc_address != "") $headers .= "CC: $cc_address\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

    mail($to, $subject, $message, $headers);
    error_log ("Email sent to Donor [$to]\n", 0);
}

function sendSuccessMailToEntrepreneur(){
    $from_address = FROM_EMAIL_ADDRESS; 
    $cc_address = SIVI_ADMIN_EMAIL;

    global $eID , $aID, $application_fee;

    $stripe_fee = 3 + $application_fee;

    $server = '//'.$_SERVER['HTTP_HOST'];

    list($first_name, $last_name, $username, $email, $pmode) = getAccountDetails($aID);
    $campaign_name = getCampaignName($eID);


    $to = $email;

    $name_of_project = getProjectName($aID);
    #$name_of_campaign

    $subject = "$first_name $last_name, Your Campaign was Successfully Funded on LaunchLeader!";
    $message = "<html><body>
    Hi $first_name,<br>
    <br>
    Congratulations! <br>
    <br>
    Thanks to your marketing and the generosity of your donors, $campaign_name<br>
    for <a href=\"$server/profile?u=$username&pmode=$pmode\">$name_of_project</a> was successfully funded on LaunchLeader!<br>
    <br>
    Stripe will now deduct the $stripe_fee% processing fee and deposit the balance of donations to your bank account.<br>
    <br>
    Continue adding new campaigns and creating buzz for your <a href=\"$server/profile?u=$username&pmode=$pmode\">project page</a> to keep building momentum<br>
    for your startup idea!<br>
    <br>
    Thanks again!<br>
    <br>
    The LaunchLeader Team
    </body></html>
    ";
    //     'Reply-To: webmaster@example.com' . "\r\n" .

    $headers = "From: $from_address" . "\r\n";
    $headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
    if($cc_address != "") $headers .= "CC: $cc_address\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

    mail($to, $subject, $message, $headers);
    error_log ("Email sent to Entrepreneur [$to]\n", 0);
}


##>>>>>>>>>>>>>>>>>>>>>>>>>> Declined Mail Function Start >>>>>>>>>>>>>>>>>>>>>>>> ##

function sendDeclinedMailToDonor($funding_details_id, $fund_amount, $funder_id){
    $from_address = FROM_EMAIL_ADDRESS; 
    $cc_address = SIVI_ADMIN_EMAIL;

    global $eID , $aID;

    $server = '//'.$_SERVER['HTTP_HOST'];

    list($first_name, $last_name, $username, $aemail, $pmode) = getAccountDetails($aID);
    $campaign_name = getCampaignName($eID);
    list($funder_name,$email) = getFullName($funder_id);

    $to = $email;

    $name_of_project = getProjectName($aID);
    #$name_of_campaign
    $subject = "Unable To Process Your Donation to $first_name $last_name on LaunchLeader";
    $message = "<html><body>
    Hi $funder_name,<br>
    <br>
    We’re happy to let you know that $campaign_name for <a href=\"$server/profile?u=$username&pmode=$pmode\">$name_of_project</a><br>
    by $first_name $last_name was just successfully reached its funding goal on LaunchLeader<br>
    <br>
    <br>However, we are unable to process your donation of \$$fund_amount USD because your credit card has been <br>
    declined by your bank.<b> This could be due to a variety of reasons such as changes with your card<br>
    information or passing the expiration date<br>
    <br>
    Until you re-submit your pledge $first_name $last_name may not be able to receive any funding. 
    Please go to the <a href=\"$server/profile?u=$username&pmode=$pmode\">profile page</a> within 7 days and make your pledge again. Your original pledge<br>
    has been cancelled.
    <br>
    Feel free to contact us with any questions:support@launchleader.com<br>
    <br>
    Thanks,<br>
    <br>
    The LaunchLeader Team<br>
    </body></html>
    ";
    //     'Reply-To: webmaster@example.com' . "\r\n" .

    $headers = "From: $from_address" . "\r\n";
    $headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
    if($cc_address != "") $headers .= "CC: $cc_address\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

    mail($to, $subject, $message, $headers);
}

function sendDeclinedMailToEntrepreneur($funding_details_id, $fund_amount, $funder_id){
    $from_address = FROM_EMAIL_ADDRESS; 
    $cc_address = SIVI_ADMIN_EMAIL;

    global $eID , $aID, $application_fee;

    $stripe_fee = 3 + $application_fee;

    $server = '//'.$_SERVER['HTTP_HOST'];

    list($first_name, $last_name, $username, $email, $pmode) = getAccountDetails($aID);
    $campaign_name = getCampaignName($eID);
    list($funder_name,$email) = getFullName($funder_id);

    $to = $email;

    $name_of_project = getProjectName($aID);
    #$name_of_campaign

    $subject = "Unable To Process Funding for Your $campaign_name Campaign on LaunchLeader";
    $message = "<html><body>
    Hi $first_name,<br>
    <br>
    The good news is that your $campaign_name for <a href=\"$server/profile?u=$username&pmode=$pmode\">$name_of_project</a> just successfully reached its<br>
    funding goal on LaunchLeader.<br>
    <br>

    The bad news is that <br>we are unable to process the following donations because the donor’s credit card has been declined by his/her bank.</b><br>
    This could be due to a variety of reasons such as changes with the card information or passing the expiration date.<br>
    <br>
    -- $funder_name, Amount pledged $$fund_amount USD<br>

    <br>
    Thanks,<br>
    <br>
    The LaunchLeader Team
    </body></html>
    ";
    //     'Reply-To: webmaster@example.com' . "\r\n" .

    $headers = "From: $from_address" . "\r\n";
    $headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
    if($cc_address != "") $headers .= "CC: $cc_address\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

    mail($to, $subject, $message, $headers);
}

##>>>>>>>>>>>>>>>>>>>>>>>>>> Declined Mail Function End >>>>>>>>>>>>>>>>>>>>>>>>> ##

##>>>>>>>>>>>>>>>>>>>>>>>>>>>> Necessary Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>> ##

function refreshMilestone($account_id, $eId){
/*
    Refreshing Milestone for the element and account id
*/
    
  	$result = mysql_query("select account_id,funding_milestones_datetime from funding_milestones where account_id='$account_id' AND element_id = '$eId' ") or die("mysql error@ finding account_id @ line # updatingMilestone");
	$row = mysql_fetch_row($result);
    $aid = $row[0];
    $funding_milestones_datetime = $row[1];
    
    $fdd = date("Y-m-d H:i:s", strtotime(date("Y-m-d")) - 23 * 86400);
    
    if(strtotime($fdd)  <  strtotime($funding_milestones_datetime) ){
        $fdd = $funding_milestones_datetime;
    }
    
    if($aid != ''){
        $query = "UPDATE funding_milestones SET funding_milestones_datetime = '$fdd'
                        WHERE account_id = '$account_id' AND 
                        element_id = '$eId'
                        ";    
        mysql_query($query) or die("mysql error@ inserting milestone info @ refreshMilestone ");
     }
     
     error_log ("Refreshing Milestone [$fdd] from [$funding_milestones_datetime]", 0);
}

function getAuthorizeTokenID($funding_details_id){
    global $force_disburse;
	$result = mysql_query("select disburse_token,disburse_status from fund_disbursed where funding_details_id='$funding_details_id'  AND disburse_status ='authorized' AND fund_disbursed_status = '1' ") or die("mysql error @ getAuthorizeTokenID");
	$row = mysql_fetch_row($result);
	$stripe_token_data = trim($row[0]);
	$status = trim($row[1]);
    if($force_disburse && $status == "") $status = "declined";
	return array ($stripe_token_data, $status);
}

function getFundingDetailsCount($aID, $eID){
	$result = mysql_query(" select count(*) as count from funding_details where element_id = '$eID' and account_id = '$aID' AND funding_details_status = '1' ") or die("mysql error @ getFundingDetailsCount");
	$row = mysql_fetch_row($result);
	$count = trim($row[0]);
	return $count;
}

function getFundingDisbursedCount($aID, $eID,$status){
	$result = mysql_query(" select count(*) as count from fund_disbursed where element_id = '$eID' AND  account_id = '$aID' AND disburse_status = '$status' AND fund_disbursed_status = '1' ") or die("mysql error @ getFundingDetailsCount");
	$row = mysql_fetch_row($result);
	$count = trim($row[0]);
	return $count;
}

function getPreviousTokenID($funding_details_id){
	$result = mysql_query("select disburse_token,disburse_status from fund_disbursed where funding_details_id='$funding_details_id' AND fund_disbursed_status = '1' ") or die("mysql error @ getPreviousTokenID");
	$row = mysql_fetch_row($result);
	$stripe_token_data = trim($row[0]);
	$status = trim($row[1]);
	return array ($stripe_token_data, $status);
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

function alreadyDisbursed($funding_details_id){
	$result = mysql_query("select fund_disbursed_id from fund_disbursed where funding_details_id='$funding_details_id' AND disburse_status='captured' AND fund_disbursed_status = '1' ") or die("mysql error @ alreadyDisbursed");
	$row = mysql_fetch_row($result);
	$fund_disbursed_id = $row[0];
	return ($fund_disbursed_id > 0);
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

function getStripeTransactionToken($funding_details_id){
  	$result = mysql_query("select funding_card_tokens from funding_tokens where funding_details_id='$funding_details_id'") or die("mysql erro @ getStripeTransactionToken");
	$row = mysql_fetch_row($result);
    $funding_card_tokens = $row[0];
    return $funding_card_tokens;
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
  	$result = mysql_query("select account_name_first,account_name_last, account_username, account_email,account_partnercrumb from account where account_id='$aID'") or die("mysql error@ getAccountDetails");
	$row = mysql_fetch_row($result);
    $first_name = $row[0];
    $last_name = $row[1];
    $user_name = $row[2];
    $account_email = $row[3];
    $account_partnercrumb = $row[4];
    return array($first_name, $last_name, $user_name, $account_email,$account_partnercrumb);
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

##>>>>>>>>>>>>>>>>>>>>>>>>>>>> Necessary Functions  END >>>>>>>>>>>>>>>>>>>>>>>>>>>> ##

?>
