#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_account_verification();
&Launchleader::select_account_verification($Launchleader::account_verification->{'account_verification_id'}) if($Launchleader::account_verification->{'account_verification_id'});
&Launchleader::read_account_verification() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_account_verification($Launchleader::account_verification->{'account_verification_id'});
	}
	else
	{
	   if( !$Launchleader::account_verification->{'account_verification_id'})
	   {
		&Launchleader::insert_account_verification();
	   }
	   else
	   {
		&Launchleader::update_account_verification();
	   }
	}



   print "Location: $Launchleader::ACCOUNT_VERIFICATIONS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::account_verification->{'account_verification_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Username: &nbsp; <B>$Launchleader::account_verification->{'account_verification_username'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Token: &nbsp; <B>$Launchleader::account_verification->{'account_verification_token'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Taken: &nbsp; <B>$Launchleader::account_verification->{'account_verification_taken'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Expire: &nbsp; <B>$Launchleader::account_verification->{'account_verification_expire'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::ACCOUNT_VERIFICATIONS_CGI">
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
	<FORM ACTION="$Launchleader::ACCOUNT_VERIFICATION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verification_id" value="$Launchleader::account_verification->{'account_verification_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verification_username" value="$Launchleader::account_verification->{'account_verification_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Token: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verification_token" value="$Launchleader::account_verification->{'account_verification_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Taken: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verification_taken" value="$Launchleader::account_verification->{'account_verification_taken'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Expire: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verification_expire" value="$Launchleader::account_verification->{'account_verification_expire'}">
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
	<FORM ACTION="$Launchleader::ACCOUNT_VERIFICATION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::account_verification->{'account_verification_id'}</B>
		<INPUT TYPE="hidden" NAME="account_verification_id" value="$Launchleader::account_verification->{'account_verification_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; <B>$Launchleader::account_verification->{'account_verification_username'}</B>
		<INPUT TYPE="hidden" NAME="account_verification_username" value="$Launchleader::account_verification->{'account_verification_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Token: &nbsp; <B>$Launchleader::account_verification->{'account_verification_token'}</B>
		<INPUT TYPE="hidden" NAME="account_verification_token" value="$Launchleader::account_verification->{'account_verification_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Taken: &nbsp; <B>$Launchleader::account_verification->{'account_verification_taken'}</B>
		<INPUT TYPE="hidden" NAME="account_verification_taken" value="$Launchleader::account_verification->{'account_verification_taken'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Expire: &nbsp; <B>$Launchleader::account_verification->{'account_verification_expire'}</B>
		<INPUT TYPE="hidden" NAME="account_verification_expire" value="$Launchleader::account_verification->{'account_verification_expire'}">
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
#		if($Launchleader::account_verification->{'account_verification_id'} eq "" || ($Launchleader::account_verification->{'account_verification_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::account_verification->{'account_verification_username'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Username<BR>";
#		return 0;
#		}
#		if($Launchleader::account_verification->{'account_verification_token'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Token<BR>";
#		return 0;
#		}
#		if($Launchleader::account_verification->{'account_verification_taken'} eq "" || ($Launchleader::account_verification->{'account_verification_taken'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Taken<BR>";
#		return 0;
#		}
#		if($Launchleader::account_verification->{'account_verification_expire'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Expire<BR>";
#		return 0;
#		}


return 1;
}

 
  
