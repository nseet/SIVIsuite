#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_account_partner();
&Launchleader::select_account_partner($Launchleader::account_partner->{'account_partner_id'}) if($Launchleader::account_partner->{'account_partner_id'});
&Launchleader::read_account_partner() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_account_partner($Launchleader::account_partner->{'account_partner_id'});
	}
	else
	{
	   if( !$Launchleader::account_partner->{'account_partner_id'})
	   {
		&Launchleader::insert_account_partner();
	   }
	   else
	   {
		&Launchleader::update_account_partner();
	   }
	}



   print "Location: $Launchleader::ACCOUNT_PARTNERS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::account_partner->{'account_partner_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::account_partner->{'account_partner_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Crumb: &nbsp; <B>$Launchleader::account_partner->{'account_partner_crumb'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Details: &nbsp; <B>$Launchleader::account_partner->{'account_partner_details'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Thumbnail: &nbsp; <B>$Launchleader::account_partner->{'account_partner_thumbnail'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::account_partner->{'account_partner_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::ACCOUNT_PARTNERS_CGI">
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
	<FORM ACTION="$Launchleader::ACCOUNT_PARTNER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partner_id" value="$Launchleader::account_partner->{'account_partner_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partner_name" value="$Launchleader::account_partner->{'account_partner_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Crumb: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partner_crumb" value="$Launchleader::account_partner->{'account_partner_crumb'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Details: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_partner_details" ROWS="10" COLS="50">$Launchleader::account_partner->{'account_partner_details'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Thumbnail: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partner_thumbnail" value="$Launchleader::account_partner->{'account_partner_thumbnail'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_partner_status" value="$Launchleader::account_partner->{'account_partner_status'}">
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
	<FORM ACTION="$Launchleader::ACCOUNT_PARTNER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::account_partner->{'account_partner_id'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_id" value="$Launchleader::account_partner->{'account_partner_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::account_partner->{'account_partner_name'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_name" value="$Launchleader::account_partner->{'account_partner_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Crumb: &nbsp; <B>$Launchleader::account_partner->{'account_partner_crumb'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_crumb" value="$Launchleader::account_partner->{'account_partner_crumb'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Details: &nbsp; <B>$Launchleader::account_partner->{'account_partner_details'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_details" value="$Launchleader::account_partner->{'account_partner_details'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Thumbnail: &nbsp; <B>$Launchleader::account_partner->{'account_partner_thumbnail'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_thumbnail" value="$Launchleader::account_partner->{'account_partner_thumbnail'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::account_partner->{'account_partner_status'}</B>
		<INPUT TYPE="hidden" NAME="account_partner_status" value="$Launchleader::account_partner->{'account_partner_status'}">
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
#		if($Launchleader::account_partner->{'account_partner_id'} eq "" || ($Launchleader::account_partner->{'account_partner_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::account_partner->{'account_partner_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::account_partner->{'account_partner_crumb'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Crumb<BR>";
#		return 0;
#		}
#		if($Launchleader::account_partner->{'account_partner_details'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Details<BR>";
#		return 0;
#		}
#		if($Launchleader::account_partner->{'account_partner_thumbnail'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Thumbnail<BR>";
#		return 0;
#		}
#		if($Launchleader::account_partner->{'account_partner_status'} eq "" || ($Launchleader::account_partner->{'account_partner_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
