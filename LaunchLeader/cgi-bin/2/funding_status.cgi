#!/usr/bin/perl

use lib '/lamp/vhosts/application/vlaunchleader/cgi-bin/2';
use Launchleader;
use strict;

my $funding_status;

my $PER_PAGE = 100;

my $stage = $Launchleader::_query->param('stage') || 2;
my $limit = $Launchleader::_query->param('limit') || $PER_PAGE;
$limit =~ s/\W//gis;
my $offset= $Launchleader::_query->param('offset') || 0;
$offset =~ s/\W//gis;
my $order_by= $Launchleader::_query->param('order_by');
$order_by =~ s/\W//gis;
my $order_dir= $Launchleader::_query->param('order_dir') || "DESC";
$order_dir =~ s/\W//gis;

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_funding_milestones();
#&Launchleader::select_funding_milestones($funding_status_id) if($funding_status_id);

my $WHERE = &Launchleader::uri_unescape($Launchleader::_query->param('WHERE'))  || get_where();
my $WHERE_ESC = &Launchleader::uri_escape($WHERE);

if($stage == 1)
{
   print $Launchleader::_query->header();
   print &Launchleader::html_header($Launchleader::HFILE);
   print html_stage1();
   print &Launchleader::html_footer($Launchleader::HFILE);
}
elsif($stage==2)
{	
   print $Launchleader::_query->header();
   print &Launchleader::html_header($Launchleader::HFILE);
   print html_stage2();
   print &Launchleader::html_footer($Launchleader::HFILE);
}

&Launchleader::clean_exit();


