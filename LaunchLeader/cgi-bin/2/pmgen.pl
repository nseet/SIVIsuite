#!/usr/bin/perl

use lib '../cgi-bin';
use dream;
use headers;
use strict;

my $site_alias = shift || 'mydomain';
my $server_alias = shift || '127.0.0.1';
my $mask = shift;  

my $dbname = "MY_DB_DATABASE";
my $site_name = 'mydomain.com';
my $site_hfile = 'empty.html';
my $site_cgi = '';
my $site_next = '';
my $site_definition = '';
my $site_help = '';

my $u_site_alias = "\u$site_alias";
my $site_url = "https://$site_name";

my $SKEL_FILE = `cat pmgen.skel`;
my $MYSQLSHOW = "mysqlshow -uMY_DB_USERNAME -pMY_DB_PASSWORD -h$server_alias";
my $DEBUG = 0;

if(!$site_alias)
{
print STDERR "Syntax: pmgen.pl <sitealias> [table]\n";
exit;
}

if($site_alias =~ /^(.*?):(.*?)$/s)
{
$site_alias = $1;
$server_alias = $2;
}

my $dbh = Connect("$dbname:$server_alias");
if(!-e "../cgi-bin/Custom.pm")
{
   open(FILE,">Custom.pm");
   print FILE "1;\n";
   close FILE;
}

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

my $auto_globals;
my $auto_subs;
my $auto_pms;
my @auto_vars;
my $auto_cgi_globals;
my $auto_cgi_paths;
my @key;
my $table;

make_auto();

$SKEL_FILE =~ s/#auto_pms/$auto_pms/s;
$SKEL_FILE =~ s/#auto_globals/$auto_globals/s;
$SKEL_FILE =~ s/#auto_subs/$auto_subs/s;
$SKEL_FILE =~ s/#auto_cgi_paths/$auto_cgi_paths/s;
$SKEL_FILE =~ s/#auto_cgi_globals/$auto_cgi_globals/s;

open(OUTFILE,">$u_site_alias.pm");
print OUTFILE $SKEL_FILE;
close(OUTFILE);

Disconnect($dbh);
exit;

sub make_auto
{
   my @tables = `$MYSQLSHOW $dbname $mask`;
   print STDERR "$MYSQLSHOW $dbname $mask\n" if($DEBUG);

   for(my $i = 4; $i < scalar(@tables) - 1; $i++)
   {
   $tables[$i] =~ s/\W//gis;
   next if($tables[$i] =~ /wp_/s);
   print STDERR "Table: $tables[$i]\n" if($DEBUG);
   
   @auto_vars = ();
   $table = $tables[$i]; 
   $key[0] = "";   
   $key[1] = "";   

   my $utable = $table;
   $utable =~ tr/[a-z]/[A-Z]/;
   $auto_pms .= "use \u$table\;\n";
   $auto_cgi_globals .= "\$$utable"."_CGI \$$utable"."S_CGI ";
   $auto_cgi_paths .= "    \$$utable"."_CGI = \"\$CGI_URL/$table.cgi\"\;\n";
   $auto_cgi_paths .= "    \$$utable" . "S_CGI = \"\$CGI_URL/$table" . "s.cgi\"\;\n";

   my @schema = `$MYSQLSHOW $dbname $tables[$i] %`;
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
   			$auto_vars[$j][0] = "$table"."->{'$row[$k]'}";				
			}
   			$auto_vars[$j][$k] = $row[$k];	
   		}
   	}
   
	gen_globals();
	print STDERR "Auto_globals: $auto_globals\n" if($DEBUG);

	gen_subs($tables[$i]);
	open(FILE,">\u$table.pm");
        print FILE $auto_subs;
        print FILE "1;\n";
        close(FILE);	

        print STDERR "Key: $key[0], $key[1]\n" if($DEBUG);
	print STDERR "Auto_subs: $auto_subs\n" if ($DEBUG);
        $auto_subs = "";
   }

   return;		
}


sub gen_globals
{
	$auto_globals .= "\$$table \$$table" . "_sth ";
   	for(my $j = 4; $j < scalar(@auto_vars); $j++)
   	{
	   if($auto_vars[$j][4] =~ /pri/is) 
		{ 
		$key[0] = $auto_vars[$j][0]; 
		$key[1] = $auto_vars[$j][1]; 
		}
   	}
	if(!$key[1] && $auto_vars[4][1])
	{
	   $key[0] = $auto_vars[4][0];
	   $key[1] = $auto_vars[4][1];
	}

return;
}

sub gen_subs
{
	gen_read();
	gen_selects();
	gen_next();
	gen_select();
	gen_insert();
	gen_update();
	gen_delete();

return;
}


