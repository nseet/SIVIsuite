<?php
require_once '../social/pconfig.php';

$pmode = 'launchleader';

if (isset($_GET['pmode'])) {
    $pmode = $_GET['pmode'];
}

if (isset($_GET['key'])) {
    $key = $_GET['key'];
} 

$curtime = date("Y-m-d H:i:s");

$result = mysql_query("select password_reset_username from password_reset where password_reset_token='$key' and password_reset_taken = '0' and password_reset_expire > '$curtime' ") or die("mysql error @ line # 13");
$row = mysql_fetch_row($result);
$password_reset_username = $row[0];
#print  $password_reset_username;

if($password_reset_username != ''){
	$result = mysql_query("select account_email,account_name_first, account_name_last from account where account_username='$password_reset_username' or account_email = '$password_reset_username' ") or die("mysql error@ line 17");
	$row = mysql_fetch_row($result);
	$email = $row[0];
	$fullName = $row[1]. " ". $row[2];	
	$firstName = $row[1];	
	$reset_password= generateRandomString(10);	
	sendResetEmail($firstName, $email, $password_reset_username, $reset_password);
	
	$result = mysql_query("select Encrypt('$reset_password','.v') ") or die("mysql error@ line 26");
	$row = mysql_fetch_row($result);
	$password_encrypted = $row[0];
	
	#print $password_encrypted;
	
	$result = mysql_query("update account SET account_password = '$password_encrypted' where account_username='$password_reset_username' or account_email = '$password_reset_username' ") or die("mysql error @ line # 29");
	
	$result = mysql_query("update password_reset SET password_reset_token = '1' where password_reset_token='$key' ") or die("mysql error @ line # 31");
	$server = 'http://'.$_SERVER['HTTP_HOST'];
	header("Location: $server/login?cred=pwd_reset_final&pmode=$pmode");
}
else{
	$server = 'http://'.$_SERVER['HTTP_HOST'];
	print "The session has been expired! <a href='$server/login?cred=forgot_pass&pmode=$pmode'>Please try again<a>";
}
/*
$result = mysql_query("select account_id from account where account_username='$username'") or die("mysql error@ finding account_id @ line # getAccountId");
$row = mysql_fetch_row($result);
$account_id = $row[0];
return $account_id;
*/

function sendResetEmail($firstName, $email, $username, $reset_password){

$from_address = FROM_EMAIL_ADDRESS; 
$bcc_address = SIVI_ADMIN_EMAIL;
global $pmode;

$to = $email;

$server = 'http://'.$_SERVER['HTTP_HOST'];

#$name_of_campaign
#$subject = "New Donation Alert! $fullName Just Pledged \$$amount USD to $name_of_project on LaunchLeader";

$subject = "Your LaunchLeader Password Has Been Reset";
$message = "<html><body>
Dear $firstName,
<br><br>
As per your request, your LaunchLeader password has been reset.<br>
Your new login details are as follows:
<br><br>
$server/login?pmode=$pmode<br>
Email: $email<br>
Username: $username<br>
Password: $reset_password<br>
<br><br>
To change your password after logging in simply go to My Dashboard > Reset Password.
<br><br>
Thanks,<br>
The LaunchLeader Team<br>
<br><br>

Facebook: <a href=\"https://www.facebook.com/groups/launchleader\">https://www.facebook.com/groups/launchleader</a><br>
Twitter: <a href=\"https://twitter.com/sivicorp\">https://twitter.com/sivicorp</a>
<br>
</body></html>
";
//     'Reply-To: webmaster@example.com' . "\r\n" . Blog: <br>

$headers = "From: $from_address" . "\r\n";
$headers .= "X-Mailer: PHP/" . phpversion()."\r\n" ;
#if($bcc_address != "") $headers .= "Bcc: $bcc_address\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";    

mail($to, $subject, $message, $headers);
}


function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}

?>

