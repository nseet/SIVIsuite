<?php
require_once '../social/pconfig.php';

if (isset($_GET['conversation_token'])) {
    $key = $_GET['conversation_token'];
} 

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Launch Leader v4</title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta name="og:title" content="LaunchLeader"/>
<meta name="og:image" content="https://vip.launchleader.com/images/fb-share-img.png"/>
<meta name="og:description" content="LaunchLeader is a micro-crowdfunding platform to raise startup money from your friends and family." />
	<link rel="shortcut icon" href="../css/images/favicon.ico" />
	<link rel="stylesheet" href="../css/fonts.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/colorbox.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/jquery.fs.selecter.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/style.css" type="text/css" media="all" />
	<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.carouFredSel-6.2.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../js/jquery.fs.selecter.js"></script>
	<script src="https://www.youtube.com/iframe_api"></script>
	<script type="text/javascript" src="../js/youtube.js"></script>
	<script type="text/javascript" src="../js/functions.js"></script>
        <script src="//load.sumome.com/" data-sumo-site-id="a71e7fa4a47b10f19e33cada442fdcf80aeb9425630e0fd36d59811d39574dd2" async></script>
</head>
<body>
<div class="wrapper">
	<div class="header">
		<div class="shell">
			<div class="header-inner clearfix">
				<a href="../index.html" class="logo"></a>
				
				<a href="#" class="nav-trigger"></a>

				<div class="nav">
					<ul>
						<li>
							<a href="../discover">Search Campaigns</a>
						</li>

                                                <li>
                                                        <a href="https://vip.launchleader.com/How%20To%20Start%20Your%20Company%20Using%20LaunchLeader%20White%20Paper.pdf
" target="_blank">How LaunchLeader Works</a>
                                                </li>

						<li>
							<a href="../faq">FAQ</a>
						</li>

                                                <li>
                                                        <a href="http://podcast.launchleader.com/" target="_blank">Podcast</a>
                                                </li>

						<li class="separator">
							<a href="../login">Login</a>
						</li>

						<li class="signup">
							<a href="../signup">Sign Up</a>
						</li>				
					</ul>
				</div><!-- /.nav -->
				
			</div><!-- /.header-inner clearfix -->
		</div><!-- /.shell -->
	</div><!-- /.header -->
<div class="main">
<br><br>

<?php

$result = mysql_query("select account_id, funder_id  from conversation_track where conversation_track_token='$key' ") or die("mysql error @ line # 13");
$row = mysql_fetch_row($result);
$account_id = $row[0];
$funder_id = $row[1];

list($first_name, $last_name, $username) = getAccountDetails($account_id);
list($funder_name, $funder_email) = getFunderDetails($funder_id);
$entrepreneur_name = "$first_name $last_name";
function getAccountDetails($account_id){
	$result = mysql_query("select account_name_first,account_name_last, account_username from account where account_id ='$account_id'") or die("mysql error@ getAccountDetails");
	$row = mysql_fetch_row($result);
    $first_name = $row[0];
    $last_name = $row[1];
    $username = $row[2];
    return array($first_name, $last_name, $username);
}

function getFunderDetails($account_funder_id){
  	$result = mysql_query("select account_funder_name,account_funder_email from account_funder where account_funder_id='$account_funder_id'") or die("mysql error@ finding customer @ line getFullName");
	$row = mysql_fetch_row($result);
    $fullName = $row[0];
    $email = $row[1];
    return array($fullName,$email );
}

if($account_id == '' or $funder_id == ''){
 $failed_str = "Conversation ERROR: Please try again later!<br>";
}
#print $account_id."<br>";
#print $funder_id."<br>";
?>

 <div class="popup-center" id="confirmation-head">
	<div class="popup-head" id="confirmation">
		<h2>Reply your message!</h2>
	</div><!-- /.popup-head -->

	<div class="popup-body">
		<p>Write a brief message and we'll email it for you.</p>
		<div class="form form-refer form-message">
			<form onsubmit="return sendEmail();">
				<div class="form-body">
					<div class="form-row form-row-alt">
						<label for="recepient" class="form-label">
							To:
							<span class="form-hint">recepient</span>
						</label>

						<div class="form-controls">
							<input type="text" name="refer-email" id="refer-email" class="field" placeholder="<?php echo $entrepreneur_name; ?>" disabled/>
						</div><!-- /.form-controls -->
<!--                        
					    <label for="recepient" class="form-label">
						Your
						<span class="form-hint">address:</span>
					    </label>

					    <div class="form-controls">
						<input type="text" name="from_email" id="from_email" class="field" value="" placeholder="<?php echo $funder_email;?>" / disabled>
					    </div><!-- /.form-controls -- >
						
