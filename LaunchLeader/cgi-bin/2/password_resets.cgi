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

&Launchleader::read_password_reset();
#&Launchleader::select_password_reset($Launchleader::password_reset_id) if($Launchleader::password_reset_id);

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
        Search \upassword_reset:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
        <FORM ACTION="$Launchleader::PASSWORD_RESETS_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="password_reset_id" value="$Launchleader::password_reset->{'password_reset_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="password_reset_username" value="$Launchleader::password_reset->{'password_reset_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Token: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="password_reset_token" value="$Launchleader::password_reset->{'password_reset_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Taken: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="password_reset_taken" value="$Launchleader::password_reset->{'password_reset_taken'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Expire: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="password_reset_expire" value="$Launchleader::password_reset->{'password_reset_expire'}">
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
        <FORM ACTION="$Launchleader::PASSWORD_RESET_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchleader::PASSWORD_RESETS_CGI">
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

if($order_by eq "password_reset_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::PASSWORD_RESETS_CGI?stage=2&order_by=password_reset_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "password_reset_username" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::PASSWORD_RESETS_CGI?stage=2&order_by=password_reset_username&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Username</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "password_reset_token" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::PASSWORD_RESETS_CGI?stage=2&order_by=password_reset_token&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Token</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "password_reset_taken" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::PASSWORD_RESETS_CGI?stage=2&order_by=password_reset_taken&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Taken</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
EOM

if($order_by eq "password_reset_expire" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchleader::PASSWORD_RESETS_CGI?stage=2&order_by=password_reset_expire&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchleader::HSTR&WHERE=$WHERE_ESC">Expire</A></B>
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

&Launchleader::select_password_resets($where);
while(&Launchleader::next_password_reset())
{
   &Launchleader::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchleader::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<A HREF="$Launchleader::PASSWORD_RESET_CGI?stage=1&mode=edit&password_reset_id=$Launchleader::password_reset->{'password_reset_id'}&order_by=password_reset_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchleader::HSTR">Edit ($Launchleader::password_reset->{'password_reset_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::password_reset->{'password_reset_username'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::password_reset->{'password_reset_token'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::password_reset->{'password_reset_taken'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	$Launchleader::password_reset->{'password_reset_expire'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
  	<A HREF="$Launchleader::PASSWORD_RESET_CGI?stage=2&mode=delete&password_reset_id=$Launchleader::password_reset->{'password_reset_id'}&$Launchleader::HSTR">Delete (
	$Launchleader::password_reset->{'password_reset_id'}
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
        <FORM ACTION="$Launchleader::PASSWORD_RESET_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchleader::PASSWORD_RESETS_CGI">
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

my $total = &Launchleader::count_table('password_reset',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchleader::PASSWORD_RESETS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchleader::PASSWORD_RESETS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchleader::PASSWORD_RESETS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchleader::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchleader::password_reset->{'password_reset_id'})
{
   $WHERE .= "AND password_reset_id = $Launchleader::password_reset->{'password_reset_id'} ";
}  
if($Launchleader::password_reset->{'password_reset_username'})
{
	$Launchleader::password_reset->{'password_reset_username'} .= "%";
        $Launchleader::password_reset->{'password_reset_username'} = $Launchleader::dbh->quote($Launchleader::password_reset->{'password_reset_username'});
   $WHERE .= "AND password_reset_username LIKE $Launchleader::password_reset->{'password_reset_username'} ";
}  
if($Launchleader::password_reset->{'password_reset_token'})
{
	$Launchleader::password_reset->{'password_reset_token'} .= "%";
        $Launchleader::password_reset->{'password_reset_token'} = $Launchleader::dbh->quote($Launchleader::password_reset->{'password_reset_token'});
   $WHERE .= "AND password_reset_token LIKE $Launchleader::password_reset->{'password_reset_token'} ";
}  
if($Launchleader::password_reset->{'password_reset_taken'})
{
   $WHERE .= "AND password_reset_taken = $Launchleader::password_reset->{'password_reset_taken'} ";
}  
if($Launchleader::password_reset->{'password_reset_expire'})
{
   $WHERE .= "AND password_reset_expire = $Launchleader::password_reset->{'password_reset_expire'} ";
}  


return $WHERE;
}
