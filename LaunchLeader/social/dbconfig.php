<?php

	define('DB_SERVER', 'DATABASE.rackspaceclouddb.com');
	define('DB_USERNAME','MY_DB_USERNAME');    // DB username
	define('DB_PASSWORD', 'MY_DB_PASSWORD');    // DB password
	define('DB_DATABASE', 'MY_DATABASE_NAME');      // DB name
	
	$connection = mysql_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD) or die( "Unable to connect");
	$database = mysql_select_db(DB_DATABASE) or die( "Unable to select database");
    
?>
