<?php
require_once 'dbconfig.php'; 

if (isset($_POST['uname'])) {
    $uname = $_POST['uname'];
} 
else {
    $trailer_errors['uname'] = 'No uname is available to process.';
}    

if (isset($_POST['sid'])) {
    $sid = $_POST['sid'];
} 
else {
    $trailer_errors['sid'] = 'No email is available to process.';
}   

if (isset($_POST['email'])) {
    $email = $_POST['email'];
} 
else {
    $trailer_errors['sid'] = 'No email is available to process.';
}    
if($email == ""){
	$email = getAccountFunderEmail ($sid);
}

if($email == ''){
    print "failed";
    exit;
}

print autoSubscribe($email, $uname);

function autoSubscribe($email, $uname){
    global $uname;
    $account_id = getAccountId($_SESSION['uname']);
    if($account_id == '') {
	$account_id = getAccountId($uname);
    }
    
  	$result = mysql_query("select subscriber_id from subscriber where account_id='$account_id' AND subscriber_email = '$email' ") or die("mysql error@ finding account funder id @ line # 204");
	$row = mysql_fetch_row($result);
    $subscriber_id = $row[0];
    if(!$subscriber_id){
        $query = "INSERT INTO subscriber (subscriber_id, account_id, project_id, subscriber_email, subscriber_status, subscriber_datetime) 
        VALUES ('','$account_id','$account_id','$email','1', NOW())";
        mysql_query($query) or die("failed");
        return  "subscribed";
    }
    else{
        return  "already-subscribed";
    }
    
}


function getAccountId($username){
  	$result = mysql_query("select account_id from account where account_username='$username'") or die("failed");
	$row = mysql_fetch_row($result);
    $account_id = $row[0];
    return $account_id;
}

 function getAccountFunderEmail($account_funder_social_id){
  	$result = mysql_query("select account_funder_email from account_funder where account_funder_social_id='$account_funder_social_id'") or die("failed");
	$row = mysql_fetch_row($result);
    $account_funder_id = $row[0];
    return $account_funder_id;
}



?>