-->                            
                                </div><!-- /.form-row -->
							<div class="form-row">
								<div class="form-controls">
									<textarea cols="30" rows="10" name="message" id="message" class="textarea" placeholder="Type your message here..."></textarea>
								</div><!-- /.form-controls -->
							</div><!-- /.form-row -->
						</div><!-- /.form-body -->
                        
				<div class="form-actions form-actions-right">
						 <input type="hidden" name="username" id="username" value="<?php echo $username;?>"/>
						 <input type="hidden" name="from_email" id="from_email" value="<?php echo $funder_email;?>"/>
						 <input type="hidden" name="convreply" id="convreply" value="1"/>
						 <input type="hidden" name="tosend" id="tosend" value="1"/>
						<input type="submit" value="Send Message" class="btn btn-medium" />
				</div><!-- /.form-actions -->
			</form>
		</div><!-- /.form form-refer -->
	</div><!-- /.popup-body -->
</div><!-- /.popup -->

<script>
<?php 
if($failed_str != ''){
?>
	$( document ).ready(function() {
		$('#confirmation-head').html("<div  align=center style='font-style:italic; font-size: 18px; color: #666'><br><br><br><br><?php echo $failed_str; ?></div>");
		  $('#confirmation-head').css('height', '200px');                      
                               // $('#confirmation').html("<h2><i>Email sent successfully</i></h2>");
	});
<?php 
}
?>
            function sendEmail() {
                // 1. Create XHR instance - Start
                
                var xhr;
                if (window.XMLHttpRequest) {
                    xhr = new XMLHttpRequest();
                }
                
                else if (window.ActiveXObject) {
                    xhr = new ActiveXObject("Msxml2.XMLHTTP");
                }
                else {
                    throw new Error("Ajax is not supported by this browser");
                }
                
                // 1. Create XHR instance - End
                
                // 2. Define what to do when XHR feed you the response from the server - Start
                
                
                xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                        if (xhr.status == 200 && xhr.status < 300) {
                            if(xhr.responseText == "success"){
                                $('#confirmation-head').html("<div  align=center style='font-style:italic; font-size: 18px; color: #666'><br><br><br><br>Email sent successfully</div>");
                                $('#confirmation-head').css('height', '200px');                      
                               // $('#confirmation').html("<h2><i>Email sent successfully</i></h2>");
                                $('#tosend').val(0);
                            }
                            else {
                                //alert(xhr.responseText);
                                $('#confirmation').html("<h2><font color='RED'>Email sending failed</font></h2>");
                            }
                        }
                    }
                }
                // 2. Define what to do when XHR feed you the response from the server - Start

                var message = document.getElementById("message").value;
                var username = document.getElementById("username").value;
                var tosend = document.getElementById("tosend").value;
                var from_email = document.getElementById("from_email").value;
                from_email = encodeURIComponent(from_email);
       
                var post_str = "message=" + message +"&username=" + username + "&from_email=" + from_email;
               // alert(post_str);
		
                // 3. Specify your action, location and Send to the server - Start 
                if(tosend == 1){
                    xhr.open('POST', '../'+'ajax/launchmailer');
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.send(post_str);
                    $('#tosend').val(0);
                }
                // 3. Specify your action, location and Send to the server - End

	    return false;
          }
</script>
<br><br>
</div><!-- /.main -->

<div class="footer">
		<div class="shell">
			<div class="footer-inner">
				<div class="socials">
					<ul>
					    <li>
						   <a href="https://www.facebook.com/groups/launchleader" target="_blank" class="link-facebook">Facebook</a>
       					</li>						
						<li>
							<a href="https://twitter.com/sivicorp" target="_blank" class="link-twitter">Twitter</a>
						</li>

						<li>
							<a href="https://angel.co/sivi" target="_blank" class="link-peace">Peace</a>
						</li>						

					</ul>
				</div><!-- /.socials -->

				<a href="#" class="link-top"></a>

				<p>Questions, comments, suggestions? Contact us at <a href="mailto:info@launchleader.com">info@launchleader.com</a></p>

				<div class="footer-nav">
					<ul>
						<li>
							<p class="copyright" target="_blank">Copyright &copy; 2014 SIVI. All Rights Reserved.</p><!-- /.copyright -->
						</li>
					
						<li>
							<a href="../privacy" target="_blank" >Privacy Policy</a>
						</li>
					
						<li>
							<a href="../terms" target="_blank" >Terms and Conditions</a>
						</li>
                        
                            <li>
                                    <a href="https://brandfolder.com/launchleader" target="_blank" >Press Kit</a>
                            </li>
					</ul>
				</div><!-- /.footer-nav -->

				<a href="http://sivi.com" target="_blank" class="footer-logo"></a>
			</div><!-- /.footer-inner -->
		</div><!-- /.shell -->
	</div><!-- /.footer -->
</div><!-- /.wrapper -->	
</body>
<!-- CUSTOM_CSS_JS_FOOTER -->
</html>

