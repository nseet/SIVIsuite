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

&Launchh::read_milestone();
#&Launchh::select_milestone($Launchh::milestone_id) if($Launchh::milestone_id);

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
        Search \umilestone:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
        <FORM ACTION="$Launchh::MILESTONES_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="milestone_id" value="$Launchh::milestone->{'milestone_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="milestone_name" value="$Launchh::milestone->{'milestone_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="milestone_desc" ROWS="10" COLS="50">$Launchh::milestone->{'milestone_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="milestone_note" ROWS="10" COLS="50">$Launchh::milestone->{'milestone_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="milestone_status" value="$Launchh::milestone->{'milestone_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="milestone_type" value="$Launchh::milestone->{'milestone_type'}">
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
        <FORM ACTION="$Launchh::MILESTONE_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::MILESTONES_CGI">
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

if($order_by eq "milestone_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "milestone_name" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_name&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Name</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "milestone_desc" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_desc&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Desc</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "milestone_note" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_note&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Note</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "milestone_status" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_status&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Status</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "milestone_type" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::MILESTONES_CGI?stage=2&order_by=milestone_type&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Type</A></B>
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

&Launchh::select_milestones($where);
while(&Launchh::next_milestone())
{
   &Launchh::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchh::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<A HREF="$Launchh::MILESTONE_CGI?stage=1&mode=edit&milestone_id=$Launchh::milestone->{'milestone_id'}&order_by=milestone_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchh::HSTR">Edit ($Launchh::milestone->{'milestone_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::milestone->{'milestone_name'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::milestone->{'milestone_desc'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::milestone->{'milestone_note'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::milestone->{'milestone_status'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::milestone->{'milestone_type'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
  	<A HREF="$Launchh::MILESTONE_CGI?stage=2&mode=delete&milestone_id=$Launchh::milestone->{'milestone_id'}&$Launchh::HSTR">Delete (
	$Launchh::milestone->{'milestone_id'}
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
        <FORM ACTION="$Launchh::MILESTONE_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchh::MILESTONES_CGI">
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

my $total = &Launchh::count_table('milestone',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchh::MILESTONES_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchh::MILESTONES_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchh::MILESTONES_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchh::milestone->{'milestone_id'})
{
   $WHERE .= "AND milestone_id = $Launchh::milestone->{'milestone_id'} ";
}  
if($Launchh::milestone->{'milestone_name'})
{
	$Launchh::milestone->{'milestone_name'} .= "%";
        $Launchh::milestone->{'milestone_name'} = $Launchh::dbh->quote($Launchh::milestone->{'milestone_name'});
   $WHERE .= "AND milestone_name LIKE $Launchh::milestone->{'milestone_name'} ";
}  
if($Launchh::milestone->{'milestone_desc'})
{
	$Launchh::milestone->{'milestone_desc'} .= "%";
        $Launchh::milestone->{'milestone_desc'} = $Launchh::dbh->quote($Launchh::milestone->{'milestone_desc'});
   $WHERE .= "AND milestone_desc LIKE $Launchh::milestone->{'milestone_desc'} ";
}  
if($Launchh::milestone->{'milestone_note'})
{
	$Launchh::milestone->{'milestone_note'} .= "%";
        $Launchh::milestone->{'milestone_note'} = $Launchh::dbh->quote($Launchh::milestone->{'milestone_note'});
   $WHERE .= "AND milestone_note LIKE $Launchh::milestone->{'milestone_note'} ";
}  
if($Launchh::milestone->{'milestone_status'})
{
   $WHERE .= "AND milestone_status = $Launchh::milestone->{'milestone_status'} ";
}  
if($Launchh::milestone->{'milestone_type'})
{
   $WHERE .= "AND milestone_type = $Launchh::milestone->{'milestone_type'} ";
}  


return $WHERE;
}
