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

&Launchleader::read_account();
#&Launchleader::select_account($Launchleader::account_id) if($Launchleader::account_id);

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
        Search \uaccount:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <FORM ACTION="$Launchleader::ACCOUNTS_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::account->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_username" value="$Launchleader::account->{'account_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Password: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_password" value="$Launchleader::account->{'account_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name first: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_first" value="$Launchleader::account->{'account_name_first'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name last: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_last" value="$Launchleader::account->{'account_name_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Phone: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_phone" value="$Launchleader::account->{'account_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_email" value="$Launchleader::account->{'account_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_desc" ROWS="10" COLS="50">$Launchleader::account->{'account_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_note" ROWS="10" COLS="50">$Launchleader::account->{'account_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Agree: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_agree" value="$Launchleader::account->{'account_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Created: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_created" value="$Launchleader::account->{'account_created'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Accessed: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_accessed" value="$Launchleader::account->{'account_accessed'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_type" value="$Launchleader::account->{'account_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Verified: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verified" value="$Launchleader::account->{'account_verified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_status" value="$Launchleader::account->{'account_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Partnercrumb: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partnercrumb" value="$Launchleader::account->{'account_partnercrumb'}">
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
        <FORM ACTION="$Launchleader::ACCOUNT_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::ACCOUNTS_CGI">
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
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_username" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_username&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Username</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_password" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_password&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Password</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_name_first" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_name_first&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Name first</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_name_last" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_name_last&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Name last</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_phone" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_phone&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Phone</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_email" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_email&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Email</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_desc" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_desc&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Desc</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_note" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_note&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Note</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_agree" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_agree&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Agree</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_created" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_created&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Created</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_accessed" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_accessed&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Accessed</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_type" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_type&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Type</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_verified" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_verified&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Verified</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_status" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Status</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "account_partnercrumb" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::ACCOUNTS_CGI?stage=2&order_by=account_partnercrumb&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Partnercrumb</A></B>
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

&Launchleader::select_accounts($where);
while(&Launchleader::next_account())
{
   &Launchleader::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<A HREF="$Launchleader::ACCOUNT_CGI?stage=1&mode=edit&account_id=$Launchleader::account->{'account_id'}&order_by=account_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchleader::HSTR">Edit ($Launchleader::account->{'account_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_username'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_password'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_name_first'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_name_last'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_phone'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_email'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_desc'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_note'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_agree'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_created'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_accessed'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_type'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_verified'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::account->{'account_partnercrumb'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
  	<A HREF="$Launchleader::ACCOUNT_CGI?stage=2&mode=delete&account_id=$Launchleader::account->{'account_id'}&$Launchleader::HSTR">Delete (
	$Launchleader::account->{'account_id'}
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
        <FORM ACTION="$Launchleader::ACCOUNT_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchleader::ACCOUNTS_CGI">
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

my $total = &Launchleader::count_table('account',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchleader::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchleader::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchleader::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchleader::account->{'account_id'})
{
   $WHERE .= "AND account_id = $Launchleader::account->{'account_id'} ";
}  
if($Launchleader::account->{'account_username'})
{
	$Launchleader::account->{'account_username'} .= "%";
        $Launchleader::account->{'account_username'} = $Launchleader::dbh->quote($Launchleader::account->{'account_username'});
   $WHERE .= "AND account_username LIKE $Launchleader::account->{'account_username'} ";
}  
if($Launchleader::account->{'account_password'})
{
	$Launchleader::account->{'account_password'} .= "%";
        $Launchleader::account->{'account_password'} = $Launchleader::dbh->quote($Launchleader::account->{'account_password'});
   $WHERE .= "AND account_password LIKE $Launchleader::account->{'account_password'} ";
}  
if($Launchleader::account->{'account_name_first'})
{
	$Launchleader::account->{'account_name_first'} .= "%";
        $Launchleader::account->{'account_name_first'} = $Launchleader::dbh->quote($Launchleader::account->{'account_name_first'});
   $WHERE .= "AND account_name_first LIKE $Launchleader::account->{'account_name_first'} ";
}  
if($Launchleader::account->{'account_name_last'})
{
	$Launchleader::account->{'account_name_last'} .= "%";
        $Launchleader::account->{'account_name_last'} = $Launchleader::dbh->quote($Launchleader::account->{'account_name_last'});
   $WHERE .= "AND account_name_last LIKE $Launchleader::account->{'account_name_last'} ";
}  
if($Launchleader::account->{'account_phone'})
{
	$Launchleader::account->{'account_phone'} .= "%";
        $Launchleader::account->{'account_phone'} = $Launchleader::dbh->quote($Launchleader::account->{'account_phone'});
   $WHERE .= "AND account_phone LIKE $Launchleader::account->{'account_phone'} ";
}  
if($Launchleader::account->{'account_email'})
{
	$Launchleader::account->{'account_email'} .= "%";
        $Launchleader::account->{'account_email'} = $Launchleader::dbh->quote($Launchleader::account->{'account_email'});
   $WHERE .= "AND account_email LIKE $Launchleader::account->{'account_email'} ";
}  
if($Launchleader::account->{'account_desc'})
{
	$Launchleader::account->{'account_desc'} .= "%";
        $Launchleader::account->{'account_desc'} = $Launchleader::dbh->quote($Launchleader::account->{'account_desc'});
   $WHERE .= "AND account_desc LIKE $Launchleader::account->{'account_desc'} ";
}  
if($Launchleader::account->{'account_note'})
{
	$Launchleader::account->{'account_note'} .= "%";
        $Launchleader::account->{'account_note'} = $Launchleader::dbh->quote($Launchleader::account->{'account_note'});
   $WHERE .= "AND account_note LIKE $Launchleader::account->{'account_note'} ";
}  
if($Launchleader::account->{'account_agree'})
{
   $WHERE .= "AND account_agree = $Launchleader::account->{'account_agree'} ";
}  
if($Launchleader::account->{'account_created'})
{
   $WHERE .= "AND account_created = $Launchleader::account->{'account_created'} ";
}  
if($Launchleader::account->{'account_accessed'})
{
   $WHERE .= "AND account_accessed = $Launchleader::account->{'account_accessed'} ";
}  
if($Launchleader::account->{'account_type'})
{
   $WHERE .= "AND account_type = $Launchleader::account->{'account_type'} ";
}  
if($Launchleader::account->{'account_verified'})
{
   $WHERE .= "AND account_verified = $Launchleader::account->{'account_verified'} ";
}  
if($Launchleader::account->{'account_status'})
{
   $WHERE .= "AND account_status = $Launchleader::account->{'account_status'} ";
}  
if($Launchleader::account->{'account_partnercrumb'})
{
	$Launchleader::account->{'account_partnercrumb'} .= "%";
        $Launchleader::account->{'account_partnercrumb'} = $Launchleader::dbh->quote($Launchleader::account->{'account_partnercrumb'});
   $WHERE .= "AND account_partnercrumb LIKE $Launchleader::account->{'account_partnercrumb'} ";
}  


return $WHERE;
}
