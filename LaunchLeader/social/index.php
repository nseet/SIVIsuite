<?php
session_start();
require_once 'lib/Stripe.php';
require_once 'dbconfig.php'; 
require_once 'pconfig.php';
require_once 'stripe_process.php';
include 'payment_header.php';

?>


<?php if ($_SESSION['FBID']): ?>      <!--  After user login  -->
<?php

$image = "https://graph.facebook.com/". $_SESSION['FBID']. "/picture";
if(strstr($_SESSION['FBID'], "@")){
    $image = "../images/launchleader-short.png";
}

$_GET['trailer'] = urldecode(urldecode(urldecode(urldecode($_GET['trailer']))));

?>
<div class="section section-signup">
			<div class="shell">
				<div class="section-body">
					<div class="login" align=center>
							<img src="<?php echo $image;?>" height=60 width=60>
							<h3>Hey! <i><?php echo $_SESSION['FULLNAME']; ?></i></h3><br>
							<h5>Fund: <h3>$<?php echo $_GET['trailfor']; ?></h3> to <?php echo $_GET['ttfull']; ?></h5> <br><br>
							<h5>For: <h3><?php echo $_GET['trailer']; ?></h3></h5><br>
                                <?php 
                                $logOutStr = "trailer=$funding_for&trailto=$trailto&ttfull=$fullname&trailfor=$trailfor&pledged=$pledged&pledgegoal=$pledgegoal&eId=$eId&anonymous=$anonymous";
                          ?>                            
                                If you are not <?php echo $_SESSION['FULLNAME']; ?> <br>Please <a href="logout?<?php echo $logOutStr; ?>">&lt;&lt;&nbsp; CLICK &nbsp;&gt;&gt;</a>here 
                                <br>    <br>       <br>
                                            <form action="" method="POST">
                                              <script
                                                src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                                                    data-key="<?php echo STRIPE_PUBLIC_KEY; ?>"
                                                    data-email = "<?php echo $_SESSION['EMAIL']; ?>"
                                                                 data-amount="<?php echo $trailforcent;?>"
                                                                  data-name="<?php echo $fullname;?>"
                                                                  data-description="<?php echo $funding_for;?> ($<?php echo $trailfor;?>.00)"
                                                                  data-image="images/launchleader-short.png"
                                                >
                                              </script>
                                            </form>
<!--                            -- >
<input class="form-control"
       type="number"
       id="custom-donation-amount"
       placeholder="50.00"
       min="0"
       step="10.00"/>
<script src="https://checkout.stripe.com/checkout.js"></script>
<button id="customButton ">Purchase</button>
<script>
  var handler = StripeCheckout.configure({
    key: '<?php echo STRIPE_PUBLIC_KEY; ?>',
    image: 'images/launchleader-short.png',
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
    }
  });

  document.getElementById('customButton').addEventListener('click', function(e) {
    // This line is the only real modification...
    var amount = $("#custom-donation-amount").val() * 100;
    handler.open({
      name: '<?php echo $fullname;?>',
      description: 'Some donation',
      // ... aside from this line where we use the value.
      amount: amount
    });
    e.preventDefault();
  });
</script>
-->
<div align=center><img src="../images/stripe-powered.jpg" width="120px" height="25px"> </div>
			<br>
			<br>
                            <h5><a href="../profile/<?php echo $_SESSION['uname'].$pmodestr; ?>">&lt;&lt;&nbsp; GO BACK</a></h5>
					</div><!-- /.login --> 
				</div><!-- /.section-body -->
			</div><!-- /.shell -->
		</div><!-- /.section section-user-interactions -->


<!--
<li></li>
<li class="nav-header">To whom</li>
<li><?php echo $_GET['trailto']; ?></li>


<div><a href="logout.php">Logout</a></div>
</ul>
<?php else: ?>     <!-- Before login -- > 
<div class="container">
<h1>Login with Facebook</h1>
           Not Connected
<div>
      <a href="social/fmttll">Login with Facebook</a></div>
      </div>
    <?php endif ?>
    
-->    
<?php
include 'payment_footer.php';
?>