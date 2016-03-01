<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<link href="uploadfile.css" rel="stylesheet">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="jquery.uploadfile.min.js"></script>
</head>
<body>
Scroll Issue:

<div id="mulitplefileuploader">Upload</div>

<div id="status"></div>
<script>
$(document).ready(function()
{
var settings = {
    url: "upload.php?user_id=124",
    dragDrop:true,
    fileName: "myfile",
    user_path:"124/image/",    
    allowedTypes:"jpg,png,gif,jpeg,bmp",	
    returnType:"json",
	 onSuccess:function(files,data,xhr)
    {
        alert((data));
    },
    showDelete:true,
    deleteCallback: function(data,pd)
	{
	    for(var i=0;i<data.length;i++)
	    {
		$.post("delete.php",{op:"delete",user_path:"124/image",name:data[i]},
		function(resp, textStatus, jqXHR)
		{
		    //Show Message  
		    $("#status").append("<div>File Deleted</div>");      
		});
	     }      
	    pd.statusbar.hide(); //You choice to hide/not.
	}
}
var uploadObj = $("#mulitplefileuploader").uploadFile(settings);


});
</script>
</body>

