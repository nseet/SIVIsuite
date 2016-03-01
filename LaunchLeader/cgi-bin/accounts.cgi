#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $PER_PAGE = 25;

my $stage = $Launchh::_query->param('stage') || 2;
my $limit = $Launchh::_query->param('limit') || $PER_PAGE;
$limit =~ s/\W//gis;
my $offset= $Launchh::_query->param('offset') || 0;
$offset =~ s/\W//gis;
my $order_by= $Launchh::_query->param('order_by');
$order_by =~ s/\W//gis;
my $order_dir= $Launchh::_query->param('order_dir') || "DESC";
$order_dir =~ s/\W//gis;

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_account();
#&Launchh::select_account($Launchh::account_id) if($Launchh::account_id);

my $WHERE = &Launchh::uri_unescape($Launchh::_query->param('WHERE'))  || get_where();
my $WHERE_ESC = &Launchh::uri_escape($WHERE);

if($stage == 1)
{
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage1();
   print &Launchh::html_footer($Launchh::HFILE);
}
elsif($stage==2)
{	
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage2();
   print &Launchh::html_footer($Launchh::HFILE);
}

&Launchh::clean_exit();


sub html_stage1
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
        Search \uaccount:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
        <FORM ACTION="$Launchh::ACCOUNTS_CGI" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
        <INPUT TYPE="HIDDEN" NAME="u" VALUE="$Launchh::username">
        <INPUT TYPE="HIDDEN" NAME="p" VALUE="$Launchh::passwordenc">
        <TABLE BORDER="0" CELLPADDING="3">
		<!--TR><TD><FONT FACE="$Trade::FONT" SIZE="$Trade::SIZE">
                WHERE Statement: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="WHERE" ROWS="10" COLS="50">$WHERE</TEXTAREA>
                </FONT>
                <P>
                <INPUT TYPE="submit" NAME="Search" VALUE="Search">
                <HR>
                </TD></TR-->
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchh::account->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_username" value="$Launchh::account->{'account_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Password: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_password" value="$Launchh::account->{'account_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name first: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_first" value="$Launchh::account->{'account_name_first'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name last: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_last" value="$Launchh::account->{'account_name_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Phone: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_phone" value="$Launchh::account->{'account_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_email" value="$Launchh::account->{'account_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_desc" ROWS="10" COLS="50">$Launchh::account->{'account_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_note" ROWS="10" COLS="50">$Launchh::account->{'account_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Agree: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_agree" value="$Launchh::account->{'account_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Created: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_created" value="$Launchh::account->{'account_created'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Accessed: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_accessed" value="$Launchh::account->{'account_accessed'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_type" value="$Launchh::account->{'account_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_status" value="$Launchh::account->{'account_status'}">
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
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0" CELLPADDING="4" CELLSPACING="0">
   <TR>
	<TD COLSPAN="10">
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$page_str
	</FONT>
	</TD>
   </TR>
   <TR>
        <TD>
        <FORM ACTION="$Launchh::ACCOUNT_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::ACCOUNTS_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="submit" NAME="Done" VALUE="Search">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::INDEX_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="2">
        <INPUT TYPE="submit" NAME="Done" VALUE="Done">
        </FORM>
        </TD>
   </TR>
   <TR BGCOLOR="$Launchh::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_username&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Username</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_password&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Password</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_name_first&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Name first</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_name_last&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Name last</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_phone&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Phone</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_email&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Email</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_desc&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Desc</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_note&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Note</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_agree&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Agree</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_created&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Created</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_accessed&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Accessed</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_type&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Type</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
        <B><A HREF="$Launchh::ACCOUNTS_CGI?stage=2&order_by=account_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Status</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">	
        <B>Delete</B>
        </FONT>
        </TD>

   </TR>

EOM

my $where = $WHERE;
$where .= " ORDER BY $order_by $order_dir " if($order_by);
$where .= " LIMIT $offset,$limit " if($limit);

&Launchh::select_accounts($where);
while(&Launchh::next_account())
{
   &Launchh::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchh::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<A HREF="$Launchh::ACCOUNT_CGI?stage=1&mode=edit&account_id=$Launchh::account->{'account_id'}&order_by=account_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchh::HSTR">Edit ($Launchh::account->{'account_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_username'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_password'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_name_first'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_name_last'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_phone'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_email'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_desc'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_note'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_agree'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_created'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_accessed'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_type'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::account->{'account_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
  	<A HREF="$Launchh::ACCOUNT_CGI?stage=2&mode=delete&account_id=$Launchh::account->{'account_id'}&$Launchh::HSTR">Delete (
	$Launchh::account->{'account_id'}
	)</A>
        </FONT>
        </TD>

   </TR>
EOM
}

$str .= << "EOM";
   <TR>
	<TD COLSPAN="10">
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$page_str
	</FONT>
	</TD>
   </TR>
   <TR>
        <TD>
        <FORM ACTION="$Launchh::ACCOUNT_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchh::ACCOUNTS_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="submit" NAME="Done" VALUE="Search">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::INDEX_CGI">
        $Launchh::HIDDEN
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

my $total = &Launchh::count_table('account',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchh::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchh::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchh::ACCOUNTS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchh::account->{'account_id'})
{
   $WHERE .= "AND account_id = $Launchh::account->{'account_id'} ";
}  
if($Launchh::account->{'account_username'})
{
	$Launchh::account->{'account_username'} .= "%";
        $Launchh::account->{'account_username'} = $Launchh::dbh->quote($Launchh::account->{'account_username'});
   $WHERE .= "AND account_username LIKE $Launchh::account->{'account_username'} ";
}  
if($Launchh::account->{'account_password'})
{
	$Launchh::account->{'account_password'} .= "%";
        $Launchh::account->{'account_password'} = $Launchh::dbh->quote($Launchh::account->{'account_password'});
   $WHERE .= "AND account_password LIKE $Launchh::account->{'account_password'} ";
}  
if($Launchh::account->{'account_name_first'})
{
	$Launchh::account->{'account_name_first'} .= "%";
        $Launchh::account->{'account_name_first'} = $Launchh::dbh->quote($Launchh::account->{'account_name_first'});
   $WHERE .= "AND account_name_first LIKE $Launchh::account->{'account_name_first'} ";
}  
if($Launchh::account->{'account_name_last'})
{
	$Launchh::account->{'account_name_last'} .= "%";
        $Launchh::account->{'account_name_last'} = $Launchh::dbh->quote($Launchh::account->{'account_name_last'});
   $WHERE .= "AND account_name_last LIKE $Launchh::account->{'account_name_last'} ";
}  
if($Launchh::account->{'account_phone'})
{
	$Launchh::account->{'account_phone'} .= "%";
        $Launchh::account->{'account_phone'} = $Launchh::dbh->quote($Launchh::account->{'account_phone'});
   $WHERE .= "AND account_phone LIKE $Launchh::account->{'account_phone'} ";
}  
if($Launchh::account->{'account_email'})
{
	$Launchh::account->{'account_email'} .= "%";
        $Launchh::account->{'account_email'} = $Launchh::dbh->quote($Launchh::account->{'account_email'});
   $WHERE .= "AND account_email LIKE $Launchh::account->{'account_email'} ";
}  
if($Launchh::account->{'account_desc'})
{
	$Launchh::account->{'account_desc'} .= "%";
        $Launchh::account->{'account_desc'} = $Launchh::dbh->quote($Launchh::account->{'account_desc'});
   $WHERE .= "AND account_desc LIKE $Launchh::account->{'account_desc'} ";
}  
if($Launchh::account->{'account_note'})
{
	$Launchh::account->{'account_note'} .= "%";
        $Launchh::account->{'account_note'} = $Launchh::dbh->quote($Launchh::account->{'account_note'});
   $WHERE .= "AND account_note LIKE $Launchh::account->{'account_note'} ";
}  
if($Launchh::account->{'account_agree'})
{
   $WHERE .= "AND account_agree = $Launchh::account->{'account_agree'} ";
}  
if($Launchh::account->{'account_created'})
{
   $WHERE .= "AND account_created = $Launchh::account->{'account_created'} ";
}  
if($Launchh::account->{'account_accessed'})
{
   $WHERE .= "AND account_accessed = $Launchh::account->{'account_accessed'} ";
}  
if($Launchh::account->{'account_type'})
{
   $WHERE .= "AND account_type = $Launchh::account->{'account_type'} ";
}  
if($Launchh::account->{'account_status'})
{
   $WHERE .= "AND account_status = $Launchh::account->{'account_status'} ";
}  


return $WHERE;
}
