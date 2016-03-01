#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_email_disburse();
&Launchleader::select_email_disburse($Launchleader::email_disburse->{'email_disburse_id'}) if($Launchleader::email_disburse->{'email_disburse_id'});
&Launchleader::read_email_disburse() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_email_disburse($Launchleader::email_disburse->{'email_disburse_id'});
	}
	else
	{
	   if( !$Launchleader::email_disburse->{'email_disburse_id'})
	   {
		&Launchleader::insert_email_disburse();
	   }
	   else
	   {
		&Launchleader::update_email_disburse();
	   }
	}



   print "Location: $Launchleader::EMAIL_DISBURSES_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Email type: &nbsp; <B>$Launchleader::email_disburse->{'email_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Ref: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_ref'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_status'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::EMAIL_DISBURSES_CGI">
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
	<FORM ACTION="$Launchleader::EMAIL_DISBURSE_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="email_disburse_id" value="$Launchleader::email_disburse->{'email_disburse_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="email_type" value="$Launchleader::email_disburse->{'email_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ref: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="email_disburse_ref" value="$Launchleader::email_disburse->{'email_disburse_ref'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="email_disburse_status" value="$Launchleader::email_disburse->{'email_disburse_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="email_disburse_datetime" value="$Launchleader::email_disburse->{'email_disburse_datetime'}">
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
	<FORM ACTION="$Launchleader::EMAIL_DISBURSE_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_id'}</B>
		<INPUT TYPE="hidden" NAME="email_disburse_id" value="$Launchleader::email_disburse->{'email_disburse_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email type: &nbsp; <B>$Launchleader::email_disburse->{'email_type'}</B>
		<INPUT TYPE="hidden" NAME="email_type" value="$Launchleader::email_disburse->{'email_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ref: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_ref'}</B>
		<INPUT TYPE="hidden" NAME="email_disburse_ref" value="$Launchleader::email_disburse->{'email_disburse_ref'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_status'}</B>
		<INPUT TYPE="hidden" NAME="email_disburse_status" value="$Launchleader::email_disburse->{'email_disburse_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::email_disburse->{'email_disburse_datetime'}</B>
		<INPUT TYPE="hidden" NAME="email_disburse_datetime" value="$Launchleader::email_disburse->{'email_disburse_datetime'}">
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
#		if($Launchleader::email_disburse->{'email_disburse_id'} eq "" || ($Launchleader::email_disburse->{'email_disburse_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::email_disburse->{'email_type'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Email type<BR>";
#		return 0;
#		}
#		if($Launchleader::email_disburse->{'email_disburse_ref'} eq "" || ($Launchleader::email_disburse->{'email_disburse_ref'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Ref<BR>";
#		return 0;
#		}
#		if($Launchleader::email_disburse->{'email_disburse_status'} eq "" || ($Launchleader::email_disburse->{'email_disburse_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}
#		if($Launchleader::email_disburse->{'email_disburse_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