sub html_stage1
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        Search \ufunding_milestones:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <FORM ACTION="/cgi-bin/2/funding_status.cgi" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
        <INPUT TYPE="HIDDEN" NAME="u" VALUE="$Launchleader::username">
        <INPUT TYPE="HIDDEN" NAME="p" VALUE="$Launchleader::passwordenc">
        <TABLE BORDER="0" CELLPADDING="3">
		<!--TR><TD><FONT FACE="$Trade::FONT" SIZE="$Trade::SIZE">
                WHERE Statement: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="WHERE" ROWS="10" COLS="50">$WHERE</TEXTAREA>
                </FONT>
                <P>
                <INPUT TYPE="submit" NAME="Search" VALUE="Search">
                <HR>
                </TD></TR-->
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_milestones_id" value="$funding_status->{'funding_milestones_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$funding_status->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="element_id" value="$funding_status->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funding failure emailed: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_failure_emailed" value="$funding_status->{'funding_failure_emailed'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_milestones_datetime" value="$funding_status->{'funding_milestones_datetime'}">
		</FONT></TD></TR>

                <TR><TD>
                <INPUT TYPE="reset" NAME="Reset" VALUE="Reset">&nbsp;&nbsp;&nbsp;
                <INPUT TYPE="submit" NAME="Search" VALUE="Search">
                </TD></TR>
        </TABLE>
        </FORM>
        </FONT>
        </TD>
   </TR>

</TABLE>
EOM

return $str;

}
sub html_stage2
{
my $lorder_dir;
my $page_str = &get_page_str();

my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0" CELLPADDING="4" CELLSPACING="0">
   <TR>
	<TD COLSPAN="10">
	<FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$page_str
	</FONT>
	</TD>
   </TR>
   <TR>
        <TD>
        <FORM ACTION="$Launchleader::FUNDING_MILESTONES_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="/cgi-bin/2/funding_status.cgi">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="submit" NAME="Done" VALUE="Search">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::INDEX_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="2">
        <INPUT TYPE="submit" NAME="Done" VALUE="Done">
        </FORM>
        </TD>
   </TR>
   <TR BGCOLOR="$Launchleader::COLOR">

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B>Account</B>
	</FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "element_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B>Element</B>
	</FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "funding_failure_emailed" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B>Percent Raised</B>
	</FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "funding_milestones_datetime" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="/cgi-bin/2/funding_status.cgi?stage=2&order_by=funding_milestones_datetime&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Ends/Funded</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">	
        <B>Delete</B>
        </FONT>
        </TD>

   </TR>

EOM

my $where = $WHERE;
my $order = " ORDER BY $order_by $order_dir " if($order_by);
my $limit = " LIMIT $offset,$limit " if($limit);

#LEFT JOIN fund_disbursed ON account_id=fund_disbursed.account_id AND element.element_id=fund_disbursed.element_id

my $sth = &Launchleader::Execute("
SELECT *,round(sum(funding_details.fund_amount)/100) as fund_total,round((round(sum(funding_details.fund_amount)/100)/element_amount) * 100) as pct_total, DATE_ADD(funding_milestones_datetime,INTERVAL +30 day) as date_ends
FROM  account,funding_milestones,funding_details,element 
$where AND account.account_id=funding_milestones.account_id AND funding_milestones.account_id=funding_details.account_id and funding_milestones.element_id=element.element_id and funding_details.element_id=element.element_id 
GROUP BY account.account_id,funding_milestones_id
HAVING date_ends >= NOW()
ORDER BY date_ends DESC
$limit
",$Launchleader::dbh);

while(my $funding_status = &Launchleader::HFetch($sth))
{
   my $sth2 = &Launchleader::Execute("SELECT fund_disbursed_datetime FROM fund_disbursed WHERE account_id=$funding_status->{'account_id'} AND element_id=$funding_status->{'element_id'}",$Launchleader::dbh);
   my $fund_disbursed_datetime = &Launchleader::Fetchone($sth2);
   &Launchleader::toggle_color();

my $boldo; my $boldc;
if($funding_status->{'pct_total'} >= 100)
{
   $boldo = "<B>";
   $boldc = "<\/B>";
}
   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<A HREF="https://vip.launchleader.com/profile/$funding_status->{'account_username'}" target-new="tab" target="_blank">$funding_status->{'account_username'}</A>
        <A HREF="$Launchleader::ACCOUNTS_CGI?$Launchleader::HSTR&stage=2&account_id=$funding_status->{'account_id'}&mode=edit" target-new="tab" target="_blank">($funding_status->{'account_id'})</A> <I>$funding_status->{'account_partnercrumb'}</I>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$funding_status->{'element_name'}
        <A HREF="$Launchleader::ELEMENTS_CGI?$Launchleader::HSTR&stage=2&element_id=$funding_status->{'element_id'}&mode=edit" target-new="tab" target="_blank">$funding_status->{'element_id'}</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 	$boldo<A HREF="https://vip.launchleader.com/admin/dashboard?$Launchleader::HSTR&stage=2&element_id=$funding_status->{'element_id'}&aid=$funding_status->{'account_id'}&pmode=launchleader" target-new="tab" target="_blank">$funding_status->{'pct_total'}% (\$$funding_status->{'fund_total'}/\$$funding_status->{'element_amount'})</A>
        $boldc</FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$boldo$funding_status->{'date_ends'} / $fund_disbursed_datetime$boldc
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
  	<A HREF="$Launchleader::FUNDING_MILESTONES_CGI?stage=2&mode=delete&funding_milestones_id=$funding_status->{'funding_milestones_id'}&$Launchleader::HSTR">Delete (
	$funding_status->{'funding_milestones_id'}
	)</A>
        </FONT>
        </TD>
   </TR>
EOM
}

  $str .= << "EOM";
   <TR BGCOLOR="red">
        <TD COLSPAN="5" VALIGN="TOP" ALIGN="CENTER"> 
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <HR>
	</FONT>
        </TD>
      
   </TR>
EOM


$sth = &Launchleader::Execute("
SELECT *,round(sum(funding_details.fund_amount)/100) as fund_total,round((round(sum(funding_details.fund_amount)/100)/element_amount) * 100) as pct_total, DATE_ADD(funding_milestones_datetime,INTERVAL +30 day) as date_ends
FROM  account,funding_milestones,funding_details,element
$where AND account.account_id=funding_milestones.account_id AND funding_milestones.account_id=funding_details.account_id and funding_milestones.element_id=element.element_id and funding_details.element_id=element.element_id 
GROUP BY account.account_id,funding_milestones_id
HAVING date_ends < NOW()
ORDER BY date_ends DESC
$limit
",$Launchleader::dbh);

while(my $funding_status = &Launchleader::HFetch($sth))
{
   my $sth2 = &Launchleader::Execute("SELECT fund_disbursed_datetime FROM fund_disbursed WHERE account_id=$funding_status->{'account_id'} AND element_id=$funding_status->{'element_id'}",$Launchleader::dbh);
   my $fund_disbursed_datetime = &Launchleader::Fetchone($sth2);
   &Launchleader::toggle_color();

my $boldo; my $boldc;
if($funding_status->{'pct_total'} >= 100)
{  
   $boldo = "<B>";
   $boldc = "<\/B>";
}

   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <A HREF="https://vip.launchleader.com/profile/$funding_status->{'account_username'}" target-new="tab" target="_blank">$funding_status->{'account_username'}</A>
        <A HREF="$Launchleader::ACCOUNTS_CGI?$Launchleader::HSTR&stage=2&account_id=$funding_status->{'account_id'}&mode=edit" target-new="tab" target="_blank">($funding_status->{'account_id'})</A> <I>$funding_status->{'account_partnercrumb'}</I>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        $funding_status->{'element_name'}
        <A HREF="$Launchleader::ELEMENTS_CGI?$Launchleader::HSTR&stage=2&element_id=$funding_status->{'element_id'}&mode=edit" target-new="tab" target="_blank">$funding_status->{'element_id'}</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        $boldo<A HREF="https://vip.launchleader.com/admin/dashboard?$Launchleader::HSTR&stage=2&element_id=$funding_status->{'element_id'}&aid=$funding_status->{'account_id'}&pmode=launchleader" target-new="tab" target="_blank">$funding_status->{'pct_total'}% (\$$funding_status->{'fund_total'}/\$$funding_status->{'element_amount'})</A>
        $boldc</FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        $boldo$funding_status->{'date_ends'} / $fund_disbursed_datetime$boldc
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <A HREF="$Launchleader::FUNDING_MILESTONES_CGI?stage=2&mode=delete&funding_milestones_id=$funding_status->{'funding_milestones_id'}&$Launchleader::HSTR">Delete (
        $funding_status->{'funding_milestones_id'}
        )</A>
        </FONT>
        </TD>

   </TR>
EOM
}



$str .= << "EOM";
   <TR>
	<TD COLSPAN="10">
	<FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$page_str
	</FONT>
	</TD>
   </TR>
   <TR>
        <TD>
        <FORM ACTION="$Launchleader::FUNDING_MILESTONES_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="/cgi-bin/2/funding_status.cgi">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="submit" NAME="Done" VALUE="Search">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::INDEX_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="2">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Done">
        </FORM>
        </TD>
   </TR>
</TABLE>
EOM

return $str;

}


sub get_page_str
{
if(!$limit)
{
   return "";
}

my $str;

my $total = &Launchleader::count_table('funding_milestones',$WHERE);
my $total_pages = int($total/$limit) + 1;
my $cur_page = int($offset/$limit) + 1;
my $page_min = $offset + 1;
my $page_max = $offset + $limit;

if($cur_page > 1)
{
   my $previous_offset = $offset - $limit;
   if($previous_offset < 0)
   {
	$previous_offset = 0;
   }

   $str .= "[ <A HREF=\"/cgi-bin/2/funding_status.cgi?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
}

# $str .= " Now viewing $page_min-$page_max of $total (Page $cur_page of $total_pages) ";

if($total_pages > 1)
{
$str .= " [";
for(my $page = 1; $page <= $total_pages; $page += int($total_pages/10 + 1))
{
   my $page_offset = ($page * $limit) - $limit;
   my $ob;
   my $cb;
   if($page == $cur_page)
   {
	$ob = "<B>";
	$cb = "</B>";
   }
   $str .= " <A HREF=\"/cgi-bin/2/funding_status.cgi?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
}
chop($str);
$str .= "] ";
}

if($cur_page < $total_pages)
{
   my $next_offset = $offset + $limit;
   if($next_offset < 0)
   {
	$next_offset = 0;
   }

   $str .= "[ <A HREF=\"/cgi-bin/2/funding_status.cgi?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($funding_status->{'funding_milestones_id'})
{
   $WHERE .= "AND funding_milestones_id = $funding_status->{'funding_milestones_id'} ";
}  
if($funding_status->{'account_id'})
{
   $WHERE .= "AND account_id = $funding_status->{'account_id'} ";
}  
if($funding_status->{'element_id'})
{
   $WHERE .= "AND element_id = $funding_status->{'element_id'} ";
}  
if($funding_status->{'funding_failure_emailed'})
{
   $WHERE .= "AND funding_failure_emailed = $funding_status->{'funding_failure_emailed'} ";
}  
if($funding_status->{'funding_milestones_datetime'})
{
   $WHERE .= "AND funding_milestones_datetime = $funding_status->{'funding_milestones_datetime'} ";
}  


return $WHERE;
}
