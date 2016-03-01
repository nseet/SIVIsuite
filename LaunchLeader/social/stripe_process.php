<?php
/*
print "<------------GET------------>";
print_r($_GET);
print "<------------POST---------->";
print_r($_POST);
*/

$trailer_errors = array();
$trailfor = 0;
$funding_for = '';
$fullname = '';
$trailforcent = 0;
$trailer_errors = array();
$success = "";

if (isset($_GET['trailfor'])) {
    $trailfor = $_GET['trailfor'];
} 
else {
    $trailer_errors['trailfor'] = 'No amount is available to process.';
}    

if (isset($_GET['pledged'])) {
    $pledged = urldecode($_GET['pledged']);
} 

if (isset($_GET['pledgegoal'])) {
    $pledgegoal = urldecode($_GET['pledgegoal']);
} 

if (isset($_GET['anonymous'])) {
    $anonymous = urldecode($_GET['anonymous']);
} 

if (isset($_GET['pmode'])) {
    $pmode = urldecode($_GET['pmode']);
    $pmodestr = "?pmode=$pmode";
} 

if (isset($_GET['trailer'])) {
    $funding_for = urldecode($_GET['trailer']);
} 
else {
    $trailer_errors['trailer'] = 'No trailer is available to process.';
}    

if (isset($_GET['ttfull'])) {
    $fullname = $_GET['ttfull'];
} 
else {
    $trailer_errors['ttfull'] = 'No fullname is available of entrepreneur.';
}

