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

&Launchleader::read_user_update();
#&Launchleader::select_user_update($Launchleader::user_update_id) if($Launchleader::user_update_id);

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
        Search \uuser_update:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <FORM ACTION="$Launchleader::USER_UPDATES_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_id" value="$Launchleader::user_update->{'user_update_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::user_update->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Campaign id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="campaign_id" value="$Launchleader::user_update->{'campaign_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Title: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_title" value="$Launchleader::user_update->{'user_update_title'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Text: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="user_update_text" ROWS="10" COLS="50">$Launchleader::user_update->{'user_update_text'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Public: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_public" value="$Launchleader::user_update->{'user_update_public'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Sendemail: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_sendemail" value="$Launchleader::user_update->{'user_update_sendemail'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_datetime" value="$Launchleader::user_update->{'user_update_datetime'}">
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
        <FORM ACTION="$Launchleader::USER_UPDATE_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::USER_UPDATES_CGI">
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

if($order_by eq "user_update_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Id</A></B>
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
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Account id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "campaign_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=campaign_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Campaign id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "user_update_title" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_title&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Title</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "user_update_text" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_text&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Text</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "user_update_public" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_public&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Public</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "user_update_sendemail" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_sendemail&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Sendemail</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "user_update_datetime" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::USER_UPDATES_CGI?stage=2&order_by=user_update_datetime&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Datetime</A></B>
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

&Launchleader::select_user_updates($where);
while(&Launchleader::next_user_update())
{
   &Launchleader::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<A HREF="$Launchleader::USER_UPDATE_CGI?stage=1&mode=edit&user_update_id=$Launchleader::user_update->{'user_update_id'}&order_by=user_update_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchleader::HSTR">Edit ($Launchleader::user_update->{'user_update_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'account_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'campaign_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'user_update_title'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'user_update_text'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'user_update_public'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'user_update_sendemail'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::user_update->{'user_update_datetime'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
  	<A HREF="$Launchleader::USER_UPDATE_CGI?stage=2&mode=delete&user_update_id=$Launchleader::user_update->{'user_update_id'}&$Launchleader::HSTR">Delete (
	$Launchleader::user_update->{'user_update_id'}
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
        <FORM ACTION="$Launchleader::USER_UPDATE_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchleader::USER_UPDATES_CGI">
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

my $total = &Launchleader::count_table('user_update',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchleader::USER_UPDATES_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchleader::USER_UPDATES_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchleader::USER_UPDATES_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchleader::user_update->{'user_update_id'})
{
   $WHERE .= "AND user_update_id = $Launchleader::user_update->{'user_update_id'} ";
}  
if($Launchleader::user_update->{'account_id'})
{
   $WHERE .= "AND account_id = $Launchleader::user_update->{'account_id'} ";
}  
if($Launchleader::user_update->{'campaign_id'})
{
   $WHERE .= "AND campaign_id = $Launchleader::user_update->{'campaign_id'} ";
}  
if($Launchleader::user_update->{'user_update_title'})
{
	$Launchleader::user_update->{'user_update_title'} .= "%";
        $Launchleader::user_update->{'user_update_title'} = $Launchleader::dbh->quote($Launchleader::user_update->{'user_update_title'});
   $WHERE .= "AND user_update_title LIKE $Launchleader::user_update->{'user_update_title'} ";
}  
if($Launchleader::user_update->{'user_update_text'})
{
	$Launchleader::user_update->{'user_update_text'} .= "%";
        $Launchleader::user_update->{'user_update_text'} = $Launchleader::dbh->quote($Launchleader::user_update->{'user_update_text'});
   $WHERE .= "AND user_update_text LIKE $Launchleader::user_update->{'user_update_text'} ";
}  
if($Launchleader::user_update->{'user_update_public'})
{
   $WHERE .= "AND user_update_public = $Launchleader::user_update->{'user_update_public'} ";
}  
if($Launchleader::user_update->{'user_update_sendemail'})
{
   $WHERE .= "AND user_update_sendemail = $Launchleader::user_update->{'user_update_sendemail'} ";
}  
if($Launchleader::user_update->{'user_update_datetime'})
{
   $WHERE .= "AND user_update_datetime = $Launchleader::user_update->{'user_update_datetime'} ";
}  


return $WHERE;
}
