#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_funding_details();
&Launchleader::select_funding_details($Launchleader::funding_details->{'funding_details_id'}) if($Launchleader::funding_details->{'funding_details_id'});
&Launchleader::read_funding_details() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_funding_details($Launchleader::funding_details->{'funding_details_id'});
	}
	else
	{
	   if( !$Launchleader::funding_details->{'funding_details_id'})
	   {
		&Launchleader::insert_funding_details();
	   }
	   else
	   {
		&Launchleader::update_funding_details();
	   }
	}



   print "Location: $Launchleader::FUNDING_DETAILSS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::funding_details->{'funding_details_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account funder id: &nbsp; <B>$Launchleader::funding_details->{'account_funder_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::funding_details->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Element id: &nbsp; <B>$Launchleader::funding_details->{'element_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Fund amount: &nbsp; <B>$Launchleader::funding_details->{'fund_amount'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Anonymous: &nbsp; <B>$Launchleader::funding_details->{'funding_details_anonymous'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::funding_details->{'funding_details_status'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::funding_details->{'funding_details_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::FUNDING_DETAILSS_CGI">
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
	<FORM ACTION="$Launchleader::FUNDING_DETAILS_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_id" value="$Launchleader::funding_details->{'funding_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account funder id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_funder_id" value="$Launchleader::funding_details->{'account_funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::funding_details->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="element_id" value="$Launchleader::funding_details->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Fund amount: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_amount" value="$Launchleader::funding_details->{'fund_amount'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Anonymous: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_anonymous" value="$Launchleader::funding_details->{'funding_details_anonymous'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_status" value="$Launchleader::funding_details->{'funding_details_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_datetime" value="$Launchleader::funding_details->{'funding_details_datetime'}">
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
	<FORM ACTION="$Launchleader::FUNDING_DETAILS_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::funding_details->{'funding_details_id'}</B>
		<INPUT TYPE="hidden" NAME="funding_details_id" value="$Launchleader::funding_details->{'funding_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account funder id: &nbsp; <B>$Launchleader::funding_details->{'account_funder_id'}</B>
		<INPUT TYPE="hidden" NAME="account_funder_id" value="$Launchleader::funding_details->{'account_funder_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::funding_details->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::funding_details->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; <B>$Launchleader::funding_details->{'element_id'}</B>
		<INPUT TYPE="hidden" NAME="element_id" value="$Launchleader::funding_details->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Fund amount: &nbsp; <B>$Launchleader::funding_details->{'fund_amount'}</B>
		<INPUT TYPE="hidden" NAME="fund_amount" value="$Launchleader::funding_details->{'fund_amount'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Anonymous: &nbsp; <B>$Launchleader::funding_details->{'funding_details_anonymous'}</B>
		<INPUT TYPE="hidden" NAME="funding_details_anonymous" value="$Launchleader::funding_details->{'funding_details_anonymous'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::funding_details->{'funding_details_status'}</B>
		<INPUT TYPE="hidden" NAME="funding_details_status" value="$Launchleader::funding_details->{'funding_details_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::funding_details->{'funding_details_datetime'}</B>
		<INPUT TYPE="hidden" NAME="funding_details_datetime" value="$Launchleader::funding_details->{'funding_details_datetime'}">
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
#		if($Launchleader::funding_details->{'funding_details_id'} eq "" || ($Launchleader::funding_details->{'funding_details_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'account_funder_id'} eq "" || ($Launchleader::funding_details->{'account_funder_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account funder id<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'account_id'} eq "" || ($Launchleader::funding_details->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'element_id'} eq "" || ($Launchleader::funding_details->{'element_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Element id<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'fund_amount'} eq "" || ($Launchleader::funding_details->{'fund_amount'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Fund amount<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'funding_details_anonymous'} eq "" || ($Launchleader::funding_details->{'funding_details_anonymous'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Anonymous<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'funding_details_status'} eq "" || ($Launchleader::funding_details->{'funding_details_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}
#		if($Launchleader::funding_details->{'funding_details_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
