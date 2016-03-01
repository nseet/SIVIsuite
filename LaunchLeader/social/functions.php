<?php
require 'dbconfig.php';
function checkuser($fuid,$funame,$fname,$femail, $fpasswd){

    # Here we will check whether the social ID exists or not
    $femail = mysql_real_escape_string($femail);
    $fpasswd = mysql_real_escape_string($fpasswd);    
    $fname = mysql_real_escape_string($fname);    
    $fuid = mysql_real_escape_string($fuid);    
    $funame = mysql_real_escape_string($funame); 	
    
    $check = mysql_query("select * from account_funder where account_funder_social_id='$fuid'");
	$check = mysql_num_rows($check);
   
    $picture  = "https://graph.facebook.com/$fuid/picture";
    if($fpasswd != "") $picture = "";
    #print "check : $check";
	if ((empty($check) or !$check) && $fname != "") { 
   
            # We got a new funder here for our entrepreneur
        $query = "INSERT INTO account_funder (account_funder_id,account_funder_name,account_funder_avatar,account_funder_social_id,account_funder_username,account_funder_password, account_funder_email) 
        VALUES ('','$fname','$picture','$fuid','$funame','$fpasswd','$femail')";
        mysql_query($query) or die("mysql error@ finding account_id @ line # 21");
        return 1;
	} 
	else {
		#  Wala! lets update the social ID
		if($fpasswd == ''){
            #$fuid = mysql_real_escape_string($fuid);
			$query = "UPDATE account_funder SET account_funder_username='$funame', account_funder_name='$fname', account_funder_email='$femail' where account_funder_social_id='$fuid'";
			mysql_query($query) or die("mysql error@ finding account_id @ line # 29");
            return 1;
		}
		if($fpasswd != ''){
            $result = mysql_query("select account_funder_id from account_funder where account_funder_email='$femail' AND account_funder_password = '$fpasswd' ") or die("mysql error@ finding account_id @ line # 35");
            $row = mysql_fetch_row($result);
            $account_funder_id = $row[0];		
            return $account_funder_id * 1;
            }
	}
    return 0;
}



function getFullName($account_funder_id){
  	$result = mysql_query("select account_funder_name from account_funder where account_funder_id='$account_funder_id'") or die("mysql error@ finding customer @ line getFullName");
	$row = mysql_fetch_row($result);
    $getFullName = $row[0];
    return $getFullName;
}


/*
    account_funder_id
    account_funder_name
    account_funder_avatar
    account_funder_social_id	
    account_funder_username	
    account_funder_email
*/
?>
