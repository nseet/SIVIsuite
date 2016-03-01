#!/usr/bin/perl

use dream;
use headers;
use strict;

my $site_alias = shift || 'mydomain';
my $server_alias = shift || '127.0.0.1';
my $mask = shift;  #ie mp3% - anything beginning with mp3

my $dbname = "MY_DB_DATABASE";
my $MYSQLSHOW = "mysqlshow -uMY_DB_USERNAME -pMY_DB_PASSWORD -h$server_alias $dbname";
my $DEBUG = 10;

if(!$site_alias)
{
print STDERR "Syntax: cgigen.pl <sitealias> [tabl]\n";
exit;
}

if($site_alias =~ /^(.*?):(.*?)$/s)
{
$site_alias = $1;
$server_alias = $2;
}

my $dbh = Connect("$dbname:$server_alias");

my $site_id = 1;
my $site_name = 'www.mydomain.com';
my $site_hfile = '';
my $site_cgi = '';
my $site_next = '';
my $site_definition = ''; 
my $site_help = '';

my $u_site_alias = "\u$site_alias";
my $site_url = "https://$site_name";

   my @tables = `$MYSQLSHOW $mask`;
   print STDERR "$MYSQLSHOW $mask\n" if($DEBUG);

my $auto_select;
my $auto_insert;
my $auto_input;
my $auto_confirm;
my $auto_verify;
my $auto_detail;
my $auto_list_head;
my $auto_list_body;
my $auto_where;
my @auto_vars;
my @key;
my $table; 
my $utable; 
my $this_cgi;

   for(my $i = 4; $i < scalar(@tables) - 1; $i++)
   {
   $tables[$i] =~ s/^.*?(\w+)\W.*?$/$1/gis;
   chomp($tables[$i]);
   print STDERR "Table: $tables[$i]\n" if($DEBUG);
   next if(!$tables[$i] || $tables[$i] =~ /^\s*$/ );

	$auto_select = "";
	$auto_insert = "";
	$auto_input = "";
	$auto_confirm = "";
	$auto_verify = ""; 
	@auto_vars = ();
	$auto_detail = "";
	$auto_list_head = "";
	$auto_list_body = "";
	$auto_where = "";
	$key[0] = "";
	$key[1] = "";
	$table = $tables[$i];
	$utable = $table;
	$utable =~ tr/[a-z]/[A-Z]/;
	$this_cgi = "$u_site_alias::$utable"."_CGI";
   
   make_auto($i);

my $SKEL_FILE = `cat cgigen.skel`;
$SKEL_FILE =~ s/\$site_id/$site_id/gs;
$SKEL_FILE =~ s/\$site_name/$site_name/gs;
$SKEL_FILE =~ s/\$site_alias/$site_alias/gs;
$SKEL_FILE =~ s/\$u_site_alias/$u_site_alias/gs;
$SKEL_FILE =~ s/\$site_hfile/$site_hfile/gs;
$SKEL_FILE =~ s/\$site_cgi/$site_cgi/gs;
$SKEL_FILE =~ s/\$site_url/$site_url/gs;
$SKEL_FILE =~ s/\$site_next/$site_next/gs;
$SKEL_FILE =~ s/\$site_definition/$site_definition/gs;
$SKEL_FILE =~ s/\$site_help/$site_help/gs;
$SKEL_FILE =~ s/\$server_alias/$server_alias/gs;
$SKEL_FILE =~ s/\$this_cgi/$this_cgi/gs;
$SKEL_FILE =~ s/\$table/$table/gs;
$SKEL_FILE =~ s/\$utable/$utable/gs;

   $SKEL_FILE =~ s/#auto_detail/$auto_detail/s;
   $SKEL_FILE =~ s/#auto_select/$auto_select/s;
   $SKEL_FILE =~ s/#auto_insert/$auto_insert/s;
   $SKEL_FILE =~ s/#auto_input/$auto_input/s;
   $SKEL_FILE =~ s/#auto_confirm/$auto_confirm/s;
   $SKEL_FILE =~ s/#auto_verify/$auto_verify/s;

   open(OUTFILE,">$table.cgi");
   print OUTFILE $SKEL_FILE;
   close(OUTFILE);

   system("chmod a+x $table.cgi");

my $SKEL_FILE2 = `cat cgigen.skel2`;
$SKEL_FILE2 =~ s/\$site_id/$site_id/gs;
$SKEL_FILE2 =~ s/\$site_name/$site_name/gs;
$SKEL_FILE2 =~ s/\$site_alias/$site_alias/gs;
$SKEL_FILE2 =~ s/\$u_site_alias/$u_site_alias/gs;
$SKEL_FILE2 =~ s/\$site_hfile/$site_hfile/gs;
$SKEL_FILE2 =~ s/\$site_cgi/$site_cgi/gs;
$SKEL_FILE2 =~ s/\$site_url/$site_url/gs;
$SKEL_FILE2 =~ s/\$site_next/$site_next/gs;
$SKEL_FILE2 =~ s/\$site_definition/$site_definition/gs;
$SKEL_FILE2 =~ s/\$site_help/$site_help/gs;
$SKEL_FILE2 =~ s/\$server_alias/$server_alias/gs;
$SKEL_FILE2 =~ s/\$this_cgi/$this_cgi/gs;
$SKEL_FILE2 =~ s/\$table/$table/gs;
$SKEL_FILE2 =~ s/\$utable/$utable/gs;

   $SKEL_FILE2 =~ s/#auto_detail/$auto_detail/s;
   $SKEL_FILE2 =~ s/#auto_list_head/$auto_list_head/s;
   $SKEL_FILE2 =~ s/#auto_list_body/$auto_list_body/s;
   $SKEL_FILE2 =~ s/#auto_input/$auto_input/s;
   $SKEL_FILE2 =~ s/#auto_where/$auto_where/s;

   open(OUTFILE,">$table"."s.cgi");
   print OUTFILE $SKEL_FILE2;
   close(OUTFILE);

   system("chmod a+x $table"."s.cgi");
   }