if (isset($_GET['trailto'])) {
    $trailto = $_GET['trailto'];
} 
else {
    $trailer_errors['trailto'] = 'No username is available of entrepreneur.';
}
if (isset($_GET['eId'])) {
    $eId = $_GET['eId'];
} 

  
$trailforcent = $trailfor * 100;
$user = $trailto;
$errors = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
     $token = '';
    if (isset($_POST['stripeToken'])) {
        $token = $_POST['stripeToken'];
        error_log( print_r( $_POST, true), 0);  

        // Check for a duplicate submission, just in case:
		// Uses sessions, you could use a cookie instead.
		if (isset($_SESSION['token']) && ($_SESSION['token'] == $token)) {
			$errors['token'] = 'You have apparently resubmitted the form. Please do not do that.';
		} else { // New submission.
			$_SESSION['token'] = $token;
		}        
    } 
    else {
        $errors['token'] = 'The order cannot be processed. You have not been charged. Please confirm that you have JavaScript enabled and try again.';
    }
    
    // Check for a duplicate submission, just in case:
    // Uses sessions, you could use a cookie instead.
  
	if (empty($errors)) {
		# create the charge on Stripe's servers - this will charge the user's card
		try {
			#print "<br>funding_for:$funding_for<br>";
			#print "<br>trailforcent:$trailforcent<br>";
			// Include the Stripe library:
			#require_once('lib/Stripe.php');

			// set your secret key: remember to change this to your live secret key in production
			// see your keys here https://manage.stripe.com/account
			Stripe::setApiKey(STRIPE_PRIVATE_KEY);
            $charge = array();
            
            if(CHARGE_LATER){
                # We will charge the customer later so we will create the customer at first and will charge the customer later.
                # We will check whether there are any customer already available in database or not.
                $customerId = getStripeCustomerId($_SESSION['FBID']);   
                error_log("Got Customer ID [".$customerId."]");

                if($customerId == ""){
                    # Create a Customer if the customer is already not in database.
                    $customer = Stripe_Customer::create(array(
                      "card" => $token,
                      "description" => $_SESSION['FBID'])
                    );

                    // Save the customer ID in your database so you can use it later
                    saveStripeCustomerId($_SESSION['FBID'], $customer->id);
                    error_log("Saving Customer [".$_SESSION['FBID']."] [".$customer->id."]");
                    $customerId = $customer->id;
                }
                if($customerId != ""){
                    // Save the Transaction details in your database so you can use it later
                    ## The default card is the 1st card
                    
                    list ($fullName,$email ) = getFullName($_SESSION['FBID']); 
                    $sid = $_SESSION['FBID'];
                    #autoSubscribe($email);
                    
                    ## Get current Card ID from Token
                    $retrieve_token = Stripe_Token::retrieve($token);
                    $card_id =  $retrieve_token->card->id;  
                
                    error_log("token :: [".$token."]");
                    error_log("card_id :: [".$card_id."]");                    
 
                    ## To check whether the Card is already in Customer Base if not we will add this now.
                    $customer_data = Stripe_Customer::retrieve($customerId);
                    error_log( ">>>>>>>>>>>>>CUSTOMER OBJECT>>>>>>>>>>>>>>>>>>");  
                    error_log( print_r( $customer_data, true), 0);  
                    
                    try{
                        $getCard = $customer_data->sources->retrieve($card_id);    
                        error_log( ">>>>>>>>>>>>>CARD_OBJECT>>>>>>>>>>>>>>>>>>");  
                        error_log( print_r( $getCard, true), 0);  
                    }
                    catch (Stripe_InvalidRequestError $e) {
                        // Invalid Request Possibly this card is not available.
                        error_log( "This Card is not Available \n");  
                        $getCard->id = '';
                    }

                    if($card_id != $getCard->id){
                    
                        error_log("Found New Card :: [".$card_id."] for Token :: [".$token."] ");
                        ##We have to add new card
                        #$cu->sources->create(array("source" => $token ));                        
                        $customer_data->sources->create(array("source" => "$token"));
                    }
                     
                    ## Try to authorize $1 for this card If it fails Then we will not process further. 
                    $isAuthorized = 0;
                    $isAuthorized = letsAuthorizeTheCard($token,$card_id, $customerId,  $_SESSION['FBID']);
                    error_log("isAuthorized :: [".$isAuthorized."]");

              
                    //error_log( print_r( $retrieve_token, true), 0);  
                    //exit;
                    
                    if($isAuthorized){
                        saveTransactionDetails($card_id);
                        sendMailToDonor($fullName, $email, $trailfor, $trailto);
                        sendMailToEntrepreneur($fullName, $email, $trailfor, $trailto);
                        header("Location: ../funding-confirm?u=$trailto&pmode=$pmode&sid=".$sid);
                    }
                    else{
                        header("Location: ../funding-confirm?u=$trailto&pmode=$pmode&status=declined&sid=".$sid);
                        // The card was failed to authorized. Lets show something that we have failed to authroize the card
                    }
                }
/*
                // Charge the Customer instead of the card
                Stripe_Charge::create(array(
                  "amount" => $trailforcent, # amount in cents, again
                  "currency" => "usd",
                  "customer" => $customer->id)
                );
*/

/*
                    // Later...
                    $customerId = getStripeCustomerId($user);

                    Stripe_Charge::create(array(
                      "amount"   => 1500, # $15.00 this time
                      "currency" => "usd",
                      "customer" => $customerId)
                    );   
*/                
            }
            else{
                // Charge the order:
                $charge = Stripe_Charge::create(array(
                    "amount" => $trailforcent, // amount in cents, again
                    "currency" => "usd",
                    "card" => $token,
                    "description" => "$funding_for"
                    )
                );
            }
/*            
			// Check that it was paid:
			if ($charge->paid == true) {
				// Store the order in the database.
				// Send the email.
				// Celebrate!
                $success = "paid";                
                sendMailToSivi();
			} 
            else { // Charge was not paid!	
				echo '<div class="alert alert-error"><h4>Payment System Error!</h4>Your payment could NOT be processed (i.e., you have not been charged) because the payment system rejected the transaction. You can try again or use another card.</div>';
			}
*/			
		} catch (Stripe_CardError $e) {
		    // Card was declined.
			$e_json = $e->getJsonBody();
			$err = $e_json['error'];
			$errors['stripe'] = $err['message'];
		} catch (Stripe_ApiConnectionError $e) {
		    // Network problem, perhaps try again.
		    //print "Network problem, perhaps try again.";
		    $errors['stripe'] = "Network problem, perhaps try again.";
		} catch (Stripe_InvalidRequestError $e) {
		    // You screwed up in your programming. Shouldn't happen!
            error_log( ">>>>>>>>>>>>>>>ERROR_DUMP>>>>>>>>>>>>>>>>>>>>>\n");  
            error_log( print_r($e, true), 0);  
            $errors['stripe'] =  "You screwed up in your programming. Shouldn't happen!";
		} catch (Stripe_ApiError $e) {
		    // Stripe's servers are down!
                $errors['stripe'] =  "Stripe's servers are down!";
		} catch (Stripe_CardError $e) {
		    // Something else that's not the customer's fault.
            $errors['stripe'] =  "Something else that's not the customer's fault.";
		}
        
        // A user form submission error occurred, handled below.
        if($errors['stripe']  != '') {
               error_log( "<<<<<<<<<<<<STRIPE_ERROR_HAPPENED>>>>>>>>>>>>", 0);  
               error_log($errors['stripe'] , 0); 
              #return 0;
        }
	} // A user form submission error occurred, handled below.
}


