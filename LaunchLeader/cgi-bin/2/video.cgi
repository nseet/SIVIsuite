#!/usr/bin/perl

use lib '..';
use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_video();
&Launchleader::select_video($Launchleader::video->{'video_id'}) if($Launchleader::video->{'video_id'});
&Launchleader::read_video() if($stage>=2 && $mode eq "edit");


if($stage==0) #View mode
{
   print $Launchleader::_query->header();
   print &Launchleader::html_header($Launchleader::HFILE);
   print html_stage0();
   print &Launchleader::html_footer($Launchleader::HFILE);
}
elsif($stage == 1 || !verify_stage1()) 
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
elsif($stage==3)
{
	if($mode eq "delete")
	{
	   &Launchleader::delete_video($Launchleader::video->{'video_id'});
	}
	else
	{
	   if( !$Launchleader::video->{'video_id'})
	   {
		&Launchleader::insert_video();
	   }
	   else
	   {
		&Launchleader::update_video();
	   }
	}



   print "Location: $Launchleader::VIDEOS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::video->{'video_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::video->{'video_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Url: &nbsp; <B>$Launchleader::video->{'video_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Source: &nbsp; <B>$Launchleader::video->{'video_source'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Start: &nbsp; <B>$Launchleader::video->{'video_start'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 End: &nbsp; <B>$Launchleader::video->{'video_end'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Hint start: &nbsp; <B>$Launchleader::video->{'video_hint_start'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Hint end: &nbsp; <B>$Launchleader::video->{'video_hint_end'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Added: &nbsp; <B>$Launchleader::video->{'video_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Last: &nbsp; <B>$Launchleader::video->{'video_last'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::video->{'video_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::VIDEOS_CGI">
        $Launchleader::HIDDEN
        <INPUT TYPE="hidden" NAME="stage" VALUE="1">
        </FORM>

        </FONT>
        </TD>
   </TR>

</TABLE>
EOM
   
return $str;
   
}

sub html_stage1
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">
   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE" COLOR="red">
        $Launchleader::ERROR 
        </FONT>
        </TD>
   </TR>
   <TR>
	<TD>
	<FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<FORM ACTION="$Launchleader::VIDEO_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_id" value="$Launchleader::video->{'video_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_name" value="$Launchleader::video->{'video_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_url" value="$Launchleader::video->{'video_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Source: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_source" value="$Launchleader::video->{'video_source'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Start: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_start" value="$Launchleader::video->{'video_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		End: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_end" value="$Launchleader::video->{'video_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Hint start: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_hint_start" value="$Launchleader::video->{'video_hint_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Hint end: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_hint_end" value="$Launchleader::video->{'video_hint_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_added" value="$Launchleader::video->{'video_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Last: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_last" value="$Launchleader::video->{'video_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_status" value="$Launchleader::video->{'video_status'}">
		</FONT></TD></TR>

		<TR><TD>
		<INPUT TYPE="submit" NAME="Submit" VALUE="Submit">&nbsp;&nbsp;&nbsp;
		<INPUT TYPE="reset" NAME="Reset" VALUE="Reset">
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
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">
   <TR>
	<TD>
	<FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
	<FORM ACTION="$Launchleader::VIDEO_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::video->{'video_id'}</B>
		<INPUT TYPE="hidden" NAME="video_id" value="$Launchleader::video->{'video_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::video->{'video_name'}</B>
		<INPUT TYPE="hidden" NAME="video_name" value="$Launchleader::video->{'video_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; <B>$Launchleader::video->{'video_url'}</B>
		<INPUT TYPE="hidden" NAME="video_url" value="$Launchleader::video->{'video_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Source: &nbsp; <B>$Launchleader::video->{'video_source'}</B>
		<INPUT TYPE="hidden" NAME="video_source" value="$Launchleader::video->{'video_source'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Start: &nbsp; <B>$Launchleader::video->{'video_start'}</B>
		<INPUT TYPE="hidden" NAME="video_start" value="$Launchleader::video->{'video_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		End: &nbsp; <B>$Launchleader::video->{'video_end'}</B>
		<INPUT TYPE="hidden" NAME="video_end" value="$Launchleader::video->{'video_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Hint start: &nbsp; <B>$Launchleader::video->{'video_hint_start'}</B>
		<INPUT TYPE="hidden" NAME="video_hint_start" value="$Launchleader::video->{'video_hint_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Hint end: &nbsp; <B>$Launchleader::video->{'video_hint_end'}</B>
		<INPUT TYPE="hidden" NAME="video_hint_end" value="$Launchleader::video->{'video_hint_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; <B>$Launchleader::video->{'video_added'}</B>
		<INPUT TYPE="hidden" NAME="video_added" value="$Launchleader::video->{'video_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Last: &nbsp; <B>$Launchleader::video->{'video_last'}</B>
		<INPUT TYPE="hidden" NAME="video_last" value="$Launchleader::video->{'video_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::video->{'video_status'}</B>
		<INPUT TYPE="hidden" NAME="video_status" value="$Launchleader::video->{'video_status'}">
		</FONT></TD></TR>

		<TR><TD>
		<FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		If you are satisfied with your responses, click Done, otherwise, click Back.
		</FONT>
		</TD></TR>
		<TR><TD>
		<INPUT TYPE="submit" NAME="Done" VALUE="Done">
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

sub verify_stage1
{
#		if($Launchleader::video->{'video_id'} eq "" || ($Launchleader::video->{'video_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_url'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_source'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Source<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_start'} eq "" || ($Launchleader::video->{'video_start'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Start<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_end'} eq "" || ($Launchleader::video->{'video_end'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid End<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_hint_start'} eq "" || ($Launchleader::video->{'video_hint_start'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Hint start<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_hint_end'} eq "" || ($Launchleader::video->{'video_hint_end'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Hint end<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_added'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_last'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Last<BR>";
#		return 0;
#		}
#		if($Launchleader::video->{'video_status'} eq "" || ($Launchleader::video->{'video_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
