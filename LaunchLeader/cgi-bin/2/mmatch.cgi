#!/usr/bin/perl

use lib '..';
use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_mmatch();
&Launchleader::select_mmatch($Launchleader::mmatch->{'mmatch_id'}) if($Launchleader::mmatch->{'mmatch_id'});
&Launchleader::read_mmatch() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_mmatch($Launchleader::mmatch->{'mmatch_id'});
	}
	else
	{
	   if( !$Launchleader::mmatch->{'mmatch_id'})
	   {
		&Launchleader::insert_mmatch();
	   }
	   else
	   {
		&Launchleader::update_mmatch();
	   }
	}



   print "Location: $Launchleader::MMATCHS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::mmatch->{'mmatch_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::mmatch->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::mmatch->{'mmatch_account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Score: &nbsp; <B>$Launchleader::mmatch->{'mmatch_score'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::mmatch->{'mmatch_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Made: &nbsp; <B>$Launchleader::mmatch->{'mmatch_made'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Notified: &nbsp; <B>$Launchleader::mmatch->{'mmatch_notified'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Contacted: &nbsp; <B>$Launchleader::mmatch->{'mmatch_contacted'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Expires: &nbsp; <B>$Launchleader::mmatch->{'mmatch_expires'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::mmatch->{'mmatch_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::mmatch->{'mmatch_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::MMATCHS_CGI">
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
	<FORM ACTION="$Launchleader::MMATCH_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_id" value="$Launchleader::mmatch->{'mmatch_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::mmatch->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_account_id" value="$Launchleader::mmatch->{'mmatch_account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Score: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_score" value="$Launchleader::mmatch->{'mmatch_score'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="mmatch_note" ROWS="10" COLS="50">$Launchleader::mmatch->{'mmatch_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Made: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_made" value="$Launchleader::mmatch->{'mmatch_made'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Notified: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_notified" value="$Launchleader::mmatch->{'mmatch_notified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Contacted: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_contacted" value="$Launchleader::mmatch->{'mmatch_contacted'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Expires: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_expires" value="$Launchleader::mmatch->{'mmatch_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_type" value="$Launchleader::mmatch->{'mmatch_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_status" value="$Launchleader::mmatch->{'mmatch_status'}">
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
	<FORM ACTION="$Launchleader::MMATCH_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::mmatch->{'mmatch_id'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_id" value="$Launchleader::mmatch->{'mmatch_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::mmatch->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::mmatch->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::mmatch->{'mmatch_account_id'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_account_id" value="$Launchleader::mmatch->{'mmatch_account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Score: &nbsp; <B>$Launchleader::mmatch->{'mmatch_score'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_score" value="$Launchleader::mmatch->{'mmatch_score'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::mmatch->{'mmatch_note'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_note" value="$Launchleader::mmatch->{'mmatch_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Made: &nbsp; <B>$Launchleader::mmatch->{'mmatch_made'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_made" value="$Launchleader::mmatch->{'mmatch_made'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Notified: &nbsp; <B>$Launchleader::mmatch->{'mmatch_notified'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_notified" value="$Launchleader::mmatch->{'mmatch_notified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Contacted: &nbsp; <B>$Launchleader::mmatch->{'mmatch_contacted'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_contacted" value="$Launchleader::mmatch->{'mmatch_contacted'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Expires: &nbsp; <B>$Launchleader::mmatch->{'mmatch_expires'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_expires" value="$Launchleader::mmatch->{'mmatch_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::mmatch->{'mmatch_type'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_type" value="$Launchleader::mmatch->{'mmatch_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::mmatch->{'mmatch_status'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_status" value="$Launchleader::mmatch->{'mmatch_status'}">
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
#		if($Launchleader::mmatch->{'mmatch_id'} eq "" || ($Launchleader::mmatch->{'mmatch_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'account_id'} eq "" || ($Launchleader::mmatch->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_account_id'} eq "" || ($Launchleader::mmatch->{'mmatch_account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_score'} eq "" || ($Launchleader::mmatch->{'mmatch_score'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Score<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_made'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Made<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_notified'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Notified<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_contacted'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Contacted<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_expires'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Expires<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_type'} eq "" || ($Launchleader::mmatch->{'mmatch_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::mmatch->{'mmatch_status'} eq "" || ($Launchleader::mmatch->{'mmatch_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