Disconnect($dbh);
exit;

sub make_auto
{
   my $i = shift;

   my @schema = `$MYSQLSHOW $tables[$i] %`;

	for(my $j = 4; $j < scalar(@schema) - 1; $j++)
   	{
   		my $row = $schema[$j];
		print STDERR "Schema: $row\n" if($DEBUG);

   		my @row = split(/\|/,$row);  #0=NULL 1=Field 2=Type 3=Null 4=Key 5=Default 6=Extra 
   		for (my $k = 0; $k < scalar(@row); $k++)
   		{
			print STDERR "$k: $row[$k]\n" if($DEBUG);
			$row[$k] =~ s/^\s*(.*?)\s*$/$1/gs;
   			$auto_vars[$j][$k] = $row[$k];
			if($k == 1)
			{
   			$auto_vars[$j][0] = "$table" . "->{'$row[$k]'}";	
			}
   		}
   	}

   	for(my $j = 4; $j < scalar(@auto_vars); $j++)
   	{
	if($auto_vars[$j][5] =~ /pri/is) 
		{ 
		$key[0] = $auto_vars[$j][0]; 
		$key[1] = $auto_vars[$j][1]; 
		}
   	}
        print STDERR "Key: $key[0],$key[1]\n" if($DEBUG);
   
	gen_select();
	print STDERR "Auto_select: $auto_select\n" if($DEBUG);

	gen_insert();
	print STDERR "Auto_insert: $auto_insert\n" if($DEBUG);

	gen_input();
	print STDERR "Auto_input: $auto_input\n" if ($DEBUG);

	gen_confirm();
	print STDERR "Auto_confirm: $auto_confirm\n" if ($DEBUG);

	gen_verify();
	print STDERR "Auto_verify: $auto_verify\n" if ($DEBUG);

	gen_detail();
	print STDERR "Auto_detail: $auto_detail\n" if ($DEBUG);
	
	gen_list_head();
	print STDERR "Auto_list_head: $auto_list_head\n" if ($DEBUG);
	
	gen_list_body();
	print STDERR "Auto_list_body: $auto_list_body\n" if ($DEBUG);

	gen_where();
	print STDERR "Auto_where: $auto_where\n" if ($DEBUG);
		
}


my $auto_subs;
my $auto_globals;

sub gen_select
{
	$auto_select .= "\n&$u_site_alias" . "::read_$table();\n";
	$auto_select .= "&$u_site_alias" . "::select_$table(\$$u_site_alias\:\:$key[0]) if(\$$u_site_alias\:\:$key[0]);\n";
	$auto_select .= "&$u_site_alias" . "::read_$table() if(\$stage>=2 && \$mode eq \"edit\");\n";

return;
}

sub gen_insert
{
	$auto_insert .= "\tif(\$mode eq \"delete\")\n";
        $auto_insert .= "\t{\n";
        $auto_insert .= "\t   &$u_site_alias"."::delete_$table(\$$u_site_alias"."::$key[0]);\n";
        $auto_insert .= "\t}\n";
        $auto_insert .= "\telse\n";
        $auto_insert .= "\t{\n";
	$auto_insert .= "\t   ";
	$auto_insert .= "if( !\$$u_site_alias"."::$key[0])\n";
        $auto_insert .= "\t   {\n";
        $auto_insert .= "\t\t&$u_site_alias"."::insert_$table();\n";
        $auto_insert .= "\t   }\n";
        $auto_insert .= "\t   else\n";
        $auto_insert .= "\t   {\n";
        $auto_insert .= "\t\t&$u_site_alias"."::update_$table();\n";
        $auto_insert .= "\t   }\n";
        $auto_insert .= "\t}\n\n";

return;
}

