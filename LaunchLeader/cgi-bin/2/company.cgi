#!/usr/bin/perl

use lib '..';
use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_company();
&Launchleader::select_company($Launchleader::company->{'company_id'}) if($Launchleader::company->{'company_id'});
&Launchleader::read_company() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_company($Launchleader::company->{'company_id'});
	}
	else
	{
	   if( !$Launchleader::company->{'company_id'})
	   {
		&Launchleader::insert_company();
	   }
	   else
	   {
		&Launchleader::update_company();
	   }
	}



   print "Location: $Launchleader::COMPANYS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::company->{'company_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::company->{'company_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Site: &nbsp; <B>$Launchleader::company->{'company_site'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Phone: &nbsp; <B>$Launchleader::company->{'company_phone'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Email: &nbsp; <B>$Launchleader::company->{'company_email'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Desc: &nbsp; <B>$Launchleader::company->{'company_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::company->{'company_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Agree: &nbsp; <B>$Launchleader::company->{'company_agree'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::company->{'company_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::company->{'company_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::COMPANYS_CGI">
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
	<FORM ACTION="$Launchleader::COMPANY_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_id" value="$Launchleader::company->{'company_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_name" value="$Launchleader::company->{'company_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Site: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_site" value="$Launchleader::company->{'company_site'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Phone: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_phone" value="$Launchleader::company->{'company_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_email" value="$Launchleader::company->{'company_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="company_desc" ROWS="10" COLS="50">$Launchleader::company->{'company_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_note" value="$Launchleader::company->{'company_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Agree: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_agree" value="$Launchleader::company->{'company_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_type" value="$Launchleader::company->{'company_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="company_status" value="$Launchleader::company->{'company_status'}">
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
	<FORM ACTION="$Launchleader::COMPANY_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::company->{'company_id'}</B>
		<INPUT TYPE="hidden" NAME="company_id" value="$Launchleader::company->{'company_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::company->{'company_name'}</B>
		<INPUT TYPE="hidden" NAME="company_name" value="$Launchleader::company->{'company_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Site: &nbsp; <B>$Launchleader::company->{'company_site'}</B>
		<INPUT TYPE="hidden" NAME="company_site" value="$Launchleader::company->{'company_site'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Phone: &nbsp; <B>$Launchleader::company->{'company_phone'}</B>
		<INPUT TYPE="hidden" NAME="company_phone" value="$Launchleader::company->{'company_phone'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Email: &nbsp; <B>$Launchleader::company->{'company_email'}</B>
		<INPUT TYPE="hidden" NAME="company_email" value="$Launchleader::company->{'company_email'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; <B>$Launchleader::company->{'company_desc'}</B>
		<INPUT TYPE="hidden" NAME="company_desc" value="$Launchleader::company->{'company_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::company->{'company_note'}</B>
		<INPUT TYPE="hidden" NAME="company_note" value="$Launchleader::company->{'company_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Agree: &nbsp; <B>$Launchleader::company->{'company_agree'}</B>
		<INPUT TYPE="hidden" NAME="company_agree" value="$Launchleader::company->{'company_agree'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::company->{'company_type'}</B>
		<INPUT TYPE="hidden" NAME="company_type" value="$Launchleader::company->{'company_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::company->{'company_status'}</B>
		<INPUT TYPE="hidden" NAME="company_status" value="$Launchleader::company->{'company_status'}">
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
#		if($Launchleader::company->{'company_id'} eq "" || ($Launchleader::company->{'company_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_site'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Site<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_phone'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Phone<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_email'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Email<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_desc'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_agree'} eq "" || ($Launchleader::company->{'company_agree'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Agree<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_type'} eq "" || ($Launchleader::company->{'company_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::company->{'company_status'} eq "" || ($Launchleader::company->{'company_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
