#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_user_update();
&Launchleader::select_user_update($Launchleader::user_update->{'user_update_id'}) if($Launchleader::user_update->{'user_update_id'});
&Launchleader::read_user_update() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_user_update($Launchleader::user_update->{'user_update_id'});
	}
	else
	{
	   if( !$Launchleader::user_update->{'user_update_id'})
	   {
		&Launchleader::insert_user_update();
	   }
	   else
	   {
		&Launchleader::update_user_update();
	   }
	}



   print "Location: $Launchleader::USER_UPDATES_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::user_update->{'user_update_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::user_update->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Campaign id: &nbsp; <B>$Launchleader::user_update->{'campaign_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Title: &nbsp; <B>$Launchleader::user_update->{'user_update_title'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Text: &nbsp; <B>$Launchleader::user_update->{'user_update_text'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Public: &nbsp; <B>$Launchleader::user_update->{'user_update_public'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Sendemail: &nbsp; <B>$Launchleader::user_update->{'user_update_sendemail'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::user_update->{'user_update_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::USER_UPDATES_CGI">
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
	<FORM ACTION="$Launchleader::USER_UPDATE_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_id" value="$Launchleader::user_update->{'user_update_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::user_update->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Campaign id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="campaign_id" value="$Launchleader::user_update->{'campaign_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Title: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_title" value="$Launchleader::user_update->{'user_update_title'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Text: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="user_update_text" ROWS="10" COLS="50">$Launchleader::user_update->{'user_update_text'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Public: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_public" value="$Launchleader::user_update->{'user_update_public'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Sendemail: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_sendemail" value="$Launchleader::user_update->{'user_update_sendemail'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="user_update_datetime" value="$Launchleader::user_update->{'user_update_datetime'}">
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
	<FORM ACTION="$Launchleader::USER_UPDATE_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::user_update->{'user_update_id'}</B>
		<INPUT TYPE="hidden" NAME="user_update_id" value="$Launchleader::user_update->{'user_update_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::user_update->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::user_update->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Campaign id: &nbsp; <B>$Launchleader::user_update->{'campaign_id'}</B>
		<INPUT TYPE="hidden" NAME="campaign_id" value="$Launchleader::user_update->{'campaign_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Title: &nbsp; <B>$Launchleader::user_update->{'user_update_title'}</B>
		<INPUT TYPE="hidden" NAME="user_update_title" value="$Launchleader::user_update->{'user_update_title'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Text: &nbsp; <B>$Launchleader::user_update->{'user_update_text'}</B>
		<INPUT TYPE="hidden" NAME="user_update_text" value="$Launchleader::user_update->{'user_update_text'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Public: &nbsp; <B>$Launchleader::user_update->{'user_update_public'}</B>
		<INPUT TYPE="hidden" NAME="user_update_public" value="$Launchleader::user_update->{'user_update_public'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Sendemail: &nbsp; <B>$Launchleader::user_update->{'user_update_sendemail'}</B>
		<INPUT TYPE="hidden" NAME="user_update_sendemail" value="$Launchleader::user_update->{'user_update_sendemail'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::user_update->{'user_update_datetime'}</B>
		<INPUT TYPE="hidden" NAME="user_update_datetime" value="$Launchleader::user_update->{'user_update_datetime'}">
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
#		if($Launchleader::user_update->{'user_update_id'} eq "" || ($Launchleader::user_update->{'user_update_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'account_id'} eq "" || ($Launchleader::user_update->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'campaign_id'} eq "" || ($Launchleader::user_update->{'campaign_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Campaign id<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'user_update_title'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Title<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'user_update_text'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Text<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'user_update_public'} eq "" || ($Launchleader::user_update->{'user_update_public'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Public<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'user_update_sendemail'} eq "" || ($Launchleader::user_update->{'user_update_sendemail'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Sendemail<BR>";
#		return 0;
#		}
#		if($Launchleader::user_update->{'user_update_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
