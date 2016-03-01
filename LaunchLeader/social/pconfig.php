<?php 
require_once 'dbconfig.php'; 

$result = mysql_query("SELECT param_name, param_value FROM `param` WHERE param_desc LIKE 'LaunchLeader%'");

while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
  define(''.$row['param_name'], $row['param_value']);
}

#$ini_array = parse_ini_file('/home/sivi/launch/launchleader.ini');

define('BITLY_API_LOGIN', 'MY_BITLY_API_LOGIN');
define('BITLY_API_KEY', 'MY_BITLY_API_KEY');

?>
