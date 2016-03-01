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

&Launchh::read_mmatch();
#&Launchh::select_mmatch($Launchh::mmatch_id) if($Launchh::mmatch_id);

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
        Search \ummatch:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
        <FORM ACTION="$Launchh::MMATCHS_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_id" value="$Launchh::mmatch->{'mmatch_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchh::mmatch->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_account_id" value="$Launchh::mmatch->{'mmatch_account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Score: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_score" value="$Launchh::mmatch->{'mmatch_score'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="mmatch_note" ROWS="10" COLS="50">$Launchh::mmatch->{'mmatch_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Made: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_made" value="$Launchh::mmatch->{'mmatch_made'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Notified: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_notified" value="$Launchh::mmatch->{'mmatch_notified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Contacted: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_contacted" value="$Launchh::mmatch->{'mmatch_contacted'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Expires: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_expires" value="$Launchh::mmatch->{'mmatch_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_type" value="$Launchh::mmatch->{'mmatch_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_status" value="$Launchh::mmatch->{'mmatch_status'}">
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
        <FORM ACTION="$Launchh::MMATCH_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::MMATCHS_CGI">
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

if($order_by eq "mmatch_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

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
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Account id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_account_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_account_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Account id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_score" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_score&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Score</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_note" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_note&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Note</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_made" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_made&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Made</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_notified" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_notified&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Notified</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_contacted" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_contacted&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Contacted</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_expires" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_expires&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Expires</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_type" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_type&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Type</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "mmatch_status" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MMATCHS_CGI?stage=2&order_by=mmatch_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Status</A></B>
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

&Launchh::select_mmatchs($where);
while(&Launchh::next_mmatch())
{
   &Launchh::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchh::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<A HREF="$Launchh::MMATCH_CGI?stage=1&mode=edit&mmatch_id=$Launchh::mmatch->{'mmatch_id'}&order_by=mmatch_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchh::HSTR">Edit ($Launchh::mmatch->{'mmatch_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'account_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_account_id'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_score'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_note'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_made'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_notified'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_contacted'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_expires'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_type'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::mmatch->{'mmatch_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
  	<A HREF="$Launchh::MMATCH_CGI?stage=2&mode=delete&mmatch_id=$Launchh::mmatch->{'mmatch_id'}&$Launchh::HSTR">Delete (
	$Launchh::mmatch->{'mmatch_id'}
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
        <FORM ACTION="$Launchh::MMATCH_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchh::MMATCHS_CGI">
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

my $total = &Launchh::count_table('mmatch',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchh::MMATCHS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchh::MMATCHS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchh::MMATCHS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchh::mmatch->{'mmatch_id'})
{
   $WHERE .= "AND mmatch_id = $Launchh::mmatch->{'mmatch_id'} ";
}  
if($Launchh::mmatch->{'account_id'})
{
   $WHERE .= "AND account_id = $Launchh::mmatch->{'account_id'} ";
}  
if($Launchh::mmatch->{'mmatch_account_id'})
{
   $WHERE .= "AND mmatch_account_id = $Launchh::mmatch->{'mmatch_account_id'} ";
}  
if($Launchh::mmatch->{'mmatch_score'})
{
   $WHERE .= "AND mmatch_score = $Launchh::mmatch->{'mmatch_score'} ";
}  
if($Launchh::mmatch->{'mmatch_note'})
{
	$Launchh::mmatch->{'mmatch_note'} .= "%";
        $Launchh::mmatch->{'mmatch_note'} = $Launchh::dbh->quote($Launchh::mmatch->{'mmatch_note'});
   $WHERE .= "AND mmatch_note LIKE $Launchh::mmatch->{'mmatch_note'} ";
}  
if($Launchh::mmatch->{'mmatch_made'})
{
   $WHERE .= "AND mmatch_made = $Launchh::mmatch->{'mmatch_made'} ";
}  
if($Launchh::mmatch->{'mmatch_notified'})
{
   $WHERE .= "AND mmatch_notified = $Launchh::mmatch->{'mmatch_notified'} ";
}  
if($Launchh::mmatch->{'mmatch_contacted'})
{
   $WHERE .= "AND mmatch_contacted = $Launchh::mmatch->{'mmatch_contacted'} ";
}  
if($Launchh::mmatch->{'mmatch_expires'})
{
   $WHERE .= "AND mmatch_expires = $Launchh::mmatch->{'mmatch_expires'} ";
}  
if($Launchh::mmatch->{'mmatch_type'})
{
   $WHERE .= "AND mmatch_type = $Launchh::mmatch->{'mmatch_type'} ";
}  
if($Launchh::mmatch->{'mmatch_status'})
{
   $WHERE .= "AND mmatch_status = $Launchh::mmatch->{'mmatch_status'} ";
}  


return $WHERE;
}
