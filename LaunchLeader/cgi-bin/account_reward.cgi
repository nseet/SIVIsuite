#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_account_reward();
&Launchh::select_account_reward($Launchh::account_reward->{'account_reward_id'}) if($Launchh::account_reward->{'account_reward_id'});
&Launchh::read_account_reward() if($stage>=2 && $mode eq "edit");


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
	   &Launchh::delete_account_reward($Launchh::account_reward->{'account_reward_id'});
	}
	else
	{
	   if( !$Launchh::account_reward->{'account_reward_id'})
	   {
		&Launchh::insert_account_reward();
	   }
	   else
	   {
		&Launchh::update_account_reward();
	   }
	}



   print "Location: $Launchh::ACCOUNT_REWARDS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::account_reward->{'account_reward_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Account id: &nbsp; <B>$Launchh::account_reward->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Reward id: &nbsp; <B>$Launchh::account_reward->{'reward_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Added: &nbsp; <B>$Launchh::account_reward->{'account_reward_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::account_reward->{'account_reward_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::ACCOUNT_REWARDS_CGI">
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
	<FORM ACTION="$Launchh::ACCOUNT_REWARD_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_reward_id" value="$Launchh::account_reward->{'account_reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchh::account_reward->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Reward id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_id" value="$Launchh::account_reward->{'reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_reward_added" value="$Launchh::account_reward->{'account_reward_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_reward_status" value="$Launchh::account_reward->{'account_reward_status'}">
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
	<FORM ACTION="$Launchh::ACCOUNT_REWARD_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::account_reward->{'account_reward_id'}</B>
		<INPUT TYPE="hidden" NAME="account_reward_id" value="$Launchh::account_reward->{'account_reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Account id: &nbsp; <B>$Launchh::account_reward->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchh::account_reward->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Reward id: &nbsp; <B>$Launchh::account_reward->{'reward_id'}</B>
		<INPUT TYPE="hidden" NAME="reward_id" value="$Launchh::account_reward->{'reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; <B>$Launchh::account_reward->{'account_reward_added'}</B>
		<INPUT TYPE="hidden" NAME="account_reward_added" value="$Launchh::account_reward->{'account_reward_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::account_reward->{'account_reward_status'}</B>
		<INPUT TYPE="hidden" NAME="account_reward_status" value="$Launchh::account_reward->{'account_reward_status'}">
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
#		if($Launchh::account_reward->{'account_reward_id'} eq "" || ($Launchh::account_reward->{'account_reward_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::account_reward->{'account_id'} eq "" || ($Launchh::account_reward->{'account_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchh::account_reward->{'reward_id'} eq "" || ($Launchh::account_reward->{'reward_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Reward id<BR>";
#		return 0;
#		}
#		if($Launchh::account_reward->{'account_reward_added'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchh::account_reward->{'account_reward_status'} eq "" || ($Launchh::account_reward->{'account_reward_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
