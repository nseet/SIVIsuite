package Launchleader;

# Required packages
use Custom;
use CGI;
use URI::Escape;
use lib '/home/packages'; 
use dream;
use headers;
use strict;

use Account;
use Account_detail;
use Account_detail_status;
use Account_detail_type;
use Account_element;
use Account_funder;
use Account_partner;
use Account_status;
use Account_type;
use Account_verification;
use Answer;
use Answer_status;
use Answer_type;
use Category;
use Category_status;
use Category_type;
use Completed_tools;
use Conversation_details;
use Conversation_track;
use Conversation_type;
use Detail;
use Detail_status;
use Detail_type;
use Element;
use Element_detail;
use Element_type;
use Email_disburse;
use Fund_disbursed;
use Funding_details;
use Funding_milestones;
use Inbox;
use Package;
use Package_detail;
use Param;
use Password_reset;
use Question;
use Question_status;
use Question_type;
use Stripe_connect;
use Stripe_customers;
use Subscriber;
use User_update;


BEGIN {
    use vars qw(@ISA @EXPORT 
		$_query $DEBUG $uid $cid $username $passwordenc $conf $dbh $sth $HIDDEN $HSTR $ERROR
		$SITE_URL $CGI_URL
		$INDEX_CGI $PARAM_CGI $PARAMS_CGI 
$ACCOUNT_CGI $ACCOUNTS_CGI $ACCOUNT_DETAIL_CGI $ACCOUNT_DETAILS_CGI $ACCOUNT_DETAIL_STATUS_CGI $ACCOUNT_DETAIL_STATUSS_CGI $ACCOUNT_DETAIL_TYPE_CGI $ACCOUNT_DETAIL_TYPES_CGI $ACCOUNT_ELEMENT_CGI $ACCOUNT_ELEMENTS_CGI $ACCOUNT_FUNDER_CGI $ACCOUNT_FUNDERS_CGI $ACCOUNT_PARTNER_CGI $ACCOUNT_PARTNERS_CGI $ACCOUNT_STATUS_CGI $ACCOUNT_STATUSS_CGI $ACCOUNT_TYPE_CGI $ACCOUNT_TYPES_CGI $ACCOUNT_VERIFICATION_CGI $ACCOUNT_VERIFICATIONS_CGI $ANSWER_CGI $ANSWERS_CGI $ANSWER_STATUS_CGI $ANSWER_STATUSS_CGI $ANSWER_TYPE_CGI $ANSWER_TYPES_CGI $CATEGORY_CGI $CATEGORYS_CGI $CATEGORY_STATUS_CGI $CATEGORY_STATUSS_CGI $CATEGORY_TYPE_CGI $CATEGORY_TYPES_CGI $COMPLETED_TOOLS_CGI $COMPLETED_TOOLSS_CGI $CONVERSATION_DETAILS_CGI $CONVERSATION_DETAILSS_CGI $CONVERSATION_TRACK_CGI $CONVERSATION_TRACKS_CGI $CONVERSATION_TYPE_CGI $CONVERSATION_TYPES_CGI $DETAIL_CGI $DETAILS_CGI $DETAIL_STATUS_CGI $DETAIL_STATUSS_CGI $DETAIL_TYPE_CGI $DETAIL_TYPES_CGI $ELEMENT_CGI $ELEMENTS_CGI $ELEMENT_DETAIL_CGI $ELEMENT_DETAILS_CGI $ELEMENT_TYPE_CGI $ELEMENT_TYPES_CGI $EMAIL_DISBURSE_CGI $EMAIL_DISBURSES_CGI $FUND_DISBURSED_CGI $FUND_DISBURSEDS_CGI $FUNDING_DETAILS_CGI $FUNDING_DETAILSS_CGI $FUNDING_MILESTONES_CGI $FUNDING_MILESTONESS_CGI $INBOX_CGI $INBOXS_CGI $PACKAGE_CGI $PACKAGES_CGI $PACKAGE_DETAIL_CGI $PACKAGE_DETAILS_CGI $PARAM_CGI $PARAMS_CGI $PASSWORD_RESET_CGI $PASSWORD_RESETS_CGI $QUESTION_CGI $QUESTIONS_CGI $QUESTION_STATUS_CGI $QUESTION_STATUSS_CGI $QUESTION_TYPE_CGI $QUESTION_TYPES_CGI $STRIPE_CONNECT_CGI $STRIPE_CONNECTS_CGI $STRIPE_CUSTOMERS_CGI $STRIPE_CUSTOMERSS_CGI $SUBSCRIBER_CGI $SUBSCRIBERS_CGI $USER_UPDATE_CGI $USER_UPDATES_CGI 
		$HFILE $TABLE_WIDTH $FONT $SIZE $COLOR_1 $COLOR_2 $COLOR $COLS
	
		$params 
$account $account_sth $account_detail $account_detail_sth $account_detail_status $account_detail_status_sth $account_detail_type $account_detail_type_sth $account_element $account_element_sth $account_funder $account_funder_sth $account_partner $account_partner_sth $account_status $account_status_sth $account_type $account_type_sth $account_verification $account_verification_sth $answer $answer_sth $answer_status $answer_status_sth $answer_type $answer_type_sth $category $category_sth $category_status $category_status_sth $category_type $category_type_sth $completed_tools $completed_tools_sth $conversation_details $conversation_details_sth $conversation_track $conversation_track_sth $conversation_type $conversation_type_sth $detail $detail_sth $detail_status $detail_status_sth $detail_type $detail_type_sth $element $element_sth $element_detail $element_detail_sth $element_type $element_type_sth $email_disburse $email_disburse_sth $fund_disbursed $fund_disbursed_sth $funding_details $funding_details_sth $funding_milestones $funding_milestones_sth $inbox $inbox_sth $package $package_sth $package_detail $package_detail_sth $param $param_sth $password_reset $password_reset_sth $question $question_sth $question_status $question_status_sth $question_type $question_type_sth $stripe_connect $stripe_connect_sth $stripe_customers $stripe_customers_sth $subscriber $subscriber_sth $user_update $user_update_sth 
		);

    # Export symbols
    @ISA= qw(Exporter);
	
    $_query = new CGI;
    $conf = $_query->param('conf');
    $dbh = Connect("launchleader:127.0.0.1");
    $DEBUG = 0;

    $SITE_URL = "https://vip.launchleader.com";
    $CGI_URL = "/cgi-bin/2";
    $INDEX_CGI = "$CGI_URL/index.cgi";
    $PARAM_CGI = "$CGI_URL/param.cgi";
    $PARAMS_CGI = "$CGI_URL/params.cgi";
    $ACCOUNT_CGI = "$CGI_URL/account.cgi";
    $ACCOUNTS_CGI = "$CGI_URL/accounts.cgi";
    $ACCOUNT_DETAIL_CGI = "$CGI_URL/account_detail.cgi";
    $ACCOUNT_DETAILS_CGI = "$CGI_URL/account_details.cgi";
    $ACCOUNT_DETAIL_STATUS_CGI = "$CGI_URL/account_detail_status.cgi";
    $ACCOUNT_DETAIL_STATUSS_CGI = "$CGI_URL/account_detail_statuss.cgi";
    $ACCOUNT_DETAIL_TYPE_CGI = "$CGI_URL/account_detail_type.cgi";
    $ACCOUNT_DETAIL_TYPES_CGI = "$CGI_URL/account_detail_types.cgi";
    $ACCOUNT_ELEMENT_CGI = "$CGI_URL/account_element.cgi";
    $ACCOUNT_ELEMENTS_CGI = "$CGI_URL/account_elements.cgi";
    $ACCOUNT_FUNDER_CGI = "$CGI_URL/account_funder.cgi";
    $ACCOUNT_FUNDERS_CGI = "$CGI_URL/account_funders.cgi";
    $ACCOUNT_PARTNER_CGI = "$CGI_URL/account_partner.cgi";
    $ACCOUNT_PARTNERS_CGI = "$CGI_URL/account_partners.cgi";
    $ACCOUNT_STATUS_CGI = "$CGI_URL/account_status.cgi";
    $ACCOUNT_STATUSS_CGI = "$CGI_URL/account_statuss.cgi";
    $ACCOUNT_TYPE_CGI = "$CGI_URL/account_type.cgi";
    $ACCOUNT_TYPES_CGI = "$CGI_URL/account_types.cgi";
    $ACCOUNT_VERIFICATION_CGI = "$CGI_URL/account_verification.cgi";
    $ACCOUNT_VERIFICATIONS_CGI = "$CGI_URL/account_verifications.cgi";
    $ANSWER_CGI = "$CGI_URL/answer.cgi";
    $ANSWERS_CGI = "$CGI_URL/answers.cgi";
    $ANSWER_STATUS_CGI = "$CGI_URL/answer_status.cgi";
    $ANSWER_STATUSS_CGI = "$CGI_URL/answer_statuss.cgi";
    $ANSWER_TYPE_CGI = "$CGI_URL/answer_type.cgi";
    $ANSWER_TYPES_CGI = "$CGI_URL/answer_types.cgi";
    $CATEGORY_CGI = "$CGI_URL/category.cgi";
    $CATEGORYS_CGI = "$CGI_URL/categorys.cgi";
    $CATEGORY_STATUS_CGI = "$CGI_URL/category_status.cgi";
    $CATEGORY_STATUSS_CGI = "$CGI_URL/category_statuss.cgi";
    $CATEGORY_TYPE_CGI = "$CGI_URL/category_type.cgi";
    $CATEGORY_TYPES_CGI = "$CGI_URL/category_types.cgi";
    $COMPLETED_TOOLS_CGI = "$CGI_URL/completed_tools.cgi";
    $COMPLETED_TOOLSS_CGI = "$CGI_URL/completed_toolss.cgi";
    $CONVERSATION_DETAILS_CGI = "$CGI_URL/conversation_details.cgi";
    $CONVERSATION_DETAILSS_CGI = "$CGI_URL/conversation_detailss.cgi";
    $CONVERSATION_TRACK_CGI = "$CGI_URL/conversation_track.cgi";
    $CONVERSATION_TRACKS_CGI = "$CGI_URL/conversation_tracks.cgi";
    $CONVERSATION_TYPE_CGI = "$CGI_URL/conversation_type.cgi";
    $CONVERSATION_TYPES_CGI = "$CGI_URL/conversation_types.cgi";
    $DETAIL_CGI = "$CGI_URL/detail.cgi";
    $DETAILS_CGI = "$CGI_URL/details.cgi";
    $DETAIL_STATUS_CGI = "$CGI_URL/detail_status.cgi";
    $DETAIL_STATUSS_CGI = "$CGI_URL/detail_statuss.cgi";
    $DETAIL_TYPE_CGI = "$CGI_URL/detail_type.cgi";
    $DETAIL_TYPES_CGI = "$CGI_URL/detail_types.cgi";
    $ELEMENT_CGI = "$CGI_URL/element.cgi";
    $ELEMENTS_CGI = "$CGI_URL/elements.cgi";
    $ELEMENT_DETAIL_CGI = "$CGI_URL/element_detail.cgi";
    $ELEMENT_DETAILS_CGI = "$CGI_URL/element_details.cgi";
    $ELEMENT_TYPE_CGI = "$CGI_URL/element_type.cgi";
    $ELEMENT_TYPES_CGI = "$CGI_URL/element_types.cgi";
    $EMAIL_DISBURSE_CGI = "$CGI_URL/email_disburse.cgi";
    $EMAIL_DISBURSES_CGI = "$CGI_URL/email_disburses.cgi";
    $FUND_DISBURSED_CGI = "$CGI_URL/fund_disbursed.cgi";
    $FUND_DISBURSEDS_CGI = "$CGI_URL/fund_disburseds.cgi";
    $FUNDING_DETAILS_CGI = "$CGI_URL/funding_details.cgi";
    $FUNDING_DETAILSS_CGI = "$CGI_URL/funding_detailss.cgi";
    $FUNDING_MILESTONES_CGI = "$CGI_URL/funding_milestones.cgi";
    $FUNDING_MILESTONESS_CGI = "$CGI_URL/funding_milestoness.cgi";
    $INBOX_CGI = "$CGI_URL/inbox.cgi";
    $INBOXS_CGI = "$CGI_URL/inboxs.cgi";
    $PACKAGE_CGI = "$CGI_URL/package.cgi";
    $PACKAGES_CGI = "$CGI_URL/packages.cgi";
    $PACKAGE_DETAIL_CGI = "$CGI_URL/package_detail.cgi";
    $PACKAGE_DETAILS_CGI = "$CGI_URL/package_details.cgi";
    $PARAM_CGI = "$CGI_URL/param.cgi";
    $PARAMS_CGI = "$CGI_URL/params.cgi";
    $PASSWORD_RESET_CGI = "$CGI_URL/password_reset.cgi";
    $PASSWORD_RESETS_CGI = "$CGI_URL/password_resets.cgi";
    $QUESTION_CGI = "$CGI_URL/question.cgi";
    $QUESTIONS_CGI = "$CGI_URL/questions.cgi";
    $QUESTION_STATUS_CGI = "$CGI_URL/question_status.cgi";
    $QUESTION_STATUSS_CGI = "$CGI_URL/question_statuss.cgi";
    $QUESTION_TYPE_CGI = "$CGI_URL/question_type.cgi";
    $QUESTION_TYPES_CGI = "$CGI_URL/question_types.cgi";
    $STRIPE_CONNECT_CGI = "$CGI_URL/stripe_connect.cgi";
    $STRIPE_CONNECTS_CGI = "$CGI_URL/stripe_connects.cgi";
    $STRIPE_CUSTOMERS_CGI = "$CGI_URL/stripe_customers.cgi";
    $STRIPE_CUSTOMERSS_CGI = "$CGI_URL/stripe_customerss.cgi";
    $SUBSCRIBER_CGI = "$CGI_URL/subscriber.cgi";
    $SUBSCRIBERS_CGI = "$CGI_URL/subscribers.cgi";
    $USER_UPDATE_CGI = "$CGI_URL/user_update.cgi";
    $USER_UPDATES_CGI = "$CGI_URL/user_updates.cgi";


    $HFILE = 'empty.html';
    $FONT = "Arial";
    $SIZE = "3"; 
    $TABLE_WIDTH = "95%";
    $COLOR_1 = "#EEEEEE";    
    $COLOR_2 = "#CCCCCC";    
    $COLOR = $COLOR_1;
    $COLS = 3;

    #requires the param table (see param.sql) and Param.pm 
    &load_params();

sub load_params 
{               
   &select_params("WHERE param_id > 0 AND param_id < 100");

   while(&next_param())
   {
        $params->{"$param->{'param_name'}"} = $param->{'param_value'};
        #print STDERR "STATUS: Setting Parameter $param->{'param_name'} = $param->{'param_value'}\n";
   }
    
   return;
}


sub setCookie
{
   my $ip = shift;
   my $user = shift;
   my $dbh = shift;   

   if(!$ip) { return; }

   if(!$user)
   {
    my $statement = "select max(userid) from users";
    my $sth = Execute($statement, $dbh);
    $user = Fetchone($sth) + 1;

    my $cookie = $_query->cookie(-name=>"user",
                                 -value=>"$user",
                                 -expires=>'+10y',
                                 -path=>'/',
                                 -domain=>".$SITE_URL",
                                 -secure=>0);
    print "Set-Cookie: $cookie\n";
    
    $statement = "insert into users values($user,'$ip',NOW())";
    
    Execute($statement, $dbh);
   }

   return $user;
    
}                                 

sub do_check_login
{
   $username = $_query->param('u');
   $passwordenc = $_query->param('p');
   my $plain_pass = 0;
   my $check_only = shift || 1;  #xxx change to 0 before go live

   if($passwordenc !~ /^\.v/)
   { 
       $plain_pass = 1; 
   }

   my $u = $dbh->quote($username); 
   my $p = $dbh->quote($passwordenc);
   my $p2 = $dbh->quote($passwordenc);

   if($plain_pass == 1)
   {
      $passwordenc = get_enc($passwordenc,$dbh);
      $p = $dbh->quote($passwordenc);
   } 

   &select_accounts("WHERE account_username=$u and account_password=$p");
   &next_account();

   #Password was set in account table as plain - update it!
   if($plain_pass == 1 && !$account->{'account_id'})
   {
      &select_accounts("WHERE account_username = $u and account_password=$p2");
      &next_account();

      if($account->{'account_id'})
      {
	 &update_account("account_password=$p");	
      }
   } 

   $uid = $account->{'account_id'};

   if(!$uid && !$check_only)
   {
       print "Location: $SITE_URL/$INDEX_CGI\n\n";
       Disconnect($dbh);
       exit;
   }

   $HIDDEN = "<INPUT TYPE=\"hidden\" NAME=\"u\" VALUE=\"$username\">
	   <INPUT TYPE=\"hidden\" NAME=\"p\" VALUE=\"$passwordenc\">";

   $HSTR = "u=$username&p=$passwordenc";

   return; 
}


sub toggle_color
{
   if($COLOR eq $COLOR_1)
   { $COLOR = $COLOR_2; }
   else
   { $COLOR = $COLOR_1; }

   return;
}

sub get_option_name
{
   my $id = shift;
   my $table = shift;

   my $sth = Execute("SELECT name FROM $table WHERE id = $id", $dbh); 
   my ($name) = Fetchone($sth);

   print STDERR "SELECT name FROM $table WHERE id = $id\n\n--$name--\n\n";

   return $name;
}

sub count_table 
{
   my $table = shift;
   my $WHERE = shift;

   my $statement = "SELECT COUNT(*) FROM $table
        $WHERE   
        ";
   Execute($statement,$dbh);

   my $count = Fetchone(Execute($statement,$dbh));
   return $count;
}

sub sum_table
{
   my $table = shift;
   my $col = shift;
   my $WHERE = shift;

   my $statement = "SELECT SUM($col) FROM $table
	         $WHERE
		         ";
			    
   Execute($statement,$dbh);

   my $sum = Fetchone(Execute($statement,$dbh));	          
	
   return $sum;
	  
}



sub max_table  
{
   my $col = shift;  
   my $table = shift;
   my $WHERE = shift;
   
   my $statement = "SELECT MAX($col) FROM $table
        $WHERE
        ";
   Execute($statement,$dbh);
   
   my $max = Fetchone(Execute($statement,$dbh));  
   return $max;  
}


sub min_table
{
   my $col = shift;
   my $table = shift;
   my $WHERE = shift;

   my $statement = "SELECT MIN($col) FROM $table
        $WHERE
        ";
   Execute($statement,$dbh);

   my $min = Fetchone(Execute($statement,$dbh));
   return $min;
}

#returns comma separated list
sub group_concat 
{
   my $col = shift;
   my $table = shift;
   my $WHERE = shift;
   
   my $statement = "SELECT GROUP_CONCAT($col) FROM $table
        $WHERE
        ";
   Execute($statement,$dbh);
   
   my $group_concat = Fetchone(Execute($statement,$dbh));  
   return $group_concat;  

}

sub html_options
{
my $column_id = shift;
my $column_name = shift;
my $table = shift;
my $order_by = shift || $column_name;
my $default = shift;
my $str;

my $sth = Execute("SELECT $column_id, $column_name FROM $table ORDER BY $order_by", $dbh);
while(my ($id, $name) = Fetch($sth))
{
my $selected;
   $selected = "selected" if($id == $default);
$str .= "<OPTION VALUE=\"$id\" $selected>$name</OPTION>";
}

return $str;

}

sub clean_exit
{               
Disconnect($dbh);
exit;
}

sub sendmail 
{   
    my $to = shift;  
    my $subject = shift;
    my $body = shift;
    my $from = shift;
    my $cc = shift;
    
    open(MAIL, "|/usr/lib/sendmail -f$from $to");
    print(MAIL "To: $to\n");
    print(MAIL "Cc: $cc\n") if($cc);
    print(MAIL "From: $from\n");
    print(MAIL "Subject: $subject\n");                                           
    print(MAIL "$body\n\n"); 
    close(MAIL);

return;
}

}  #End Module     
1;
