#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_inbox();
&Launchh::select_inbox($Launchh::inbox->{'inbox_id'}) if($Launchh::inbox->{'inbox_id'});
&Launchh::read_inbox() if($stage>=2 && $mode eq "edit");


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
	   &Launchh::delete_inbox($Launchh::inbox->{'inbox_id'});
	}
	else
	{
	   if( !$Launchh::inbox->{'inbox_id'})
	   {
		&Launchh::insert_inbox();
	   }
	   else
	   {
		&Launchh::update_inbox();
	   }
	}



   print "Location: $Launchh::INBOXS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::inbox->{'inbox_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account to: &nbsp; <B>$Launchh::inbox->{'account_to'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account from: &nbsp; <B>$Launchh::inbox->{'account_from'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Name: &nbsp; <B>$Launchh::inbox->{'inbox_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Desc: &nbsp; <B>$Launchh::inbox->{'inbox_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Note: &nbsp; <B>$Launchh::inbox->{'inbox_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Date: &nbsp; <B>$Launchh::inbox->{'inbox_date'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Type: &nbsp; <B>$Launchh::inbox->{'inbox_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::inbox->{'inbox_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::INBOXS_CGI">
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
	<FORM ACTION="$Launchh::INBOX_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_id" value="$Launchh::inbox->{'inbox_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account to: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_to" value="$Launchh::inbox->{'account_to'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account from: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_from" value="$Launchh::inbox->{'account_from'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_name" value="$Launchh::inbox->{'inbox_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="inbox_desc" ROWS="10" COLS="50">$Launchh::inbox->{'inbox_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="inbox_note" ROWS="10" COLS="50">$Launchh::inbox->{'inbox_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Date: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_date" value="$Launchh::inbox->{'inbox_date'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_type" value="$Launchh::inbox->{'inbox_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="inbox_status" value="$Launchh::inbox->{'inbox_status'}">
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
	<FORM ACTION="$Launchh::INBOX_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::inbox->{'inbox_id'}</B>
		<INPUT TYPE="hidden" NAME="inbox_id" value="$Launchh::inbox->{'inbox_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account to: &nbsp; <B>$Launchh::inbox->{'account_to'}</B>
		<INPUT TYPE="hidden" NAME="account_to" value="$Launchh::inbox->{'account_to'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account from: &nbsp; <B>$Launchh::inbox->{'account_from'}</B>
		<INPUT TYPE="hidden" NAME="account_from" value="$Launchh::inbox->{'account_from'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; <B>$Launchh::inbox->{'inbox_name'}</B>
		<INPUT TYPE="hidden" NAME="inbox_name" value="$Launchh::inbox->{'inbox_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; <B>$Launchh::inbox->{'inbox_desc'}</B>
		<INPUT TYPE="hidden" NAME="inbox_desc" value="$Launchh::inbox->{'inbox_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; <B>$Launchh::inbox->{'inbox_note'}</B>
		<INPUT TYPE="hidden" NAME="inbox_note" value="$Launchh::inbox->{'inbox_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Date: &nbsp; <B>$Launchh::inbox->{'inbox_date'}</B>
		<INPUT TYPE="hidden" NAME="inbox_date" value="$Launchh::inbox->{'inbox_date'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; <B>$Launchh::inbox->{'inbox_type'}</B>
		<INPUT TYPE="hidden" NAME="inbox_type" value="$Launchh::inbox->{'inbox_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::inbox->{'inbox_status'}</B>
		<INPUT TYPE="hidden" NAME="inbox_status" value="$Launchh::inbox->{'inbox_status'}">
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
#		if($Launchh::inbox->{'inbox_id'} eq "" || ($Launchh::inbox->{'inbox_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'account_to'} eq "" || ($Launchh::inbox->{'account_to'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account to<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'account_from'} eq "" || ($Launchh::inbox->{'account_from'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account from<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_name'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_desc'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_note'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_date'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Date<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_type'} eq "" || ($Launchh::inbox->{'inbox_type'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchh::inbox->{'inbox_status'} eq "" || ($Launchh::inbox->{'inbox_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