sub gen_read
{

$auto_subs .= << "EOM";
sub read_$table
{

EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
   my $clean_open;
   my $clean_close;
   
   if($auto_vars[$j][2] =~ /int/is)
   	{
   	$clean_open = "clean('int', "; 
   	$clean_close = ")";
   	}
   	
   $auto_subs .= "   \$$auto_vars[$j][0] = $clean_open\$_query->param('$auto_vars[$j][1]')$clean_close;\n"
}
    
$auto_subs .= << "EOM";

   return;
}

EOM

return;
}  #end gen_read

sub gen_selects
{
my $table_plural = "$table" . "s";

$auto_subs .= << "EOM";
sub select_$table_plural
{
   my \$where = shift;

   my \$statement = "SELECT
EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
$auto_subs .= "$table.$auto_vars[$j][1],";
}
chop $auto_subs;

my $table_sth = $table."_sth";
$auto_subs .= << "EOM";
         
	FROM $table
         \$where";

   \$$table_sth = Execute(\$statement,\$dbh);

   print STDERR \$statement if(\$DEBUG);
   return;
}

EOM

return;
}  #end gen_selects


sub gen_next
{
my $table_sth = $table."_sth";
$auto_subs .= << "EOM";
sub next_$table
{
   \$$table = HFetch(\$$table_sth);

   return \$$key[0] ne "";
}

EOM

return;
} #end gen_next


sub gen_select
{

$auto_subs .= << "EOM";
sub select_$table
{
   my \$id = shift;

   my \$statement = "SELECT 
EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
$auto_subs .= "$auto_vars[$j][1],";
}
chop $auto_subs;

$auto_subs .= << "EOM";
                 
		FROM $table
                 WHERE $key[1] = \$id";
   my \$sth = Execute(\$statement,\$dbh);

   \$$table = HFetchone(\$sth);

   return \$$key[0] ne "";
}

EOM

return;
} #end gen_select

sub gen_insert
{

$auto_subs .= << "EOM";
sub insert_$table
{
EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
if($auto_vars[$j][2] =~ /char/is || $auto_vars[$j][2] =~ /text/is)
   { 
	$auto_subs .= "   \$$auto_vars[$j][0] = \$dbh->quote(\$$auto_vars[$j][0]);\n" 
   }
}

$auto_subs .= << "EOM";

   my \$statement = "INSERT INTO $table ( 
EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
$auto_subs .= "$auto_vars[$j][1],";
}
chop $auto_subs;

$auto_subs .= "\n\t)\n\tVALUES (\n";
                  
for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
my $entry = "\$$auto_vars[$j][0],";
if($auto_vars[$j][2] eq "datetime")
{ $entry = "NOW(),"; }
#if($auto_vars[$j][2] =~ /char/is || $auto_vars[$j][2] =~ /text/is)
#   { $entry = "'\$$auto_vars[$j][0]'," }
$auto_subs .= $entry;
}
chop $auto_subs;

$auto_subs .= << "EOM";

	)";
   Execute(\$statement,\$dbh);

   \$statement = "SELECT max($key[1]) FROM $table";
   my \$new_id = Fetchone(Execute(\$statement,\$dbh));
   return \$new_id;
}

EOM

return;
} #end insert_person

sub gen_update
{

$auto_subs .= << "EOM";
sub update_$table
{
    my \$setstr = shift;
    my \$statement;

EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
if($auto_vars[$j][2] =~ /char/is || $auto_vars[$j][2] =~ /text/is)
   { $auto_subs .= "   \$$auto_vars[$j][0] = \$dbh->quote(\$$auto_vars[$j][0]);\n" }
}

$auto_subs .= << "EOM";

    if(\$setstr)
      {  \$statement = "UPDATE $table SET \$setstr WHERE $key[1] = \$$key[0]";  }
    else
      {
        \$statement = "UPDATE $table SET
EOM

for(my $j = 4; $j < scalar(@auto_vars); $j++)
{
my $entry = "\$$auto_vars[$j][0],";
if($auto_vars[$j][2] eq "datetime")
{ $entry = "NOW(),"; }
   	
   $auto_subs .= "\t\t$auto_vars[$j][1] = $entry\n"
}
chop($auto_subs);
chop($auto_subs);

$auto_subs .= << "EOM";
               
		WHERE $key[1] = \$$key[0]";
      }

    Execute(\$statement,\$dbh);
    print STDERR "\$statement" if(\$DEBUG);

    return;
}

EOM

return;
} #end gen_update

sub gen_delete
{

$auto_subs .= << "EOM";
sub delete_$table
{
my \$id = shift;

my \$statement = "DELETE FROM $table
                 WHERE $key[1] = \$id";

Execute(\$statement,\$dbh);

return;
}

EOM

return;
} #end gen_delete


sub gen_verify
{

$auto_subs .= << "EOM";
sub verify_$table
{
EOM

$auto_subs .= << "EOM";
return;
}
EOM
return;
} #end gen_verify
