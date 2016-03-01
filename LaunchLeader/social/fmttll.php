<?php
error_reporting(E_ALL & ~E_NOTICE);

require 'src/facebook.php';  // Include facebook SDK file
require 'functions.php';  // Include functions

$sl_error = array();

#print_r($_POST); exit;
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!session_id()) {
          session_start();
    }

    $uname = '';
    $tofund = '';
    $funding_for = '';
    $fullname ='';
    $eID = "";
	if (isset($_POST['pmode'])) {
	    $pmode = urldecode($_POST['pmode']);
	} 	
	if (isset($_POST['pledged'])) {
	    $pledged = urldecode($_POST['pledged']);
	} 

	if (isset($_POST['pledgegoal'])) {
	    $pledgegoal = urldecode($_POST['pledgegoal']);
	}     
    
	if (isset($_POST['anonymous'])) {
	    $anonymous = urldecode($_POST['anonymous']);
	}     
    
    if (isset($_POST['trailto'])) {
        $uname = $_POST['trailto'];
    } 
    else {
        $sl_error['trailto'] = 'No trailto is available to process.';
    }
    
    if (isset($_POST['eId'])) {
	$eId = $_POST['eId'];
    } 
    else {
        $sl_error['eId'] = 'No Element ID is available to process.';
    }  
    
    if (isset($_POST['trailfor'])) {
        $tofund = $_POST['trailfor'];
    } 
    else {
        $sl_error['trailfor'] = 'No trailfor is available to process.';
    }  
    
    if (isset($_POST['trailer'])) {
        $funding_for = urlencode($_POST['trailer']);
    } 
    else {
        $sl_error['trailer'] = 'No trailer is available of entrepreneur.';
    }
    
    if (isset($_POST['ttfull'])) {
        $fullname = $_POST['ttfull'];
    } 
    else {
        $sl_error['ttfull'] = 'No fullname is available of entrepreneur.';
    }
    
    if (isset($_POST['name'])) {
        $fbfullname = $_POST['name'];
    } 
    if($_POST['ref'] == 'funders') {
        $_POST['u'] = $_POST['uemail'];
    }
    
    if (isset($_POST['u'])) {
        $fbuname = $_POST['u'];
        $femail = $_POST['u'];
        $fbid = $_POST['u'];
        $fpasswd = $_POST['p'];
    } 
    
    // Put signup form in session!!!    
	$_SESSION['FBID'] = $fbid;           
	$_SESSION['USERNAME'] = $fbuname;
	$_SESSION['FULLNAME'] = $fbfullname;
	$_SESSION['EMAIL'] =  $femail;
	$_SESSION['uname'] =  $uname;
	$_SESSION['eId'] =  $eId;
    
    #print_r($_SESSION); exit;
    
    $tkn = strtolower(generateRandomString(64));
    $tstring = strtolower(generateRandomString(20)."_".generateRandomString(8));

    // Either update or Insert in database 
    $flag = checkuser($fbid,$fbuname,$fbfullname,$femail, $fpasswd);    // To update local DB
    if($fbfullname == '' && $fpasswd != ''){
		$fbfullname = getFullName($flag);    // To update local DB
		$_SESSION['FULLNAME'] = $fbfullname;
	}
    
    #print_r($_SESSION);    print_r($_POST);  print "flag: $flag"; exit;    
    if($flag){
        header("Location: ../social/?tstring=$tkn&trailto=$uname&trailfor=$tofund&trailer=$funding_for&ttfull=$fullname&tkn=$tstring&eId=$eId&pledged=$pledged&anonymous=$anonymous&pledgegoal=$pledgegoal&pmode=$pmode");
    }
    else{
    # Login failed 
        header("Location: ../login?ref=funders&tstring=$tkn&trailto=$uname&trailfor=$tofund&trailer=$funding_for&ttfull=$fullname&tkn=$tstring&eId=$eId&pledged=$pledged&anonymous=$anonymous&pledgegoal=$pledgegoal&pmode=$pmode");
    }
    exit;
}

else if ($_SERVER['REQUEST_METHOD'] == 'GET') {

    $uname = '';
    $tofund = '';
    $funding_for = '';
    $fullname ='';
    $eID = "";

	if (isset($_GET['pmode'])) {
	    $pmode = urldecode($_GET['pmode']);
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
    
    if (isset($_GET['trailto'])) {
        $uname = $_GET['trailto'];
    } 
    else {
        $sl_error['trailto'] = 'No trailto is available to process.';
    }
    
    if (isset($_GET['eId'])) {
	$eId = $_GET['eId'];
    } 
    else {
        $sl_error['eId'] = 'No Element ID is available to process.';
    }  
    
    if (isset($_GET['trailfor'])) {
        $tofund = $_GET['trailfor'];
    } 
    else {
        $sl_error['trailfor'] = 'No trailfor is available to process.';
    }  
    
    if (isset($_GET['trailer'])) {
        $funding_for = urlencode($_GET['trailer']);
    } 
    else {
        $sl_error['trailer'] = 'No trailer is available of entrepreneur.';
    }
    
    if (isset($_GET['ttfull'])) {
        $fullname = $_GET['ttfull'];
    } 
    else {
        $sl_error['ttfull'] = 'No fullname is available of entrepreneur.';
    }
}

$facebook = new Facebook(array(
  # Lets replace these appID and secret before going into production
  'appId'  => 'FB_APP_ID',   // Facebook App ID
  'secret' => 'FB_APP_SECRET',  // Facebook App Secret
  'cookie' => false,
));
$user = $facebook->getUser();

if ($user) {
  try {
        $user_profile = $facebook->api('/me');
        $fbid = $user_profile['id'];                 // To Get Facebook ID
        $fbuname = $user_profile['username'];  // To Get Facebook Username
        $fbfullname = $user_profile['name']; // To Get Facebook full name
        $femail = $user_profile['email'];    // To Get Facebook email ID
        #print_r($user_profile);        exit;
        
        /* ---- Session Variables -----*/
        $_SESSION['FBID'] = $fbid;           
        $_SESSION['USERNAME'] = $fbuname;
        $_SESSION['FULLNAME'] = $fbfullname;
        $_SESSION['EMAIL'] =  $femail;
        $_SESSION['uname'] =  $uname;
        $_SESSION['eId'] =  $eId;
	
        ## We are going to update / insert the record of our funders
        checkuser($fbid,$fbuname,$fbfullname,$femail, "");    // To update local DB
  } 
  catch (FacebookApiException $e) {
        error_log($e);
        $user = null;
    }
}

if ($user) {
    # We identified our funders here now lets go to the payment page.
    $tkn = strtolower(generateRandomString(64));
    $tstring = strtolower(generateRandomString(20)."_".generateRandomString(8));
    #print "Location: ../social/?tstring=$tkn&trailto=$uname&trailfor=$tofund&trailer=$funding_for&ttfull=$fullname&tkn=$tstring&eId=$eId";
    #exit;
    header("Location: ../social/?tstring=$tkn&trailto=$uname&trailfor=$tofund&trailer=$funding_for&ttfull=$fullname&tkn=$tstring&eId=$eId&pledged=$pledged&pledgegoal=$pledgegoal&anonymous=$anonymous&pmode=$pmode");
} 
else {
 $loginUrl = $facebook->getLoginUrl(array(
		'scope'		=> 'email', // Permissions to request from the user
		));
 header("Location: ".$loginUrl);
}

function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyz_';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}
?>
