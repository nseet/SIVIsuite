#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_account();
&Launchleader::select_account($Launchleader::account->{'account_id'}) if($Launchleader::account->{'account_id'});
&Launchleader::read_account() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_account($Launchleader::account->{'account_id'});
	}
	else
	{
	   if( !$Launchleader::account->{'account_id'})
	   {
		&Launchleader::insert_account();
	   }
	   else
	   {
		&Launchleader::update_account();
	   }
	}



   print "Location: $Launchleader::ACCOUNTS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::account->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Username: &nbsp; <B>$Launchleader::account->{'account_username'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Password: &nbsp; <B>$Launchleader::account->{'account_password'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name first: &nbsp; <B>$Launchleader::account->{'account_name_first'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name last: &nbsp; <B>$Launchleader::account->{'account_name_last'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Phone: &nbsp; <B>$Launchleader::account->{'account_phone'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Email: &nbsp; <B>$Launchleader::account->{'account_email'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Desc: &nbsp; <B>$Launchleader::account->{'account_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::account->{'account_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Agree: &nbsp; <B>$Launchleader::account->{'account_agree'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Created: &nbsp; <B>$Launchleader::account->{'account_created'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Accessed: &nbsp; <B>$Launchleader::account->{'account_accessed'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::account->{'account_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Verified: &nbsp; <B>$Launchleader::account->{'account_verified'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::account->{'account_status'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Partnercrumb: &nbsp; <B>$Launchleader::account->{'account_partnercrumb'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::ACCOUNTS_CGI">
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
	<FORM ACTION="$Launchleader::ACCOUNT_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::account->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_username" value="$Launchleader::account->{'account_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Password: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_password" value="$Launchleader::account->{'account_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name first: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_first" value="$Launchleader::account->{'account_name_first'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name last: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_name_last" value="$Launchleader::account->{'account_name_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Phone: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_phone" value="$Launchleader::account->{'account_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_email" value="$Launchleader::account->{'account_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_desc" ROWS="10" COLS="50">$Launchleader::account->{'account_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_note" ROWS="10" COLS="50">$Launchleader::account->{'account_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Agree: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_agree" value="$Launchleader::account->{'account_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Created: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_created" value="$Launchleader::account->{'account_created'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Accessed: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_accessed" value="$Launchleader::account->{'account_accessed'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_type" value="$Launchleader::account->{'account_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Verified: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_verified" value="$Launchleader::account->{'account_verified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_status" value="$Launchleader::account->{'account_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Partnercrumb: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partnercrumb" value="$Launchleader::account->{'account_partnercrumb'}">
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
	<FORM ACTION="$Launchleader::ACCOUNT_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::account->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::account->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Username: &nbsp; <B>$Launchleader::account->{'account_username'}</B>
		<INPUT TYPE="hidden" NAME="account_username" value="$Launchleader::account->{'account_username'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Password: &nbsp; <B>$Launchleader::account->{'account_password'}</B>
		<INPUT TYPE="hidden" NAME="account_password" value="$Launchleader::account->{'account_password'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name first: &nbsp; <B>$Launchleader::account->{'account_name_first'}</B>
		<INPUT TYPE="hidden" NAME="account_name_first" value="$Launchleader::account->{'account_name_first'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name last: &nbsp; <B>$Launchleader::account->{'account_name_last'}</B>
		<INPUT TYPE="hidden" NAME="account_name_last" value="$Launchleader::account->{'account_name_last'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Phone: &nbsp; <B>$Launchleader::account->{'account_phone'}</B>
		<INPUT TYPE="hidden" NAME="account_phone" value="$Launchleader::account->{'account_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; <B>$Launchleader::account->{'account_email'}</B>
		<INPUT TYPE="hidden" NAME="account_email" value="$Launchleader::account->{'account_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; <B>$Launchleader::account->{'account_desc'}</B>
		<INPUT TYPE="hidden" NAME="account_desc" value="$Launchleader::account->{'account_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::account->{'account_note'}</B>
		<INPUT TYPE="hidden" NAME="account_note" value="$Launchleader::account->{'account_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Agree: &nbsp; <B>$Launchleader::account->{'account_agree'}</B>
		<INPUT TYPE="hidden" NAME="account_agree" value="$Launchleader::account->{'account_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Created: &nbsp; <B>$Launchleader::account->{'account_created'}</B>
		<INPUT TYPE="hidden" NAME="account_created" value="$Launchleader::account->{'account_created'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Accessed: &nbsp; <B>$Launchleader::account->{'account_accessed'}</B>
		<INPUT TYPE="hidden" NAME="account_accessed" value="$Launchleader::account->{'account_accessed'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::account->{'account_type'}</B>
		<INPUT TYPE="hidden" NAME="account_type" value="$Launchleader::account->{'account_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Verified: &nbsp; <B>$Launchleader::account->{'account_verified'}</B>
		<INPUT TYPE="hidden" NAME="account_verified" value="$Launchleader::account->{'account_verified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::account->{'account_status'}</B>
		<INPUT TYPE="hidden" NAME="account_status" value="$Launchleader::account->{'account_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Partnercrumb: &nbsp; <B>$Launchleader::account->{'account_partnercrumb'}</B>
		<INPUT TYPE="hidden" NAME="account_partnercrumb" value="$Launchleader::account->{'account_partnercrumb'}">
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
#		if($Launchleader::account->{'account_id'} eq "" || ($Launchleader::account->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_username'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Username<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_password'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Password<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_name_first'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name first<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_name_last'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name last<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_phone'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Phone<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_email'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Email<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_desc'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_agree'} eq "" || ($Launchleader::account->{'account_agree'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Agree<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_created'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Created<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_accessed'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Accessed<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_type'} eq "" || ($Launchleader::account->{'account_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_verified'} eq "" || ($Launchleader::account->{'account_verified'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Verified<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_status'} eq "" || ($Launchleader::account->{'account_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}
#		if($Launchleader::account->{'account_partnercrumb'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Partnercrumb<BR>";
#		return 0;
#		}


return 1;
}

 
  
