#!/usr/bin/perl

package headers;
use strict;
use lib '/home/packages';
use dream;
use LWP::Simple;

BEGIN {
    require Exporter;
    use vars qw (@ISA @EXPORT
		$conf_id $conf_name $site_id $hfile $table_width $color_light $color_dark $font $size $welcome_text $logo $background $htext $ftext 
		);

    @ISA= qw(Exporter);
    @EXPORT= qw( html_header html_footer html_spell make_header make_footer lookup_conf
		$hfile $table_width $color_light $color_dark $font $size
		);
}

my $BAR_FILE = "/home/staff/public_html/bar/bar.cgi";
my $BAR2_FILE = "/home/staff/public_html/bar2/index.html";
my $ADROTATE_CGI = "/home/staff/public_html/adrotate/ad.cgi";

sub html_header
{
   my $filename = shift || return "";
   my $HSTR = shift;  #login code
   my $html;

   if($filename =~ /http:\/\//is)
   {
   $html = get $filename;
   }
   else
   {
   $html = `cat $filename`;
   }

   $html =~ s/<!--xxxMAINxxx-->.*//is;

   my $thtml = $html;  #yes, necessary
   while($thtml =~ s/(<!--#include virtual="(.*?)"\s*-->)//s && (-e $2))
   {
	my $include = `cat $2`;
	$html =~ s/$1/$include/is;
   }

   if($HSTR)
   {
	$html =~ s/HSTR/$HSTR/gs;
   }

   $html =~ s|("\.\./)(\.\./)*|"/|gis;
   $html =~ s|"\./|"/|gis;
   $html =~ s|Content-type: text/html||gis;

   my $server_name = `hostname`;
   chomp($server_name);
   $html .= "<!--$server_name-->";

   return $html;
}

sub html_footer
{
   my $filename = shift || return "";
   my $HSTR = shift;
   my $html;

   if($filename =~ /http:\/\//is)
   {
   $html = get $filename;
   }
   else
   {
   $html = `cat $filename`;
   }

   $html =~ s/.*<!--xxxMAINxxx-->//is;

   my $thtml = $html;
   while($thtml =~ s/(<!--#include virtual="(.*?)"\s*-->)//s)
   {
	my $include = `cat $2`;
	$html =~ s/$1/$include/is;
   }


   if($HSTR)
   {
        $html =~ s/HSTR/$HSTR/gs;
   }

   $html =~ s|("\.\./)(\.\./)*|"/|gis;
   $html =~ s|"\./|"/|gis;
   $html =~ s|Content-type: text/html||gis;

   return $html;
}

sub html_spell
{
my $fieldname = shift;
my $formname = shift;
my $index = shift || "";

my $html = << "EOM";

<SCRIPT LANGUAGE="Javascript">
<!--
spell_url = "/spell/spell.cgi";
function Spell$index(fieldname,formname) {
     kiosk = window.open(spell_url + "?fieldname="+fieldname+"&formname="+formname, "speller", 'resizable=yes,scrollbars=yes,status=0,width=600,height=300');

     return true;
}
//-->
</SCRIPT>

<INPUT TYPE="BUTTON" VALUE="Spell Check" ONCLICK="Spell$index('$fieldname','$formname')">

EOM

return $html;
}

sub select_conf
{
   my $where = shift;

   my $dbh = Connect("dream:db");
   my $statement = "SELECT
conf_id, conf_name,site_id,hfile,table_width,color_light,color_dark,font,size,welcome_text,logo,background,htext,ftext         
	FROM conf
         $where";

   my $sth = Execute($statement,$dbh);

   ( 
$conf_id,$conf_name,$site_id,$hfile,$table_width,$color_light,$color_dark,$font,$size,$welcome_text,$logo,$background,$htext,$ftext
   ) = Fetchone($sth);

   Disconnect($dbh);
   return $conf_id ne "";
}

sub lookup_conf
{
return;
   my $conf_name = shift || return;

   select_conf("WHERE conf_name = '$conf_name'");

   $table_width = "75%" if(!$table_width);
   $color_light = "#EEEEEE" if(!$color_light);
   $color_dark = "#CCCCCC" if(!$color_dark);
   $font = "Arial" if(!$font);
   $size = "2" if(!$size);

return $conf_id;
}

sub make_header
{
    my $header; 
    my $no_banner;
    my $conf_name = shift;

    if(!$conf_id && $conf_name)
    { lookup_conf($conf_name); }

    if(!$conf_id)
    { $hfile = shift; }
    else
    { my $nothing = shift; }
    $no_banner = shift;    

    if($htext !~ m/^\s*$/s)
    {
    $header .= $htext;
    }
    elsif(!$conf_id && $conf_name)
    {
    $hfile = "/home/staff/public_html/conf/$conf_name/empty.html";
    $header = html_header($hfile, $no_banner);
    }
    elsif($hfile)
    {
    $header = html_header($hfile, $no_banner);
    }
    else
    {
    $header = "<HTML><HEAD><TITLE>$conf_name</TITLE></HEAD><BODY BGCOLOR=\"WHITE\">";
    }

    $header =~ s/(<body.*?)\s*(background=.*?)*(\W.*?>)/$1 background="$background"/is if($background);

    $header .= "<TABLE WIDTH=\"$table_width\" BORDER=\"0\">";

    if($logo)
    {
	$header .= "<TR><TD><IMG SRC=\"$logo\" ALIGN=\"LEFT\" BORDER=\"0\"></TD><TD>";
	$header .= `$ADROTATE_CGI 1`;
	$header =~ s|Content-type: text/html||gis;
	$header .= "</TD></TR>";
    }

    if($welcome_text)
    {
	$header .= "<TR><TD>&nbsp; </TD></TR>";
	$header .= "<TR><TD ALIGN=\"CENTER\"><FONT FACE=\"$font\" SIZE=\"$size\"><B>$welcome_text</B></FONT></TD></TR>";
    }

    $header .= "</TABLE>";

    return $header;
}

sub make_footer
{
    my $footer;
    my $no_banner;
     
    my $conf_name = shift;

    if(!$conf_id && $conf_name)
    { lookup_conf($conf_name); }

    if(!$conf_id)
    { $hfile = shift; }
    else
    { my $nothing = shift; }
    $no_banner = shift;

    if($ftext !~ m/^\s*$/s)
    {
    $footer .= $ftext;
    }
    elsif(!$conf_id && $conf_name)
    {
    $hfile = "/home/staff/public_html/conf/$conf_name/empty.html";
    $footer = html_footer($hfile, $no_banner);
    }
    elsif($hfile)
    {
    $footer .= html_footer($hfile, $no_banner);
    }
    
#    $footer .= "<CENTER><FONT FACE=\"Arial\" SIZE=\"-2\"><BR>Copyright 2001 &nbsp; All rights reserved.</FONT></CENTER>";

    if($ftext =~ m/^\s*$/s && !$hfile)
    {
    $footer .= "<P><CENTER>";
    $footer .= `$ADROTATE_CGI 1`;
    $footer =~ s|Content-type: text/html||gis;
    $footer .= "</CENTER>";
    $footer .= "</BODY></HTML>";
    }

    return $footer;
}


