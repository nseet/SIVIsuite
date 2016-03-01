#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_account_funder();
&Launchleader::select_account_funder($Launchleader::account_funder->{'account_funder_id'}) if($Launchleader::account_funder->{'account_funder_id'});
&Launchleader::read_account_funder() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_account_funder($Launchleader::account_funder->{'account_funder_id'});
	}
	else
	{
	   if( !$Launchleader::account_funder->{'account_funder_id'})
	   {
		&Launchleader::insert_account_funder();
	   }
	   else
	   {
		&Launchleader::update_account_funder();
	   }
	}



   print "Location: $Launchleader::ACCOUNT_FUNDERS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::account_funder->{'account_funder_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::account_funder->{'account_funder_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Avatar: &nbsp; <B>$Launchleader::account_funder->{'account_funder_avatar'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Social id: &nbsp; <B>$Launchleader::account_funder->{'account_funder_social_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Username: &nbsp; <B>$Launchleader::account_funder->{'account_funder_username'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Password: &nbsp; <B>$Launchleader::account_funder->{'account_funder_password'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Email: &nbsp; <B>$Launchleader::account_funder->{'account_funder_email'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::ACCOUNT_FUNDERS_CGI">
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
	<FORM ACTION="$Launchleader::ACCOUNT_FUNDER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_id" value="$Launchleader::account_funder->{'account_funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_name" value="$Launchleader::account_funder->{'account_funder_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Avatar: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_avatar" value="$Launchleader::account_funder->{'account_funder_avatar'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Social id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_social_id" value="$Launchleader::account_funder->{'account_funder_social_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_username" value="$Launchleader::account_funder->{'account_funder_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Password: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_password" value="$Launchleader::account_funder->{'account_funder_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_email" value="$Launchleader::account_funder->{'account_funder_email'}">
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
	<FORM ACTION="$Launchleader::ACCOUNT_FUNDER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::account_funder->{'account_funder_id'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_id" value="$Launchleader::account_funder->{'account_funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::account_funder->{'account_funder_name'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_name" value="$Launchleader::account_funder->{'account_funder_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Avatar: &nbsp; <B>$Launchleader::account_funder->{'account_funder_avatar'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_avatar" value="$Launchleader::account_funder->{'account_funder_avatar'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Social id: &nbsp; <B>$Launchleader::account_funder->{'account_funder_social_id'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_social_id" value="$Launchleader::account_funder->{'account_funder_social_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; <B>$Launchleader::account_funder->{'account_funder_username'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_username" value="$Launchleader::account_funder->{'account_funder_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Password: &nbsp; <B>$Launchleader::account_funder->{'account_funder_password'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_password" value="$Launchleader::account_funder->{'account_funder_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; <B>$Launchleader::account_funder->{'account_funder_email'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_email" value="$Launchleader::account_funder->{'account_funder_email'}">
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
#		if($Launchleader::account_funder->{'account_funder_id'} eq "" || ($Launchleader::account_funder->{'account_funder_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_avatar'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Avatar<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_social_id'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Social id<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_username'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Username<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_password'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Password<BR>";
#		return 0;
#		}
#		if($Launchleader::account_funder->{'account_funder_email'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Email<BR>";
#		return 0;
#		}


return 1;
}

 
  
