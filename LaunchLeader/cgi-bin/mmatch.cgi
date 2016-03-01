#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_mmatch();
&Launchh::select_mmatch($Launchh::mmatch->{'mmatch_id'}) if($Launchh::mmatch->{'mmatch_id'});
&Launchh::read_mmatch() if($stage>=2 && $mode eq "edit");


if($stage==0) #View mode
{
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage0();
   print &Launchh::html_footer($Launchh::HFILE);
}
elsif($stage == 1 || !verify_stage1()) 
{
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage1();
   print &Launchh::html_footer($Launchh::HFILE);
}
elsif($stage==2)
{	
   print $Launchh::_query->header();
   print &Launchh::html_header($Launchh::HFILE);
   print html_stage2();
   print &Launchh::html_footer($Launchh::HFILE);

}
elsif($stage==3)
{
	if($mode eq "delete")
	{
	   &Launchh::delete_mmatch($Launchh::mmatch->{'mmatch_id'});
	}
	else
	{
	   if( !$Launchh::mmatch->{'mmatch_id'})
	   {
		&Launchh::insert_mmatch();
	   }
	   else
	   {
		&Launchh::update_mmatch();
	   }
	}



   print "Location: $Launchh::MMATCHS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::mmatch->{'mmatch_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account id: &nbsp; <B>$Launchh::mmatch->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account id: &nbsp; <B>$Launchh::mmatch->{'mmatch_account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Score: &nbsp; <B>$Launchh::mmatch->{'mmatch_score'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Note: &nbsp; <B>$Launchh::mmatch->{'mmatch_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Made: &nbsp; <B>$Launchh::mmatch->{'mmatch_made'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Notified: &nbsp; <B>$Launchh::mmatch->{'mmatch_notified'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Contacted: &nbsp; <B>$Launchh::mmatch->{'mmatch_contacted'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Expires: &nbsp; <B>$Launchh::mmatch->{'mmatch_expires'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Type: &nbsp; <B>$Launchh::mmatch->{'mmatch_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::mmatch->{'mmatch_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::MMATCHS_CGI">
        $Launchh::HIDDEN
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
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">
   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE" COLOR="red">
        $Launchh::ERROR 
        </FONT>
        </TD>
   </TR>
   <TR>
	<TD>
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<FORM ACTION="$Launchh::MMATCH_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_id" value="$Launchh::mmatch->{'mmatch_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchh::mmatch->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_account_id" value="$Launchh::mmatch->{'mmatch_account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Score: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_score" value="$Launchh::mmatch->{'mmatch_score'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="mmatch_note" ROWS="10" COLS="50">$Launchh::mmatch->{'mmatch_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Made: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_made" value="$Launchh::mmatch->{'mmatch_made'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Notified: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_notified" value="$Launchh::mmatch->{'mmatch_notified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Contacted: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_contacted" value="$Launchh::mmatch->{'mmatch_contacted'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Expires: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_expires" value="$Launchh::mmatch->{'mmatch_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_type" value="$Launchh::mmatch->{'mmatch_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="mmatch_status" value="$Launchh::mmatch->{'mmatch_status'}">
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
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">
   <TR>
	<TD>
	<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
	<FORM ACTION="$Launchh::MMATCH_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::mmatch->{'mmatch_id'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_id" value="$Launchh::mmatch->{'mmatch_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; <B>$Launchh::mmatch->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchh::mmatch->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; <B>$Launchh::mmatch->{'mmatch_account_id'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_account_id" value="$Launchh::mmatch->{'mmatch_account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Score: &nbsp; <B>$Launchh::mmatch->{'mmatch_score'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_score" value="$Launchh::mmatch->{'mmatch_score'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; <B>$Launchh::mmatch->{'mmatch_note'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_note" value="$Launchh::mmatch->{'mmatch_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Made: &nbsp; <B>$Launchh::mmatch->{'mmatch_made'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_made" value="$Launchh::mmatch->{'mmatch_made'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Notified: &nbsp; <B>$Launchh::mmatch->{'mmatch_notified'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_notified" value="$Launchh::mmatch->{'mmatch_notified'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Contacted: &nbsp; <B>$Launchh::mmatch->{'mmatch_contacted'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_contacted" value="$Launchh::mmatch->{'mmatch_contacted'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Expires: &nbsp; <B>$Launchh::mmatch->{'mmatch_expires'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_expires" value="$Launchh::mmatch->{'mmatch_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; <B>$Launchh::mmatch->{'mmatch_type'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_type" value="$Launchh::mmatch->{'mmatch_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::mmatch->{'mmatch_status'}</B>
		<INPUT TYPE="hidden" NAME="mmatch_status" value="$Launchh::mmatch->{'mmatch_status'}">
		</FONT></TD></TR>

		<TR><TD>
		<FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
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
#		if($Launchh::mmatch->{'mmatch_id'} eq "" || ($Launchh::mmatch->{'mmatch_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'account_id'} eq "" || ($Launchh::mmatch->{'account_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_account_id'} eq "" || ($Launchh::mmatch->{'mmatch_account_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_score'} eq "" || ($Launchh::mmatch->{'mmatch_score'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Score<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_note'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_made'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Made<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_notified'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Notified<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_contacted'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Contacted<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_expires'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Expires<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_type'} eq "" || ($Launchh::mmatch->{'mmatch_type'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchh::mmatch->{'mmatch_status'} eq "" || ($Launchh::mmatch->{'mmatch_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