sub gen_input
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   if($auto_vars[$j][2] =~ m/text/is)
   {
   $auto_input .= << "EOM";
		<TR><TD><FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
		\u$col_name: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="$auto_vars[$j][1]" ROWS="10" COLS="50">\$$u_site_alias\:\:$auto_vars[$j][0]</TEXTAREA>
		</FONT></TD></TR>
EOM
   }
   else
   {
   $auto_input .= << "EOM";
		<TR><TD><FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
		\u$col_name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="$auto_vars[$j][1]" value="\$$u_site_alias\:\:$auto_vars[$j][0]">
		</FONT></TD></TR>
EOM
   }

}

return;
}  #end gen_input

sub gen_confirm
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   $auto_confirm .= << "EOM";
		<TR><TD><FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
		\u$col_name: &nbsp; <B>\$$u_site_alias\:\:$auto_vars[$j][0]</B>
		<INPUT TYPE="hidden" NAME="$auto_vars[$j][1]" value="\$$u_site_alias\:\:$auto_vars[$j][0]">
		</FONT></TD></TR>
EOM
}
    
return;
}  #end gen_confirm


sub gen_verify
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   my $int = "|| (\$$u_site_alias\:\:$auto_vars[$j][0] =~ /\\D/is)" if($auto_vars[$j][2] =~ /int/is);
$auto_verify .= << "EOM";
#		if(\$$u_site_alias\:\:$auto_vars[$j][0] eq "" $int)
#		{
#		\$$u_site_alias\:\:ERROR .= "Please enter a valid \u$col_name<BR>";
#		return 0;
#		}
EOM
}

} #end gen_verify

sub gen_detail
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   $auto_detail .= << "EOM";
		<TR><TD><FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
                 \u$col_name: &nbsp; <B>\$$u_site_alias\:\:$auto_vars[$j][0]</B>
                </FONT></TD></TR>
EOM
}
    
return;
}  #end gen_detail


sub gen_list_head
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   my $ptable = $utable . "S_CGI";

   $auto_list_head .= << "EOM2";
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
EOM

if(\$order_by eq "$auto_vars[$j][1]" && \$order_dir eq "ASC")
{
   \$lorder_dir = "DESC";
}   
else
{
   \$lorder_dir = "ASC";
}

\$str .= << "EOM";
        <B><A HREF="\$$u_site_alias\:\:$ptable?stage=2&order_by=$auto_vars[$j][1]&order_dir=\$lorder_dir&limit=\$limit&offset=\$offset&\$$u_site_alias\:\:HSTR&WHERE=\$WHERE_ESC">\u$col_name</A></B>
        </FONT>
        </TD>

EOM2
}

   $auto_list_head .= << "EOM2";
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">	
        <B>Delete</B>
        </FONT>
        </TD>
EOM2

return;
}  #end gen_list_head


sub gen_list_body
{

 my $ptable = $utable . "_CGI";

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $key_ao;
   my $key_ac;

   if($auto_vars[$j][1] eq $key[1])
   {
   $key_ao = "<A HREF=\"\$$u_site_alias\:\:$ptable?stage=1&mode=edit&$key[1]=\$$u_site_alias\:\:$key[0]&order_by=$auto_vars[$j][1]&order_dir=\$order_dir&limit=\$limit&offset=\$offset&\$$u_site_alias\:\:HSTR\">Edit (";

   $key_ac = ")</A>";
   }

   $auto_list_body .= << "EOM";
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
	$key_ao\$$u_site_alias\:\:$auto_vars[$j][0]$key_ac
        </FONT>
        </TD>
EOM
}

   $auto_list_body .= << "EOM";
        <TD VALIGN="TOP" ALIGN="CENTER">
        <FONT FACE="\$$u_site_alias\:\:FONT" SIZE="\$$u_site_alias\:\:SIZE">
  	<A HREF=\"\$$u_site_alias\:\:$ptable?stage=2&mode=delete&$key[1]=\$$u_site_alias\:\:$key[0]&\$$u_site_alias\:\:HSTR\">Delete (
	\$$u_site_alias\:\:$key[0]
	)</A>
        </FONT>
        </TD>
EOM

return;
}  #end gen_list_body


sub gen_where
{

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $col_name = $auto_vars[$j][1];
      $col_name =~ s/$table//gis;
      $col_name =~ s/_/ /gis;
      $col_name =~ s/^\s*(.*?)$/$1/is;

   $auto_where .= << "EOM";
if(\$$u_site_alias\:\:$auto_vars[$j][0])
{
EOM

   my $operator = "=";
   if($auto_vars[$j][2] =~ /char/is || $auto_vars[$j][2] =~ /text/is)
   {
   $auto_where .= << "EOM";
	\$$u_site_alias\:\:$auto_vars[$j][0] .= "%";
        \$$u_site_alias\:\:$auto_vars[$j][0] = \$$u_site_alias\:\:dbh->quote(\$$u_site_alias\:\:$auto_vars[$j][0]);
EOM
   $operator = "LIKE";
   }

   $auto_where .= << "EOM";
   \$WHERE .= "AND $auto_vars[$j][1] $operator \$$u_site_alias\:\:$auto_vars[$j][0] ";
}  
EOM
}
    
return;
}  #end gen_where

