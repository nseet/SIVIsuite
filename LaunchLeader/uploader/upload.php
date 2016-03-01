<?php

## vmentor.t1v1.com
$output_dir = "/home/sivi/vmentor.co/uploads/";

if(isset($_GET["user_id"]) && $_GET["user_id"]){

    if(isset($_GET["upload_type"]) && $_GET["upload_type"] != ''){
        $output_dir .=$_GET["user_id"]."/".$_GET["upload_type"]."/";
    }

    if (!is_dir($output_dir) && !mkdir($output_dir, 0777, true)) {
    }
}

if(isset($_FILES["myfile"]))
{
	$ret = array();
    
	$error =$_FILES["myfile"]["error"];
	
	//You need to handle  both cases
	//If Any browser does not support serializing of multiple files using FormData() 
	if(!is_array($_FILES["myfile"]["name"])) //single file
	{
 	 	$fileName = $_FILES["myfile"]["name"];
		
		#$timestamp = strtotime("now");
		#$extension =  pathinfo($fileName, PATHINFO_EXTENSION);

		#$newFileName = $timestamp.".".$extension;
		
		$done = "yes";
 		if(move_uploaded_file($_FILES["myfile"]["tmp_name"],$output_dir.$fileName)){
			$done = "completed";
		}
		else{
			$done = "failed";
		}
		$ret[]= $fileName ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ;
	}
	else  //Multiple files, file[]
	{
	  $fileCount = count($_FILES["myfile"]["name"]);
	  for($i=0; $i < $fileCount; $i++)
	  {
	  	$fileName = $_FILES["myfile"]["name"][$i];
		move_uploaded_file($_FILES["myfile"]["tmp_name"][$i],$output_dir.$fileName);
	  	$ret[]= $fileName;
	  }
	}
    echo json_encode($ret);
 }
 ?>
