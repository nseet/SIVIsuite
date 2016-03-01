<?php
error_reporting(1);
require_once 'pconfig.php';

if (isset($_GET['code'])) { // Redirect w/ code
  $code = $_GET['code'];
  $token_request_body = array(
    'grant_type' => 'authorization_code',
    'client_id' => STRIPE_CLIENT_ID,
    'code' => $code,
    'client_secret' => STRIPE_PRIVATE_KEY
  );
  
  $req = curl_init(TOKEN_URI);
  curl_setopt($req, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($req, CURLOPT_POST, true );
  curl_setopt($req, CURLOPT_POSTFIELDS, http_build_query($token_request_body));

  // TODO: Additional error handling
  $respCode = curl_getinfo($req, CURLINFO_HTTP_CODE);
  $resp2 = curl_exec($req);
  $resp = json_decode( $resp2, true);
  curl_close($req);

#echo $resp->{'access_token'};  
#print_r($resp);
#print $resp2;
#echo $resp['access_token'];  
#updatingStripeConnect();
$resp2 = preg_replace('/\n+/',' ', $resp2);
$resp2 = preg_replace('/\s+/',' ', $resp2);
#exit;
if($resp['access_token'] != ''){
    print "
    <script>
       window.opener.alreadySetup('$resp2', 1);
       window.close();
    </script>
    ";
}
#exit;  

#header("Location: ../account?stage=6");

} else if (isset($_GET['error'])) { // Error
	$resp2 =  $_GET['error_description'];
    print "
    <script>
       window.opener.alreadySetup('$resp2', 0);
       window.close();
    </script>
    ";
	
} else { // Show OAuth link
  $authorize_request_body = array(
    'response_type' => 'code',
    'scope' => 'read_write',
    'client_id' => 'my_STRIPE_CLIENT_ID'
  );

  $url = AUTHORIZE_URI . '?' . http_build_query($authorize_request_body);
  echo "<a href='$url'>Connect with Stripe</a>";
}

/*
function updatingStripeConnect($account_id, $connectData) {

    if($account_id < 1){
        return;
    }
    
  	$result = mysql_query("select account_id from stripe_connect where account_id='$account_id'") or die(" error@ stripe connect @ line # uSCS");
	$row = mysql_fetch_row($result);
    $aid = $row[0];
    
    if($aid == ''){
        $query = "INSERT INTO stripe_connect (stripe_connect_id, account_id, stripe_token_data, stripe_connect_datetime) 
        VALUES ('','$aid','$connectData', NOW())";    
        mysql_query($query) or die(" error@ stripe connect @ uSCI ");
    }
    else{
        $query = "UPDATE stripe_connect SET stripe_token_data = '$connectData' WHERE account_id = '$aid' ")                
        mysql_query($query) or die("error@ stripe connect @ uSCU ");
    }
}
*/
?>
