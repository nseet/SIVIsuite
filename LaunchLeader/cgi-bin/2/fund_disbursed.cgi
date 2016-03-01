#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_fund_disbursed();
&Launchleader::select_fund_disbursed($Launchleader::fund_disbursed->{'fund_disbursed_id'}) if($Launchleader::fund_disbursed->{'fund_disbursed_id'});
&Launchleader::read_fund_disbursed() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_fund_disbursed($Launchleader::fund_disbursed->{'fund_disbursed_id'});
	}
	else
	{
	   if( !$Launchleader::fund_disbursed->{'fund_disbursed_id'})
	   {
		&Launchleader::insert_fund_disbursed();
	   }
	   else
	   {
		&Launchleader::update_fund_disbursed();
	   }
	}



   print "Location: $Launchleader::FUND_DISBURSEDS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::fund_disbursed->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Project id: &nbsp; <B>$Launchleader::fund_disbursed->{'project_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Element id: &nbsp; <B>$Launchleader::fund_disbursed->{'element_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Fund amount: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_amount'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Disburse status: &nbsp; <B>$Launchleader::fund_disbursed->{'disburse_status'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Application fee: &nbsp; <B>$Launchleader::fund_disbursed->{'application_fee'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Disburse token: &nbsp; <B>$Launchleader::fund_disbursed->{'disburse_token'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Funding details id: &nbsp; <B>$Launchleader::fund_disbursed->{'funding_details_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_status'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Datetime: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::FUND_DISBURSEDS_CGI">
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
	<FORM ACTION="$Launchleader::FUND_DISBURSED_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_id" value="$Launchleader::fund_disbursed->{'fund_disbursed_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::fund_disbursed->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Project id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="project_id" value="$Launchleader::fund_disbursed->{'project_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="element_id" value="$Launchleader::fund_disbursed->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Fund amount: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_amount" value="$Launchleader::fund_disbursed->{'fund_amount'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="disburse_status" value="$Launchleader::fund_disbursed->{'disburse_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Application fee: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="application_fee" value="$Launchleader::fund_disbursed->{'application_fee'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse token: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="disburse_token" value="$Launchleader::fund_disbursed->{'disburse_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funding details id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="funding_details_id" value="$Launchleader::fund_disbursed->{'funding_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_status" value="$Launchleader::fund_disbursed->{'fund_disbursed_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="fund_disbursed_datetime" value="$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}">
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
	<FORM ACTION="$Launchleader::FUND_DISBURSED_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_id'}</B>
		<INPUT TYPE="hidden" NAME="fund_disbursed_id" value="$Launchleader::fund_disbursed->{'fund_disbursed_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::fund_disbursed->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::fund_disbursed->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Project id: &nbsp; <B>$Launchleader::fund_disbursed->{'project_id'}</B>
		<INPUT TYPE="hidden" NAME="project_id" value="$Launchleader::fund_disbursed->{'project_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Element id: &nbsp; <B>$Launchleader::fund_disbursed->{'element_id'}</B>
		<INPUT TYPE="hidden" NAME="element_id" value="$Launchleader::fund_disbursed->{'element_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Fund amount: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_amount'}</B>
		<INPUT TYPE="hidden" NAME="fund_amount" value="$Launchleader::fund_disbursed->{'fund_amount'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse status: &nbsp; <B>$Launchleader::fund_disbursed->{'disburse_status'}</B>
		<INPUT TYPE="hidden" NAME="disburse_status" value="$Launchleader::fund_disbursed->{'disburse_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Application fee: &nbsp; <B>$Launchleader::fund_disbursed->{'application_fee'}</B>
		<INPUT TYPE="hidden" NAME="application_fee" value="$Launchleader::fund_disbursed->{'application_fee'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Disburse token: &nbsp; <B>$Launchleader::fund_disbursed->{'disburse_token'}</B>
		<INPUT TYPE="hidden" NAME="disburse_token" value="$Launchleader::fund_disbursed->{'disburse_token'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Funding details id: &nbsp; <B>$Launchleader::fund_disbursed->{'funding_details_id'}</B>
		<INPUT TYPE="hidden" NAME="funding_details_id" value="$Launchleader::fund_disbursed->{'funding_details_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_status'}</B>
		<INPUT TYPE="hidden" NAME="fund_disbursed_status" value="$Launchleader::fund_disbursed->{'fund_disbursed_status'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Datetime: &nbsp; <B>$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}</B>
		<INPUT TYPE="hidden" NAME="fund_disbursed_datetime" value="$Launchleader::fund_disbursed->{'fund_disbursed_datetime'}">
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
#		if($Launchleader::fund_disbursed->{'fund_disbursed_id'} eq "" || ($Launchleader::fund_disbursed->{'fund_disbursed_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'account_id'} eq "" || ($Launchleader::fund_disbursed->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'project_id'} eq "" || ($Launchleader::fund_disbursed->{'project_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Project id<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'element_id'} eq "" || ($Launchleader::fund_disbursed->{'element_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Element id<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'fund_amount'} eq "" || ($Launchleader::fund_disbursed->{'fund_amount'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Fund amount<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'disburse_status'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Disburse status<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'application_fee'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Application fee<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'disburse_token'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Disburse token<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'funding_details_id'} eq "" || ($Launchleader::fund_disbursed->{'funding_details_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Funding details id<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'fund_disbursed_status'} eq "" || ($Launchleader::fund_disbursed->{'fund_disbursed_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}
#		if($Launchleader::fund_disbursed->{'fund_disbursed_datetime'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Datetime<BR>";
#		return 0;
#		}


return 1;
}

 
  
