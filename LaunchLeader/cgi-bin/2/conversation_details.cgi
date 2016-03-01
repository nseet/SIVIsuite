#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_conversation_details();
&Launchleader::select_conversation_details($Launchleader::conversation_details->{'conversation_details_id'}) if($Launchleader::conversation_details->{'conversation_details_id'});
&Launchleader::read_conversation_details() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_conversation_details($Launchleader::conversation_details->{'conversation_details_id'});
	}
	else
	{
	   if( !$Launchleader::conversation_details->{'conversation_details_id'})
	   {
		&Launchleader::insert_conversation_details();
	   }
	   else
	   {
		&Launchleader::update_conversation_details();
	   }
	}



   print "Location: $Launchleader::CONVERSATION_DETAILSS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::conversation_details->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Text: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_text'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Conversation type: &nbsp; <B>$Launchleader::conversation_details->{'conversation_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Conversation email: &nbsp; <B>$Launchleader::conversation_details->{'conversation_email'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::CONVERSATION_DETAILSS_CGI">
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
	<FORM ACTION="$Launchleader::CONVERSATION_DETAILS_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_details_id" value="$Launchleader::conversation_details->{'conversation_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::conversation_details->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Text: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="conversation_details_text" ROWS="10" COLS="50">$Launchleader::conversation_details->{'conversation_details_text'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Conversation type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_type" value="$Launchleader::conversation_details->{'conversation_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Conversation email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_email" value="$Launchleader::conversation_details->{'conversation_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="conversation_details_datetime" value="$Launchleader::conversation_details->{'conversation_details_datetime'}">
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
	<FORM ACTION="$Launchleader::CONVERSATION_DETAILS_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_id'}</B>
		<INPUT TYPE="hidden" NAME="conversation_details_id" value="$Launchleader::conversation_details->{'conversation_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::conversation_details->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::conversation_details->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Text: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_text'}</B>
		<INPUT TYPE="hidden" NAME="conversation_details_text" value="$Launchleader::conversation_details->{'conversation_details_text'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Conversation type: &nbsp; <B>$Launchleader::conversation_details->{'conversation_type'}</B>
		<INPUT TYPE="hidden" NAME="conversation_type" value="$Launchleader::conversation_details->{'conversation_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Conversation email: &nbsp; <B>$Launchleader::conversation_details->{'conversation_email'}</B>
		<INPUT TYPE="hidden" NAME="conversation_email" value="$Launchleader::conversation_details->{'conversation_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::conversation_details->{'conversation_details_datetime'}</B>
		<INPUT TYPE="hidden" NAME="conversation_details_datetime" value="$Launchleader::conversation_details->{'conversation_details_datetime'}">
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
#		if($Launchleader::conversation_details->{'conversation_details_id'} eq "" || ($Launchleader::conversation_details->{'conversation_details_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_details->{'account_id'} eq "" || ($Launchleader::conversation_details->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_details->{'conversation_details_text'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Text<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_details->{'conversation_type'} eq "" || ($Launchleader::conversation_details->{'conversation_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Conversation type<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_details->{'conversation_email'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Conversation email<BR>";
#		return 0;
#		}
#		if($Launchleader::conversation_details->{'conversation_details_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
