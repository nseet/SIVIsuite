<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
	<title>Launch Leader v4</title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
	<link rel="shortcut icon" href="../css/images/favicon.ico" />
	<link rel="stylesheet" href="../css/fonts.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/colorbox.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/jquery.fs.selecter.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../css/style.css" type="text/css" media="all" />
         <!-- <link rel="stylesheet" href="../css/style-ll3.css" type="text/css" media="all" />-->
        	<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.carouFredSel-6.2.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="../js/jquery.fs.selecter.js"></script>
	
	<script src="https://www.youtube.com/iframe_api"></script>
	<script type="text/javascript" src="../js/youtube.js"></script>
	<script type="text/javascript" src="../js/functions.js"></script>
	
         <!-- <script src="//load.sumome.com/" data-sumo-site-id="a71e7fa4a47b10f19e33cada442fdcf80aeb9425630e0fd36d59811d39574dd2" async></script> -->
        
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <link rel="stylesheet" href="../css/chosen.css">
        <link href="../uploader/uploadfile.css" rel="stylesheet">
        <script src="../uploader/jquery.uploadfile.min.js"></script>
</head>
<body>
<div class="wrapper">
	<div class="header">
		<div class="shell">
			<div class="header-inner clearfix">
              <?php
                if($pmode == 'revtech'){
                    $homestr = '<a href="/partner/revtech" class="xlogo"><img src="../images/ReVTech_logo.png"></a>';
                }
                else if($pmode == 'unmla'){
                    $homestr = '<a href="/partner/unmla" class="xlogo"><img src="../images/los-alamos-logo.png"></a>';
                }
                else{
                    $homestr = '<a href="../index.html" class="logo"></a>';
                }
           ?>
				<?php echo "$homestr"; ?>
				<a href="#" class="nav-trigger"></a>

				<div class="nav">
					<ul>
						<li>
							<!-- <a href="discover-after-more.html">Discover</a> -->
							<a href="../discover<?php echo $pmodestr;?>">View Campaigns</a>
						</li>

                            <li>
                                <a href="https://vip.launchleader.com/How%20To%20Start%20Your%20Company%20Using%20LaunchLeader%20White%20Paper.pdf" target="_blank">How LaunchLeader Works</a>
                            </li>	

						<li>
							<a href="../faq<?php echo $pmodestr;?>">FAQ</a>
						</li>

						<li class="separator">
							<a href="../login<?php echo $pmodestr;?>">Login</a>
						</li>
					<!--
						<li class="signup">
							<a href="/signup.html">Sign Up</a>
						</li>	-->			
					</ul> 
				</div><!-- /.nav -->
				
				<div class="nav-access">
					<ul>
						<li>
							<a href="../signup<?php echo $pmodestr;?>" class="modal-trigger">Sign Up</a>
						</li>
					</ul>
				</div><!-- /.nav-access -->
			</div><!-- /.header-inner clearfix -->
		</div><!-- /.shell -->
	</div><!-- /.header -->

	<div class="main">
