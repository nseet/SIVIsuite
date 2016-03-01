<?php

	define('DB_SERVER', 'DATABASE.rackspaceclouddb.com');
	define('DB_USERNAME', 'DB_USERNAME');    // DB username
	define('DB_PASSWORD', 'DB_PASSWORD');    // DB password
	define('DB_DATABASE', 'launchleader');      // DB name
	$connection = mysql_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD) or die( "Unable to connect");
	$database = mysql_select_db(DB_DATABASE) or die( "Unable to select database");
    
?>
