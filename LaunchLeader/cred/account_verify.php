<?php
require_once '../social/pconfig.php';

$pmode = 'launchleader';

if (isset($_GET['key'])) {
    $key = $_GET['key'];
} 

if (isset($_GET['pmode'])) {
    $pmode = $_GET['pmode'];
}

$curtime = date("Y-m-d H:i:s");

$result = mysql_query("select account_verification_username from account_verification where account_verification_token='$key' and account_verification_taken = '0' and account_verification_expire > '$curtime' ") or die("mysql error @ line # 13");
$row = mysql_fetch_row($result);
$account_verification_username = $row[0];
$account_verification_username = preg_replace("/'/", "", $account_verification_username);
$account_verification_username = preg_replace("/`/", "", $account_verification_username);


#print  $password_reset_username;

if($account_verification_username != ''){
	#print "select account_verification_username from account_verification where account_verification_token='$key' and account_verification_taken = '0' and account_verification_expire > '$curtime'";
	#print "update account SET account_verified = '1' where account_username='$account_verification_username' or account_email = '$account_verification_username' ";
	#exit;
	$result = mysql_query("update account SET account_verified = '1' where account_username='$account_verification_username' or account_email = '$account_verification_username' ") or die("mysql error @ line # 18");
	$result = mysql_query("update account_verification SET account_verification_taken = '1' where account_verification_token='$key' ") or die("mysql error @ line # 19");
	$server = 'http://'.$_SERVER['HTTP_HOST'];
	header("Location: $server/account?stage=8&pmode=$pmode");
}
else{
	$server = 'http://'.$_SERVER['HTTP_HOST'];
	print "The session has been expired! <a href='$server/login?cred=forgot_pass&pmode=$pmode'>Please try again<a>";
}

?>

