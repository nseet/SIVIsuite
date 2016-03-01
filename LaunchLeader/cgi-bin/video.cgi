#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_video();
&Launchh::select_video($Launchh::video->{'video_id'}) if($Launchh::video->{'video_id'});
&Launchh::read_video() if($stage>=2 && $mode eq "edit");


if($stage==0) #View mode
{
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage0();
   print &Launchh::html_footer($Launchh::HFILE);
}
elsif($stage == 1 || !verify_stage1()) 
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
elsif($stage==3)
{
	if($mode eq "delete")
	{
	   &Launchh::delete_video($Launchh::video->{'video_id'});
	}
	else
	{
	   if( !$Launchh::video->{'video_id'})
	   {
		&Launchh::insert_video();
	   }
	   else
	   {
		&Launchh::update_video();
	   }
	}



   print "Location: $Launchh::VIDEOS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::video->{'video_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Name: &nbsp; <B>$Launchh::video->{'video_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Url: &nbsp; <B>$Launchh::video->{'video_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Source: &nbsp; <B>$Launchh::video->{'video_source'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Start: &nbsp; <B>$Launchh::video->{'video_start'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 End: &nbsp; <B>$Launchh::video->{'video_end'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Hint start: &nbsp; <B>$Launchh::video->{'video_hint_start'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Hint end: &nbsp; <B>$Launchh::video->{'video_hint_end'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Added: &nbsp; <B>$Launchh::video->{'video_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Last: &nbsp; <B>$Launchh::video->{'video_last'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::video->{'video_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::VIDEOS_CGI">
        $Launchh::HIDDEN
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
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE" COLOR="red">
        $Launchh::ERROR 
        </FONT>
        </TD>
   </TR>
   <TR>
	<TD>
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<FORM ACTION="$Launchh::VIDEO_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_id" value="$Launchh::video->{'video_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_name" value="$Launchh::video->{'video_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_url" value="$Launchh::video->{'video_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Source: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_source" value="$Launchh::video->{'video_source'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Start: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_start" value="$Launchh::video->{'video_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		End: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_end" value="$Launchh::video->{'video_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Hint start: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_hint_start" value="$Launchh::video->{'video_hint_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Hint end: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_hint_end" value="$Launchh::video->{'video_hint_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_added" value="$Launchh::video->{'video_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Last: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_last" value="$Launchh::video->{'video_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="video_status" value="$Launchh::video->{'video_status'}">
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
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">
   <TR>
	<TD>
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<FORM ACTION="$Launchh::VIDEO_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::video->{'video_id'}</B>
		<INPUT TYPE="hidden" NAME="video_id" value="$Launchh::video->{'video_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; <B>$Launchh::video->{'video_name'}</B>
		<INPUT TYPE="hidden" NAME="video_name" value="$Launchh::video->{'video_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; <B>$Launchh::video->{'video_url'}</B>
		<INPUT TYPE="hidden" NAME="video_url" value="$Launchh::video->{'video_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Source: &nbsp; <B>$Launchh::video->{'video_source'}</B>
		<INPUT TYPE="hidden" NAME="video_source" value="$Launchh::video->{'video_source'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Start: &nbsp; <B>$Launchh::video->{'video_start'}</B>
		<INPUT TYPE="hidden" NAME="video_start" value="$Launchh::video->{'video_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		End: &nbsp; <B>$Launchh::video->{'video_end'}</B>
		<INPUT TYPE="hidden" NAME="video_end" value="$Launchh::video->{'video_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Hint start: &nbsp; <B>$Launchh::video->{'video_hint_start'}</B>
		<INPUT TYPE="hidden" NAME="video_hint_start" value="$Launchh::video->{'video_hint_start'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Hint end: &nbsp; <B>$Launchh::video->{'video_hint_end'}</B>
		<INPUT TYPE="hidden" NAME="video_hint_end" value="$Launchh::video->{'video_hint_end'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; <B>$Launchh::video->{'video_added'}</B>
		<INPUT TYPE="hidden" NAME="video_added" value="$Launchh::video->{'video_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Last: &nbsp; <B>$Launchh::video->{'video_last'}</B>
		<INPUT TYPE="hidden" NAME="video_last" value="$Launchh::video->{'video_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::video->{'video_status'}</B>
		<INPUT TYPE="hidden" NAME="video_status" value="$Launchh::video->{'video_status'}">
		</FONT></TD></TR>

		<TR><TD>
		<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
#		if($Launchh::video->{'video_id'} eq "" || ($Launchh::video->{'video_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_name'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_url'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_source'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Source<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_start'} eq "" || ($Launchh::video->{'video_start'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Start<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_end'} eq "" || ($Launchh::video->{'video_end'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid End<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_hint_start'} eq "" || ($Launchh::video->{'video_hint_start'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Hint start<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_hint_end'} eq "" || ($Launchh::video->{'video_hint_end'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Hint end<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_added'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_last'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Last<BR>";
#		return 0;
#		}
#		if($Launchh::video->{'video_status'} eq "" || ($Launchh::video->{'video_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