function sendMailToDonor($fullName, $email,$amount, $username){

global $pmode;
$from_address = FROM_EMAIL_ADDRESS; 
$bcc_address = SIVI_ADMIN_EMAIL;
$to = $email;
global $funding_for;

$server = 'http://'.$_SERVER['HTTP_HOST'];

list($first_name, $last_name, $user_id, $e) = getAccountDetails($username);
$name_of_project = getProjectName($user_id);
#$name_of_campaign

$subject = "Thanks for Supporting $first_name $last_name on LaunchLeader";
$message = "<html><body>
Hi $fullName,<br> 
<br>
Thanks for showing your support for entrepreneurship. Because of you $first_name $last_name is<br>
one step closer to launching a startup.<br>
<br>
Your $funding_for donation is for <a href=\"$server/profile/$username?pmode=$pmode\">$name_of_project</a> by $first_name $last_name<br>
<br>
Amount pledged: \$$amount USD<br>
<br>
If this campaign is successfully funded within 30 days, your card will be charged. We will keep you<br>
updated. In the meanwhile please use the Message feature on the profile page to provide feedback about the idea.<br>
<br>
Thank You<br>
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

function sendMailToEntrepreneur($fullName, $email,$amount, $username){

global $pmode;
$from_address = FROM_EMAIL_ADDRESS; 
$bcc_address = SIVI_ADMIN_EMAIL;

global $funding_for, $pledged, $pledgegoal;

$so_far_pledged = $pledged + $amount;

$server = 'http://'.$_SERVER['HTTP_HOST'];

list($first_name, $last_name, $user_id, $email) = getAccountDetails($username);
$to = $email;

$name_of_project = getProjectName($user_id);
#$name_of_campaign
#$subject = "New Donation Alert! $fullName Just Pledged \$$amount USD to $name_of_project on LaunchLeader";

$subject = "New Donation Alert! $fullName Just Pledged \$$amount USD to your project on LaunchLeader";
$message = "<html><body>
Hi $first_name,<br> 
<br>
Good news! $fullName just donated to $funding_for for <a href=\"$server/profile/$username?pmode=$pmode\">$name_of_project</a> <br>
<br>
Amount pledged: \$$amount USD<br>
<br>
Now \$$so_far_pledged USD is currently pledged toward your \$$pledgegoal USD goal.<br>
<br>
Remember that you must reach your campaign goal by the deadline in order to receive any funding.<br>
<br>
Go to your <a href=\"$server/login?pmode=$pmode\">project page dashboard</a> to review activity, engage your donors and continue promoting your<br>
campaign.<br>
<br>
Best wishes!<br>
<br>
 The LaunchLeader Team
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

function saveStripeCustomerId($account_funder_social_id, $customerId){
    $query = "INSERT INTO stripe_customers (stripe_customers_id,customer_id,account_funder_social_id, stripe_customers_datetime) 
    VALUES ('','$customerId','$account_funder_social_id', NOW())";
    mysql_query($query) or die("mysql error@ inserting customer @ line # 187");
}

function letsAuthorizeTheCard($token, $card_id, $customerId, $sid){
    $account_id = getAccountId($_SESSION['uname']);
    $eId = $_SESSION['eId'];   
    
    
    error_log( ">>>>>>>>>>>>>>>AUTHORIZATION_START>>>>>>>>>>>>>>>>>>>>>\n");  
    error_log( "stripeUserAccessToken [$stripeUserAccessToken]\n");  
    
    $authorized_amount = 100;    
    try{
        $charge = array();
        $charge = Stripe_Charge::create(array(
            "amount" => $authorized_amount, // amount in cents, again
            "currency" => "usd",
            "card" => $card_id,
            "customer" => $customerId,
            "description" => "LaunchLeader Card Authorization",
            "capture"  => "false"
            )
        );
        if( $charge["id"] != '' &&  ($charge["captured"] == '' or $charge["captured"] == 'false')){
            // successfully authorized             
            $query = "INSERT INTO funding_authorized (funding_authorized_id, account_funder_social_id,account_id, element_id, authorized_amount, authorized_status, funding_details_datetime) 
            VALUES ('','$sid','$account_id', '$eId', '$authorized_amount','1', NOW())";
            mysql_query($query) or die("mysql error@ inserting funding authorized info @ letsAuthorizeTheCard");
            return 1;
        }
    }
    catch (Stripe_CardError $e) {
        // Card was declined.
        $e_json = $e->getJsonBody();
        $err = $e_json['error'];
        $errors['stripe'] = $err['message'];
        error_log( "<<<<<<<<<<<<AUTHORIZED_CARD_ERROR>>>>>>>>>>>>", 0);  
        error_log( print_r($e, true), 0);  
    } catch (Stripe_ApiConnectionError $e) {
        // Network problem, perhaps try again.
        $errors['stripe'] = "Network problem, perhaps try again.";
    } catch (Stripe_InvalidRequestError $e) {
        // You screwed up in your programming. Shouldn't happen!
        error_log( ">>>>>>>>>>>>>>>ERROR_DUMP>>>>>>>>>>>>>>>>>>>>>\n");  
        error_log( print_r($e, true), 0);          
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
          error_log($errors['stripe'] , 0); 
          #return 0;
    }
    
    $query = "INSERT INTO funding_authorized (funding_authorized_id, account_funder_social_id,account_id, element_id, authorized_amount, authorized_status, funding_details_datetime) 
    VALUES ('','$sid','$account_id', '$eId', '$authorized_amount','0', NOW())";
    mysql_query($query) or die("mysql error@ inserting funding authorized info @ letsAuthorizeTheCard");        
    
    return 0;
}

function saveTransactionDetails($cardtoken){
    global $trailforcent, $anonymous;
    $account_funder_id = getAccountFunderId($_SESSION['FBID']);
    $account_id = getAccountId($_SESSION['uname']);
    $eId = $_SESSION['eId'];   
    
    $anonymous = $anonymous * 1;
    
    $query = "INSERT INTO funding_details (funding_details_id, account_funder_id, account_id, element_id, fund_amount,funding_details_anonymous, funding_details_datetime) 
    VALUES ('','$account_funder_id','$account_id','$eId','$trailforcent', '$anonymous', NOW())";
    mysql_query($query) or die("mysql error@ inserting funding info @ saveTransactionDetails");
    
    #$result = mysql_query("SELECT MAX(funding_details_id) as max_value FROM funding_details") or die("mysql error@ inserting funding info @ saveTransactionDetails");
    #$row = mysql_fetch_row($result);
    $max_value = mysql_insert_id();    
    
    $query = "INSERT INTO  funding_tokens (funding_tokens_id, funding_details_id, funding_card_tokens, funding_tokens_datetime) 
    VALUES ('','$max_value','$cardtoken',NOW())";
    mysql_query($query) or die("mysql error@ inserting funding_tokens @ saveTransactionDetails");
    
    ### Finished
    
    
    unsettingSessions();
    updatingMileStone($account_id, $eId);
    updatingStatus();
}

function getStripeConnectToken($aID){
	$result = mysql_query("select stripe_token_data from stripe_connect where account_id='$aID'") or die("mysql error @ getStripeConnectToken");
	$row = mysql_fetch_row($result);
	$stripe_token_data = $row[0];
	return $stripe_token_data;
}

function autoSubscribe($email){
    $account_id = getAccountId($_SESSION['uname']);
    
  	$result = mysql_query("select subscriber_id from subscriber where account_id='$account_id' AND subscriber_email = '$email' ") or die("mysql error@ finding account funder id @ line # 204");
	$row = mysql_fetch_row($result);
    $subscriber_id = $row[0];
    if(!$subscriber_id){
        $query = "INSERT INTO subscriber (subscriber_id, account_id, project_id, subscriber_email, subscriber_status, subscriber_datetime) 
        VALUES ('','$account_id','$account_id','$email','1', NOW())";
        mysql_query($query) or die("mysql error@ inserting funding info @autoSubscribe");
    }
}

function getStripeCustomerId($account_funder_social_id){
  	$result = mysql_query("select customer_id from stripe_customers where account_funder_social_id='$account_funder_social_id'") or die("mysql error@ finding customer @ line # 178");
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

function getProjectName($user_id){
  	$resultAD = mysql_query("SELECT account_detail_desc from account_detail WHERE account_id='$user_id' AND detail_id=36 AND account_detail_status=1 ORDER BY account_detail_id desc LIMIT 1") or die("mysql error@ getProjectName");
	$row = mysql_fetch_row($resultAD);
    $account_detail_desc = $row[0];
    
    return $account_detail_desc;

}

function getAccountDetails($username){
  	$result = mysql_query("select account_name_first,account_name_last,account_id, account_email from account where account_username='$username'") or die("mysql error@ getAccountDetails");
	$row = mysql_fetch_row($result);
    $first_name = $row[0];
    $last_name = $row[1];
    $user_id = $row[2];
    $user_email = $row[3];
    return array($first_name, $last_name, $user_id, $user_email);
}

function getAccountId($username){
  	$result = mysql_query("select account_id from account where account_username='$username'") or die("mysql error@ finding account_id @ line # getAccountId");
	$row = mysql_fetch_row($result);
    $account_id = $row[0];
    return $account_id;
}

function getFullName($account_funder_social_id){
  	$result = mysql_query("select account_funder_name,account_funder_email from account_funder where account_funder_social_id='$account_funder_social_id'") or die("mysql error@ finding customer @ line getFullName");
	$row = mysql_fetch_row($result);
    $fullName = $row[0];
    $email = $row[1];
    return array($fullName,$email );
}

function unsettingSessions(){
    session_unset();
    $_SESSION['FBID'] = NULL;
    $_SESSION['USERNAME'] = NULL;
    $_SESSION['FULLNAME'] = NULL;
    $_SESSION['EMAIL'] =  NULL;
    $_SESSION['LOGOUT'] = NULL;
}

function updatingMilestone($account_id, $eId){
/*
    Update Milestone for the element and account id
*/
    
  	$result = mysql_query("select account_id from funding_milestones where account_id='$account_id' AND element_id = '$eId' ") or die("mysql error@ finding account_id @ line # updatingMilestone");
	$row = mysql_fetch_row($result);
    $aid = $row[0];
    
    if($aid == ''){
        $result = mysql_query("select funding_details_datetime from funding_details where account_id='$account_id' AND element_id = '$eId' ORDER BY funding_details_id ASC LIMIT 1") or die("mysql error@ finding account_id @ line # updatingMilestone");
        $row = mysql_fetch_row($result);
        $fdd = $row[0];
    
        if($fdd == ''){
            $query = "INSERT INTO funding_milestones (funding_milestones_id, account_id, element_id, funding_milestones_datetime) 
            VALUES ('','$account_id','$eId', NOW())";    
            mysql_query($query) or die("mysql error@ inserting milestone info @ updatingMilestone ");
        }
        else{
            $query = "INSERT INTO funding_milestones (funding_milestones_id, account_id, element_id, funding_milestones_datetime) 
            VALUES ('','$account_id','$eId', '$fdd')";    
            mysql_query($query) or die("mysql error@ inserting milestone info @ updatingMilestone ");
        }
     }
}

function updatingStatus(){
}

?>
