#!/usr/bin/perl

use Launchleader;
use strict;

my $PER_PAGE = 25;

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

&Launchleader::read_fund_disbursed();
#&Launchleader::select_fund_disbursed($Launchleader::fund_disbursed_id) if($Launchleader::fund_disbursed_id);

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
        Search \ufund_disbursed:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <FORM ACTION="$Launchleader::FUND_DISBURSEDS_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_id" value="$Launchleader::fund_disbursed->{'fund_disbursed_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::fund_disbursed->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Project id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="project_id" value="$Launchleader::fund_disbursed->{'project_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="element_id" value="$Launchleader::fund_disbursed->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Fund amount: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_amount" value="$Launchleader::fund_disbursed->{'fund_amount'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="disburse_status" value="$Launchleader::fund_disbursed->{'disburse_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Application fee: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="application_fee" value="$Launchleader::fund_disbursed->{'application_fee'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse token: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="disburse_token" value="$Launchleader::fund_disbursed->{'disburse_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funding details id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_id" value="$Launchleader::fund_disbursed->{'funding_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_status" value="$Launchleader::fund_disbursed->{'fund_disbursed_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_datetime" value="$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}">
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
        <FORM ACTION="$Launchleader::FUND_DISBURSED_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::FUND_DISBURSEDS_CGI">
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

if($order_by eq "fund_disbursed_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=fund_disbursed_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

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
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Account id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "project_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=project_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Project id</A></B>
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
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=element_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Element id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "fund_amount" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=fund_amount&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Fund amount</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "disburse_status" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=disburse_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Disburse status</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "application_fee" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=application_fee&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Application fee</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "disburse_token" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=disburse_token&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Disburse token</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "funding_details_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=funding_details_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Funding details id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "fund_disbursed_status" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=fund_disbursed_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Status</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "fund_disbursed_datetime" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::FUND_DISBURSEDS_CGI?stage=2&order_by=fund_disbursed_datetime&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Datetime</A></B>
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
$where .= " ORDER BY $order_by $order_dir " if($order_by);
$where .= " LIMIT $offset,$limit " if($limit);

&Launchleader::select_fund_disburseds($where);
while(&Launchleader::next_fund_disbursed())
{
   &Launchleader::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<A HREF="$Launchleader::FUND_DISBURSED_CGI?stage=1&mode=edit&fund_disbursed_id=$Launchleader::fund_disbursed->{'fund_disbursed_id'}&order_by=fund_disbursed_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchleader::HSTR">Edit ($Launchleader::fund_disbursed->{'fund_disbursed_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'account_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'project_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'element_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'fund_amount'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'disburse_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'application_fee'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'disburse_token'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'funding_details_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'fund_disbursed_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
  	<A HREF="$Launchleader::FUND_DISBURSED_CGI?stage=2&mode=delete&fund_disbursed_id=$Launchleader::fund_disbursed->{'fund_disbursed_id'}&$Launchleader::HSTR">Delete (
	$Launchleader::fund_disbursed->{'fund_disbursed_id'}
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
        <FORM ACTION="$Launchleader::FUND_DISBURSED_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchleader::FUND_DISBURSEDS_CGI">
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

my $total = &Launchleader::count_table('fund_disbursed',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchleader::FUND_DISBURSEDS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchleader::FUND_DISBURSEDS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchleader::FUND_DISBURSEDS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchleader::fund_disbursed->{'fund_disbursed_id'})
{
   $WHERE .= "AND fund_disbursed_id = $Launchleader::fund_disbursed->{'fund_disbursed_id'} ";
}  
if($Launchleader::fund_disbursed->{'account_id'})
{
   $WHERE .= "AND account_id = $Launchleader::fund_disbursed->{'account_id'} ";
}  
if($Launchleader::fund_disbursed->{'project_id'})
{
   $WHERE .= "AND project_id = $Launchleader::fund_disbursed->{'project_id'} ";
}  
if($Launchleader::fund_disbursed->{'element_id'})
{
   $WHERE .= "AND element_id = $Launchleader::fund_disbursed->{'element_id'} ";
}  
if($Launchleader::fund_disbursed->{'fund_amount'})
{
   $WHERE .= "AND fund_amount = $Launchleader::fund_disbursed->{'fund_amount'} ";
}  
if($Launchleader::fund_disbursed->{'disburse_status'})
{
	$Launchleader::fund_disbursed->{'disburse_status'} .= "%";
        $Launchleader::fund_disbursed->{'disburse_status'} = $Launchleader::dbh->quote($Launchleader::fund_disbursed->{'disburse_status'});
   $WHERE .= "AND disburse_status LIKE $Launchleader::fund_disbursed->{'disburse_status'} ";
}  
if($Launchleader::fund_disbursed->{'application_fee'})
{
   $WHERE .= "AND application_fee = $Launchleader::fund_disbursed->{'application_fee'} ";
}  
if($Launchleader::fund_disbursed->{'disburse_token'})
{
	$Launchleader::fund_disbursed->{'disburse_token'} .= "%";
        $Launchleader::fund_disbursed->{'disburse_token'} = $Launchleader::dbh->quote($Launchleader::fund_disbursed->{'disburse_token'});
   $WHERE .= "AND disburse_token LIKE $Launchleader::fund_disbursed->{'disburse_token'} ";
}  
if($Launchleader::fund_disbursed->{'funding_details_id'})
{
   $WHERE .= "AND funding_details_id = $Launchleader::fund_disbursed->{'funding_details_id'} ";
}  
if($Launchleader::fund_disbursed->{'fund_disbursed_status'})
{
   $WHERE .= "AND fund_disbursed_status = $Launchleader::fund_disbursed->{'fund_disbursed_status'} ";
}  
if($Launchleader::fund_disbursed->{'fund_disbursed_datetime'})
{
   $WHERE .= "AND fund_disbursed_datetime = $Launchleader::fund_disbursed->{'fund_disbursed_datetime'} ";
}  


return $WHERE;
}
