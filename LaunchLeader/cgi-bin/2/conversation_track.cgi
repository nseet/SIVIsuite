#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_conversation_track();
&Launchleader::select_conversation_track($Launchleader::conversation_track->{'conversation_track_id'}) if($Launchleader::conversation_track->{'conversation_track_id'});
&Launchleader::read_conversation_track() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_conversation_track($Launchleader::conversation_track->{'conversation_track_id'});
	}
	else
	{
	   if( !$Launchleader::conversation_track->{'conversation_track_id'})
	   {
		&Launchleader::insert_conversation_track();
	   }
	   else
	   {
		&Launchleader::update_conversation_track();
	   }
	}



   print "Location: $Launchleader::CONVERSATION_TRACKS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::conversation_track->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Funder id: &nbsp; <B>$Launchleader::conversation_track->{'funder_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Token: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_token'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::CONVERSATION_TRACKS_CGI">
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
	<FORM ACTION="$Launchleader::CONVERSATION_TRACK_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_track_id" value="$Launchleader::conversation_track->{'conversation_track_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::conversation_track->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funder id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funder_id" value="$Launchleader::conversation_track->{'funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Token: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_track_token" value="$Launchleader::conversation_track->{'conversation_track_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_track_datetime" value="$Launchleader::conversation_track->{'conversation_track_datetime'}">
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
	<FORM ACTION="$Launchleader::CONVERSATION_TRACK_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_id'}</B>
		<INPUT TYPE="hidden" NAME="conversation_track_id" value="$Launchleader::conversation_track->{'conversation_track_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::conversation_track->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::conversation_track->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funder id: &nbsp; <B>$Launchleader::conversation_track->{'funder_id'}</B>
		<INPUT TYPE="hidden" NAME="funder_id" value="$Launchleader::conversation_track->{'funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Token: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_token'}</B>
		<INPUT TYPE="hidden" NAME="conversation_track_token" value="$Launchleader::conversation_track->{'conversation_track_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::conversation_track->{'conversation_track_datetime'}</B>
		<INPUT TYPE="hidden" NAME="conversation_track_datetime" value="$Launchleader::conversation_track->{'conversation_track_datetime'}">
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
#		if($Launchleader::conversation_track->{'conversation_track_id'} eq "" || ($Launchleader::conversation_track->{'conversation_track_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_track->{'account_id'} eq "" || ($Launchleader::conversation_track->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_track->{'funder_id'} eq "" || ($Launchleader::conversation_track->{'funder_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Funder id<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_track->{'conversation_track_token'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Token<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_track->{'conversation_track_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
