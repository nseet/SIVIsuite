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

&Launchh::read_param();
#&Launchh::select_param($Launchh::param_id) if($Launchh::param_id);

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
        Search \uparam:
        </FONT>
        </TD>
   </TR>
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
        <FORM ACTION="$Launchh::PARAMS_CGI" METHOD="POST">
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
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="param_id" value="$Launchh::param->{'param_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="param_name" value="$Launchh::param->{'param_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Value: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="param_value" ROWS="10" COLS="50">$Launchh::param->{'param_value'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="param_desc" value="$Launchh::param->{'param_desc'}">
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
        <FORM ACTION="$Launchh::PARAM_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
        <TD>
        <FORM ACTION="$Launchh::PARAMS_CGI">
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

if($order_by eq "param_id" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::PARAMS_CGI?stage=2&order_by=param_id&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Id</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "param_name" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::PARAMS_CGI?stage=2&order_by=param_name&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Name</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "param_value" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::PARAMS_CGI?stage=2&order_by=param_value&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Value</A></B>
        </FONT>
        </TD>

        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
EOM

if($order_by eq "param_desc" && $order_dir eq "ASC")
{
   $lorder_dir = "DESC";
}   
else
{
   $lorder_dir = "ASC";
}

$str .= << "EOM";
        <B><A HREF="$Launchh::PARAMS_CGI?stage=2&order_by=param_desc&order_dir=$lorder_dir&limit=$limit&offset=$offset&$Launchh::HSTR&WHERE=$WHERE_ESC">Desc</A></B>
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

&Launchh::select_params($where);
while(&Launchh::next_param())
{
   &Launchh::toggle_color();

   $str .= << "EOM";
   <TR BGCOLOR="$Launchh::COLOR">
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<A HREF="$Launchh::PARAM_CGI?stage=1&mode=edit&param_id=$Launchh::param->{'param_id'}&order_by=param_id&order_dir=$order_dir&limit=$limit&offset=$offset&$Launchh::HSTR">Edit ($Launchh::param->{'param_id'})</A>
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::param->{'param_name'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::param->{'param_value'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	$Launchh::param->{'param_desc'}
        </FONT>
        </TD>
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
  	<A HREF="$Launchh::PARAM_CGI?stage=2&mode=delete&param_id=$Launchh::param->{'param_id'}&$Launchh::HSTR">Delete (
	$Launchh::param->{'param_id'}
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
        <FORM ACTION="$Launchh::PARAM_CGI">
        $Launchh::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">  
        <INPUT TYPE="hidden" NAME="mode" VALUE="edit">  
        <INPUT TYPE="submit" NAME="Done" VALUE="Add New">
        </FORM>
        </TD>
	<TD>
        <FORM ACTION="$Launchh::PARAMS_CGI">
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

my $total = &Launchh::count_table('param',$WHERE);
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

   $str .= "[ <A HREF=\"$Launchh::PARAMS_CGI?stage=2&limit=$limit&offset=$previous_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Previous Page</A> ]";
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
   $str .= " <A HREF=\"$Launchh::PARAMS_CGI?stage=2&limit=$limit&offset=$page_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">$ob$page$cb</A> |";
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

   $str .= "[ <A HREF=\"$Launchh::PARAMS_CGI?stage=2&limit=$limit&offset=$next_offset&order_by=$order_by&order_dir=$order_dir&$Launchh::HSTR&WHERE=$WHERE_ESC\">Next Page</A> ]";
}

return $str;
}

sub get_where
{
my $WHERE = "WHERE 1=1 ";

if($Launchh::param->{'param_id'})
{
   $WHERE .= "AND param_id = $Launchh::param->{'param_id'} ";
}  
if($Launchh::param->{'param_name'})
{
	$Launchh::param->{'param_name'} .= "%";
        $Launchh::param->{'param_name'} = $Launchh::dbh->quote($Launchh::param->{'param_name'});
   $WHERE .= "AND param_name LIKE $Launchh::param->{'param_name'} ";
}  
if($Launchh::param->{'param_value'})
{
	$Launchh::param->{'param_value'} .= "%";
        $Launchh::param->{'param_value'} = $Launchh::dbh->quote($Launchh::param->{'param_value'});
   $WHERE .= "AND param_value LIKE $Launchh::param->{'param_value'} ";
}  
if($Launchh::param->{'param_desc'})
{
	$Launchh::param->{'param_desc'} .= "%";
        $Launchh::param->{'param_desc'} = $Launchh::dbh->quote($Launchh::param->{'param_desc'});
   $WHERE .= "AND param_desc LIKE $Launchh::param->{'param_desc'} ";
}  


return $WHERE;
}
