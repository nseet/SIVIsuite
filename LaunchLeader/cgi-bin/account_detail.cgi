#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_account_detail();
&Launchh::select_account_detail($Launchh::account_detail->{'account_detail_id'}) if($Launchh::account_detail->{'account_detail_id'});
&Launchh::read_account_detail() if($stage>=2 && $mode eq "edit");


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
	   &Launchh::delete_account_detail($Launchh::account_detail->{'account_detail_id'});
	}
	else
	{
	   if( !$Launchh::account_detail->{'account_detail_id'})
	   {
		&Launchh::insert_account_detail();
	   }
	   else
	   {
		&Launchh::update_account_detail();
	   }
	}



   print "Location: $Launchh::ACCOUNT_DETAILS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::account_detail->{'account_detail_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Detail id: &nbsp; <B>$Launchh::account_detail->{'detail_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account id: &nbsp; <B>$Launchh::account_detail->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Name: &nbsp; <B>$Launchh::account_detail->{'account_detail_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Desc: &nbsp; <B>$Launchh::account_detail->{'account_detail_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Note: &nbsp; <B>$Launchh::account_detail->{'account_detail_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Type: &nbsp; <B>$Launchh::account_detail->{'account_detail_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::account_detail->{'account_detail_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::ACCOUNT_DETAILS_CGI">
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
	<FORM ACTION="$Launchh::ACCOUNT_DETAIL_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_detail_id" value="$Launchh::account_detail->{'account_detail_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Detail id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="detail_id" value="$Launchh::account_detail->{'detail_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchh::account_detail->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_detail_name" value="$Launchh::account_detail->{'account_detail_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_detail_desc" ROWS="10" COLS="50">$Launchh::account_detail->{'account_detail_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="account_detail_note" ROWS="10" COLS="50">$Launchh::account_detail->{'account_detail_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_detail_type" value="$Launchh::account_detail->{'account_detail_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_detail_status" value="$Launchh::account_detail->{'account_detail_status'}">
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
	<FORM ACTION="$Launchh::ACCOUNT_DETAIL_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::account_detail->{'account_detail_id'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_id" value="$Launchh::account_detail->{'account_detail_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Detail id: &nbsp; <B>$Launchh::account_detail->{'detail_id'}</B>
		<INPUT TYPE="hidden" NAME="detail_id" value="$Launchh::account_detail->{'detail_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; <B>$Launchh::account_detail->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchh::account_detail->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; <B>$Launchh::account_detail->{'account_detail_name'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_name" value="$Launchh::account_detail->{'account_detail_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; <B>$Launchh::account_detail->{'account_detail_desc'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_desc" value="$Launchh::account_detail->{'account_detail_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; <B>$Launchh::account_detail->{'account_detail_note'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_note" value="$Launchh::account_detail->{'account_detail_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; <B>$Launchh::account_detail->{'account_detail_type'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_type" value="$Launchh::account_detail->{'account_detail_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::account_detail->{'account_detail_status'}</B>
		<INPUT TYPE="hidden" NAME="account_detail_status" value="$Launchh::account_detail->{'account_detail_status'}">
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
#		if($Launchh::account_detail->{'account_detail_id'} eq "" || ($Launchh::account_detail->{'account_detail_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'detail_id'} eq "" || ($Launchh::account_detail->{'detail_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Detail id<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_id'} eq "" || ($Launchh::account_detail->{'account_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_detail_name'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_detail_desc'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_detail_note'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_detail_type'} eq "" || ($Launchh::account_detail->{'account_detail_type'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchh::account_detail->{'account_detail_status'} eq "" || ($Launchh::account_detail->{'account_detail_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
