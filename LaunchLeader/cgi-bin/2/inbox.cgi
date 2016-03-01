#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_inbox();
&Launchleader::select_inbox($Launchleader::inbox->{'inbox_id'}) if($Launchleader::inbox->{'inbox_id'});
&Launchleader::read_inbox() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_inbox($Launchleader::inbox->{'inbox_id'});
	}
	else
	{
	   if( !$Launchleader::inbox->{'inbox_id'})
	   {
		&Launchleader::insert_inbox();
	   }
	   else
	   {
		&Launchleader::update_inbox();
	   }
	}



   print "Location: $Launchleader::INBOXS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::inbox->{'inbox_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account to: &nbsp; <B>$Launchleader::inbox->{'account_to'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account from: &nbsp; <B>$Launchleader::inbox->{'account_from'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::inbox->{'inbox_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Desc: &nbsp; <B>$Launchleader::inbox->{'inbox_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::inbox->{'inbox_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Date: &nbsp; <B>$Launchleader::inbox->{'inbox_date'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::inbox->{'inbox_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::inbox->{'inbox_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::INBOXS_CGI">
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
	<FORM ACTION="$Launchleader::INBOX_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_id" value="$Launchleader::inbox->{'inbox_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account to: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_to" value="$Launchleader::inbox->{'account_to'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account from: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_from" value="$Launchleader::inbox->{'account_from'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_name" value="$Launchleader::inbox->{'inbox_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="inbox_desc" ROWS="10" COLS="50">$Launchleader::inbox->{'inbox_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="inbox_note" ROWS="10" COLS="50">$Launchleader::inbox->{'inbox_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Date: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_date" value="$Launchleader::inbox->{'inbox_date'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_type" value="$Launchleader::inbox->{'inbox_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_status" value="$Launchleader::inbox->{'inbox_status'}">
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
	<FORM ACTION="$Launchleader::INBOX_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::inbox->{'inbox_id'}</B>
		<INPUT TYPE="hidden" NAME="inbox_id" value="$Launchleader::inbox->{'inbox_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account to: &nbsp; <B>$Launchleader::inbox->{'account_to'}</B>
		<INPUT TYPE="hidden" NAME="account_to" value="$Launchleader::inbox->{'account_to'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account from: &nbsp; <B>$Launchleader::inbox->{'account_from'}</B>
		<INPUT TYPE="hidden" NAME="account_from" value="$Launchleader::inbox->{'account_from'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::inbox->{'inbox_name'}</B>
		<INPUT TYPE="hidden" NAME="inbox_name" value="$Launchleader::inbox->{'inbox_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; <B>$Launchleader::inbox->{'inbox_desc'}</B>
		<INPUT TYPE="hidden" NAME="inbox_desc" value="$Launchleader::inbox->{'inbox_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::inbox->{'inbox_note'}</B>
		<INPUT TYPE="hidden" NAME="inbox_note" value="$Launchleader::inbox->{'inbox_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Date: &nbsp; <B>$Launchleader::inbox->{'inbox_date'}</B>
		<INPUT TYPE="hidden" NAME="inbox_date" value="$Launchleader::inbox->{'inbox_date'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::inbox->{'inbox_type'}</B>
		<INPUT TYPE="hidden" NAME="inbox_type" value="$Launchleader::inbox->{'inbox_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::inbox->{'inbox_status'}</B>
		<INPUT TYPE="hidden" NAME="inbox_status" value="$Launchleader::inbox->{'inbox_status'}">
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
#		if($Launchleader::inbox->{'inbox_id'} eq "" || ($Launchleader::inbox->{'inbox_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'account_to'} eq "" || ($Launchleader::inbox->{'account_to'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account to<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'account_from'} eq "" || ($Launchleader::inbox->{'account_from'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account from<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_desc'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_date'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Date<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_type'} eq "" || ($Launchleader::inbox->{'inbox_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::inbox->{'inbox_status'} eq "" || ($Launchleader::inbox->{'inbox_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
