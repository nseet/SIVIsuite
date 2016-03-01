<?php 
require 'src/facebook.php';  // Include facebook SDK file
session_start();

if (isset($_GET['pmode'])) {
    $pmode = $_GET['pmode'];
} 

if (isset($_GET['anonymous'])) {
    $anonymous = $_GET['anonymous'];
} 

if (isset($_GET['trailfor'])) {
    $trailfor = $_GET['trailfor'];
} 
else {
    $trailer_errors['trailfor'] = 'No amount is available to process.';
}    

if (isset($_GET['trailer'])) {
    $trailer = $_GET['trailer'];
} 
else {
    $trailer_errors['trailer'] = 'No trailer is available to process.';
}    

if (isset($_GET['ttfull'])) {
    $ttfull = $_GET['ttfull'];
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

$logOutURL = "fmttll?trailer=$trailer&trailto=$trailto&ttfull=$ttfull&trailfor=$trailfor&eId=$eId&anonymous=$anonymous&pmode=$pmode";

if($_SESSION['FBID']  != NULL){

    $facebook = new Facebook(array(
      # Lets replace these appID and secret before going into production 
      'appId'  => '539649382846388',   // Facebook App ID 
      'secret' => 'a8f00e38f0bc78b58ebc582ce63fb07f',  // Facebook App Secret
      'cookie' => false,	
    ));
    
    $baseURL = "https://".$_SERVER['HTTP_HOST']."/social/";
    $accessToken = $facebook->getAccessToken();
    $params = array( 'next' => $baseURL.$logOutURL."&access_token=$accessToken" );
    $logOutURL = $facebook->getLogoutUrl($params);
    
	session_unset();
	$_SESSION['FBID'] = NULL;
	$_SESSION['USERNAME'] = NULL;
	$_SESSION['FULLNAME'] = NULL;
	$_SESSION['EMAIL'] =  NULL;
	$_SESSION['LOGOUT'] = NULL;
	session_destroy();
    
}

#print $accessToken;
#print $logOutURL;
#print "<br><br>";
#print $logOutURL = "https://www.facebook.com/logout.php?next=http://www.mysite.com/&access_token=$accessToken";
#print "LOU2".$logOutURL."<br>";
#exit;

header("Location: $logOutURL");
#header("Location: index.php");        // you can enter home page here ( Eg : header("Location: " ."http://www.krizna.com"); 
?>
