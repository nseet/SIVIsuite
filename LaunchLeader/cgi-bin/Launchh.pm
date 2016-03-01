package Launchh;

# Required packages
use Custom;
use CGI;
use URI::Escape;
use lib '/home/packages'; 
use dream;
use headers;
use strict;
#use Config::IniFiles;

use Account;
use Account_detail;
use Account_detail_status;
use Account_detail_type;
use Account_reward;
use Account_status;
use Account_element;
use Account_type;
use Answer;
use Answer_status;
use Answer_type;
use Category;
use Category_status;
use Category_type;
use Comment;
use Company;
use Company_status;
use Company_type;
use Conversation;
use Detail;
use Detail_status;
use Detail_type;
use PackageElement_detail;
use PackageElement;
use Entry;
use Entry_status;
use Entry_type;
use Feedback;
use Funding_detail;
use Inbox;
use Mmatch;
use Mmatch_status;
use Mmatch_type;
use Milestone;
use Param;
use Question;
use Question_status;
use Question_type;
use Reward;
use Reward_type;
use Stripe_detail;
use UserUpdate;
use Video;


BEGIN {
    use vars qw(@ISA @EXPORT 
		$_query $DEBUG $u $p $uid $cid $username $passwordenc $conf $dbh $sth $HIDDEN $HSTR $ERROR
		$SITE_URL $CGI_URL
		$INDEX_CGI $ACCOUNT_CGI $ACCOUNTS_CGI $ACCOUNT_DETAIL_CGI $ACCOUNT_DETAILS_CGI $ACCOUNT_DETAIL_STATUS_CGI $ACCOUNT_DETAIL_STATUSS_CGI $ACCOUNT_DETAIL_TYPE_CGI $ACCOUNT_DETAIL_TYPES_CGI $ACCOUNT_REWARD_CGI $ACCOUNT_REWARDS_CGI $ACCOUNT_STATUS_CGI $ACCOUNT_STATUSS_CGI $ACCOUNT_TYPE_CGI $ACCOUNT_TYPES_CGI $ANSWER_CGI $ANSWERS_CGI $ANSWER_STATUS_CGI $ANSWER_STATUSS_CGI $ANSWER_TYPE_CGI $ANSWER_TYPES_CGI $CATEGORY_CGI $CATEGORYS_CGI $CATEGORY_STATUS_CGI $CATEGORY_STATUSS_CGI $CATEGORY_TYPE_CGI $CATEGORY_TYPES_CGI $COMMENT_CGI $COMMENTS_CGI $COMPANY_CGI $COMPANYS_CGI $COMPANY_STATUS_CGI $COMPANY_STATUSS_CGI $COMPANY_TYPE_CGI $COMPANY_TYPES_CGI $DETAIL_CGI $DETAILS_CGI $DETAIL_STATUS_CGI $DETAIL_STATUSS_CGI $DETAIL_TYPE_CGI $DETAIL_TYPES_CGI $ENTRY_CGI $ENTRYS_CGI $ENTRY_STATUS_CGI $ENTRY_STATUSS_CGI $ENTRY_TYPE_CGI $ENTRY_TYPES_CGI $FEEDBACK_CGI $FEEDBACKS_CGI $INBOX_CGI $INBOXS_CGI $MMATCH_CGI $MMATCHS_CGI $MMATCH_STATUS_CGI $MMATCH_STATUSS_CGI $MMATCH_TYPE_CGI $MMATCH_TYPES_CGI $MILESTONE_CGI $MILESTONES_CGI $PARAM_CGI $PARAMS_CGI $QUESTION_CGI $QUESTIONS_CGI $QUESTION_STATUS_CGI $QUESTION_STATUSS_CGI $QUESTION_TYPE_CGI $QUESTION_TYPES_CGI $REWARD_CGI $REWARDS_CGI $REWARD_STATUS_CGI $REWARDS_STATUS_CGI $REWARD_TYPE_CGI $REWARD_TYPES_CGI $VIDEO_CGI $VIDEOS_CGI
		$HFILE $TABLE_WIDTH $FONT $SIZE $COLOR_1 $COLOR_2 $COLOR $COLS $CONFIG_INI $SERVER_STATUS 
        
        $STRIPE_PRIVATE_KEY $FB_APP_ID $STRIPE_PUBLIC_KEY $STRIPE_CLIENT_ID $SIVI_ADMIN_EMAIL $FROM_EMAIL_ADDRESS $CHARGE_LATER $TOKEN_URI $AUTHORIZE_URI $cfgt $DEFAULT_MILESTONE
        $params $account $account_sth $account_detail $account_detail_sth $account_detail_status $account_detail_status_sth $account_detail_type $account_detail_type_sth $account_reward $account_reward_sth $account_status $account_status_sth $account_type $account_type_sth $answer $answer_sth $answer_status $answer_status_sth $answer_type $answer_type_sth $category $category_sth $category_status $category_status_sth $category_type $category_type_sth $comment $comment_sth $company $company_sth $company_status $company_status_sth $company_type $company_type_sth $detail $detail_sth $detail_status $detail_status_sth $detail_type $detail_type_sth $entry $entry_sth $entry_status $entry_status_sth $entry_type $entry_type_sth $feedback $feedback_sth $inbox $inbox_sth $mmatch $mmatch_sth $mmatch_status $mmatch_status_sth $mmatch_type $mmatch_type_sth $milestone $milestone_sth $param $param_sth $question $question_sth $question_status $question_status_sth $question_type $question_type_sth $reward $reward_sth $reward_status $reward_status_sth $reward_type $reward_type_sth $video $video_sth 
		);

    # Export symbols
    @ISA= qw(Exporter);
	
    $_query = new CGI;
    $conf = $_query->param('conf');
    $dbh = Connect("launchh:mysql.launchh.com");
    $DEBUG = 0;

    $SITE_URL = "/";#http://www.launchleader.com";
    $CGI_URL = "/cgi-bin";
    $INDEX_CGI = "/";
    $PARAM_CGI = "/param";
    $PARAMS_CGI = "/params";
    $ACCOUNT_CGI = "/account";
    $ACCOUNTS_CGI = "/accounts";
    $ACCOUNT_DETAIL_CGI = "$CGI_URL/account_detail.cgi";
    $ACCOUNT_DETAILS_CGI = "$CGI_URL/account_details.cgi";
    $ACCOUNT_DETAIL_STATUS_CGI = "$CGI_URL/account_detail_status.cgi";
    $ACCOUNT_DETAIL_STATUSS_CGI = "$CGI_URL/account_detail_statuss.cgi";
    $ACCOUNT_DETAIL_TYPE_CGI = "$CGI_URL/account_detail_type.cgi";
    $ACCOUNT_DETAIL_TYPES_CGI = "$CGI_URL/account_detail_types.cgi";
    $ACCOUNT_REWARD_CGI = "$CGI_URL/account_reward.cgi";
    $ACCOUNT_REWARDS_CGI = "$CGI_URL/account_rewards.cgi";
    $ACCOUNT_STATUS_CGI = "$CGI_URL/account_status.cgi";
    $ACCOUNT_STATUSS_CGI = "$CGI_URL/account_statuss.cgi";
    $ACCOUNT_TYPE_CGI = "$CGI_URL/account_type.cgi";
    $ACCOUNT_TYPES_CGI = "$CGI_URL/account_types.cgi";
    $ANSWER_CGI = "/answer";
    $ANSWERS_CGI = "/answers";
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
    $COMMENT_CGI = "$CGI_URL/comment.cgi";
    $COMMENTS_CGI = "$CGI_URL/comments.cgi";
    $COMPANY_CGI = "$CGI_URL/company.cgi";
    $COMPANYS_CGI = "$CGI_URL/companys.cgi";
    $COMPANY_STATUS_CGI = "$CGI_URL/company_status.cgi";
    $COMPANY_STATUSS_CGI = "$CGI_URL/company_statuss.cgi";
    $COMPANY_TYPE_CGI = "$CGI_URL/company_type.cgi";
    $COMPANY_TYPES_CGI = "$CGI_URL/company_types.cgi";
    $DETAIL_CGI = "$CGI_URL/detail.cgi";
    $DETAILS_CGI = "$CGI_URL/details.cgi";
    $DETAIL_STATUS_CGI = "$CGI_URL/detail_status.cgi";
    $DETAIL_STATUSS_CGI = "$CGI_URL/detail_statuss.cgi";
    $DETAIL_TYPE_CGI = "$CGI_URL/detail_type.cgi";
    $DETAIL_TYPES_CGI = "$CGI_URL/detail_types.cgi";
    $ENTRY_CGI = "$CGI_URL/entry.cgi";
    $ENTRYS_CGI = "$CGI_URL/entrys.cgi";
    $ENTRY_STATUS_CGI = "$CGI_URL/entry_status.cgi";
    $ENTRY_STATUSS_CGI = "$CGI_URL/entry_statuss.cgi";
    $ENTRY_TYPE_CGI = "$CGI_URL/entry_type.cgi";
    $ENTRY_TYPES_CGI = "$CGI_URL/entry_types.cgi";
    $FEEDBACK_CGI = "$CGI_URL/feedback.cgi";
    $FEEDBACKS_CGI = "$CGI_URL/feedbacks.cgi";
    $INBOX_CGI = "$CGI_URL/inbox.cgi";
    $INBOXS_CGI = "$CGI_URL/inboxs.cgi";
    $MMATCH_CGI = "$CGI_URL/mmatch.cgi";
    $MMATCHS_CGI = "$CGI_URL/mmatchs.cgi";
    $MMATCH_STATUS_CGI = "$CGI_URL/mmatch_status.cgi";
    $MMATCH_STATUSS_CGI = "$CGI_URL/mmatch_statuss.cgi";
    $MMATCH_TYPE_CGI = "$CGI_URL/mmatch_type.cgi";
    $MMATCH_TYPES_CGI = "$CGI_URL/mmatch_types.cgi";
    $MILESTONE_CGI = "$CGI_URL/milestone.cgi";
    $MILESTONES_CGI = "$CGI_URL/milestones.cgi";
    $QUESTION_CGI = "/question";
    $QUESTIONS_CGI = "/questions";
    $QUESTION_STATUS_CGI = "$CGI_URL/question_status.cgi";
    $QUESTION_STATUSS_CGI = "$CGI_URL/question_statuss.cgi";
    $QUESTION_TYPE_CGI = "$CGI_URL/question_type.cgi";
    $QUESTION_TYPES_CGI = "$CGI_URL/question_types.cgi";
    $REWARD_CGI = "/reward";
    $REWARDS_CGI = "/rewards";
    $VIDEO_CGI = "video";
    $VIDEOS_CGI = "videos";
    #$SERVER_STATUS = "prod";

    $HFILE = 'empty.html';
    $FONT = "Arial";
    $SIZE = "3"; 
    $TABLE_WIDTH = "95%";
    $COLOR_1 = "#EEEEEE";    
    $COLOR_2 = "#CCCCCC";    
    $COLOR = $COLOR_1;
    $COLS = 3;
    #$CONFIG_INI = "/home/sivi/launch/launchleader.ini";
    
    #requires the param table (see param.sql) and Param.pm 
    &load_params();
    &load_ini_or_param();
    
 sub load_params 
{  
  ## We have to change the param max value according to the requirement
   &select_params("WHERE param_id > 0 AND param_id < 200");

   while(&next_param())
   {
        $params->{"$param->{'param_name'}"} = $param->{'param_value'};
        #print STDERR "STATUS: Setting Parameter $param->{'param_name'} = $param->{'param_value'}\n";
   }
    
   return;
}


sub load_ini_or_param
{  
=begin    
        We are blocking INI file reading for security purposes.
        my $cfgt = new Config::IniFiles( -file => "$CONFIG_INI");

    #Stripe
    $STRIPE_PRIVATE_KEY = $cfgt->val( "stripe", 'STRIPE_PRIVATE_KEY' ) if $cfgt->val( "stripe", 'STRIPE_PRIVATE_KEY' ); 
    $STRIPE_PUBLIC_KEY = $cfgt->val( "stripe", 'STRIPE_PUBLIC_KEY' ) if $cfgt->val( "stripe", 'STRIPE_PUBLIC_KEY' ); 
    $STRIPE_CLIENT_ID = $cfgt->val( "stripe", 'STRIPE_CLIENT_ID' ) if $cfgt->val( "stripe", 'STRIPE_CLIENT_ID' ); 
    $TOKEN_URI = $cfgt->val( "stripe", 'TOKEN_URI' ) if $cfgt->val( "stripe", 'TOKEN_URI' );
    $AUTHORIZE_URI = $cfgt->val( "stripe", 'AUTHORIZE_URI' ) if $cfgt->val( "stripe", 'AUTHORIZE_URI' );    
    $CHARGE_LATER = $cfgt->val( "stripe", 'CHARGE_LATER' ) if $cfgt->val( "stripe", 'CHARGE_LATER' );
    
    # Email
    $SIVI_ADMIN_EMAIL = $cfgt->val( "email", 'SIVI_ADMIN_EMAIL' ) if $cfgt->val( "email", 'SIVI_ADMIN_EMAIL' ); 
    $FROM_EMAIL_ADDRESS = $cfgt->val( "email", 'FROM_EMAIL_ADDRESS' ) if $cfgt->val( "email", 'FROM_EMAIL_ADDRESS' ); 
    
    # Facebook
    $FB_APP_ID = $cfgt->val("facebook", 'FB_APP_ID' ) if $cfgt->val( "facebook", 'FB_APP_ID' ); 
    
    #LaunchLeader
    $DEFAULT_MILESTONE = $cfgt->val("launchleader", 'DEFAULT_MILESTONE' ) if $cfgt->val( "launchleader", 'DEFAULT_MILESTONE' ); 
=cut     

    #Stripe
    $STRIPE_PRIVATE_KEY = $params->{'STRIPE_PRIVATE_KEY'} if $params->{'STRIPE_PRIVATE_KEY'} ;
    $STRIPE_PUBLIC_KEY = $params->{'STRIPE_PUBLIC_KEY'} if $params->{'STRIPE_PUBLIC_KEY'} ;
    $STRIPE_CLIENT_ID = $params->{'STRIPE_CLIENT_ID'} if $params->{'STRIPE_CLIENT_ID'} ;
    $TOKEN_URI = $params->{'TOKEN_URI'} if $params->{'TOKEN_URI'} ;
    $AUTHORIZE_URI = $params->{'AUTHORIZE_URI'} if $params->{'AUTHORIZE_URI'} ;
    $CHARGE_LATER = $params->{'CHARGE_LATER'} if $params->{'CHARGE_LATER'} ;
    
    # Email
    $SIVI_ADMIN_EMAIL = $params->{'SIVI_ADMIN_EMAIL'} if $params->{'SIVI_ADMIN_EMAIL'} ;
    $FROM_EMAIL_ADDRESS = $params->{'FROM_EMAIL_ADDRESS'} if $params->{'FROM_EMAIL_ADDRESS'} ;
    
    # Facebook
    $FB_APP_ID = $params->{'FB_APP_ID'} if $params->{'FB_APP_ID'} ;
    
    #LaunchLeader
    $DEFAULT_MILESTONE = $params->{'DEFAULT_MILESTONE'} if $params->{'DEFAULT_MILESTONE'} ;

#return $cfgt;
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
   $username = $_query->param('username') ||$_query->param('u') || $u if(!$username);
   $passwordenc = $_query->param('passwordenc') || $_query->param('p') || $p || $username if(!$passwordenc);
   my $mode = $_query->param('mode');   
   my $plain_pass = 0;
   my $check_only = shift || 0;  #xxx change to 0 before go live

   if($passwordenc !~ /^\.v/)
   { 
       $plain_pass = 1; 
   }

   $u = $dbh->quote($username) if($u !~ /^'/); 
   $p = $dbh->quote($passwordenc) if($p !~ /^'/ );
      
   my $p2 = $dbh->quote($username);
   
   $u = lc($u);

   if($plain_pass == 1)
   {
      $passwordenc = get_enc($passwordenc,$dbh);
      $p = $dbh->quote($passwordenc);
   } 

#print  << "EOM";
   &select_accounts("WHERE (LOWER(account_username)=$u or LOWER(account_email)=$u ) and account_password=$p");
   &next_account();
#EOM
   #Password was set in account table as plain - update it!
   if($plain_pass == 1 && !$account->{'account_id'})
   {
      &select_accounts("WHERE (LOWER(account_username)=$u or LOWER(account_email)=$u ) and account_password=$p2");
      &next_account();

      if($account->{'account_id'})
      {
	 &update_account("account_password=$p");	
      }
   } 

   $uid = $account->{'account_id'} if($account->{'account_id'} != '');
   $u  = $account->{'account_username'} if($account->{'account_username'} ne '');
   
   if(!$uid && !$check_only  && $mode !~ /^join/)
   {
       print "Location: $SITE_URL/login?cred=error\n\n";
       Disconnect($dbh);
       exit;
   }

   $HIDDEN = "<INPUT TYPE=\"hidden\" NAME=\"u\" VALUE=\"$username\">
	   <INPUT TYPE=\"hidden\" NAME=\"p\" VALUE=\"$passwordenc\">";

   $HSTR = "u=$username&p=$passwordenc";

   $u =~ s/'//gis;
   $p =~ s/'//gis;

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

=begin

sub sendmail 
{   
    my $to = shift;  
    my $subject = shift;
    my $body = shift;
    my $from = shift;
    my $cc = shift;
    #my $bcc = shift;
    
    open(MAIL, "|/usr/lib/sendmail -f$from $to");
    print(MAIL "To: $to\n");
    print(MAIL "Cc: $cc\n") if($cc ne '');
    #print(MAIL "Bcc: $cc\n") if($cc);
    print(MAIL "From: $from\n");
    print(MAIL "Subject: $subject\n");                                           
    print(MAIL "$body\n\n"); 
    close(MAIL);

return;
}

=cut

sub sendmail 
{
    my $to = shift;
    my $subject = shift;
    my $body = shift;
    my $from = shift;
    my $cc = shift || '';
    my $bcc = shift || '';
    my $reply_to = shift || '';
    
	$to =~ s/\'//;
	$cc =~ s/\'//;
	$bcc =~ s/\'//;

    open(MAIL, "|/usr/lib/sendmail -t");
    print(MAIL "To: $to\n");
    print(MAIL "Cc: $cc\n") if($cc);
    print(MAIL "Reply-to: $reply_to\n") if($reply_to ne '');
    print(MAIL "Bcc: $bcc\n") if($bcc);
    print(MAIL "From: $from\n");
    print(MAIL "Subject: $subject\n");
    print(MAIL "$body\n\n");
    close(MAIL);

return;
}

}  #End Module     
1;
