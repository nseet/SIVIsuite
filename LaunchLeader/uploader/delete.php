<?php

## Launchh.com
#$output_dir = "/home/sivi/launch/uploads/";

## vmentor.t1v1.com
#$output_dir = "/home/sivi/vmentor.co/uploads/";

## vip.launchleader.com
$output_dir = "/var/www/vhosts/application/vlaunchleader/uploads/";

if(isset($_GET["user_id"]) && $_GET["user_id"]){
    $output_dir .=$_GET["user_id"]."/images/";
}

if(isset($_POST["op"]) && $_POST["op"] == "delete" && isset($_POST['name']))
{
	$fileName =$_POST['name'];
	$filePath = $output_dir. $fileName;
	if (file_exists($filePath)) 
	{
		unlink($filePath);
	}
	
	echo "Deleted File ".$fileName."<br>";
}

?>
