<?php
error_reporting(1);
require_once 'pconfig.php';

if (isset($_GET['tsu'])) {
    $username = urldecode($_GET['tsu']);
} 

$server = 'http://'.$_SERVER['HTTP_HOST'];
$toShortURL = "$server/profile/$username";

$shortURL =  bitly_shorten($toShortURL);

function bitly_shorten($url){
  $query = array(
    "version" => "2.0.1",
    "longUrl" => $url,
    "login" => BITLY_API_LOGIN, // replace with your login
    "apiKey" => BITLY_API_KEY // replace with your api key
  );

  $query = http_build_query($query);

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "http://api.bitly.com/v3/shorten?".$query);
  curl_setopt($ch, CURLOPT_HEADER, 0);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

  $response = curl_exec($ch);
  curl_close($ch);

  $response = json_decode($response);
  if( $response->status_txt == "OK") {        
    return $response->data->url;
  } else {
    return null;
  }
}

?>

<div class="popup">
		<div class="popup-head" id="confirmation">
		<h2><b>Share this link through email to maximize your impact</b></h2>
	</div><!-- /.popup-head -->
	<div class="popup-body">
		<div class="form form-refer">
				<div class="form-body">
					<div class="form-row">
						<div class="form-controls">
					     		<input type="text" name="short_url" id="short_url" class="field" value="<?php echo $shortURL;?>" placeholder="<?php echo $toShortURL;?>"  onClick="javascript:this.select();" />
						</div><!-- /.form-controls -->
					</div><!-- /.form-row -->
				</div><!-- /.form-body -->
				<div class="form-actions">
				</div><!-- /.form-actions -->
		</div><!-- /.form form-refer -->
	</div><!-- /.popup-body -->
</div><!-- /.popup -->
