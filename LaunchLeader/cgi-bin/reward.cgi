#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_reward();
&Launchh::select_reward($Launchh::reward->{'reward_id'}) if($Launchh::reward->{'reward_id'});
&Launchh::read_reward() if($stage>=2 && $mode eq "edit");


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
	   &Launchh::delete_reward($Launchh::reward->{'reward_id'});
	}
	else
	{
	   if( !$Launchh::reward->{'reward_id'})
	   {
		&Launchh::insert_reward();
	   }
	   else
	   {
		&Launchh::update_reward();
	   }
	}



   print "Location: $Launchh::REWARDS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::reward->{'reward_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Name: &nbsp; <B>$Launchh::reward->{'reward_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Desc: &nbsp; <B>$Launchh::reward->{'reward_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Note: &nbsp; <B>$Launchh::reward->{'reward_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 By: &nbsp; <B>$Launchh::reward->{'reward_by'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Url: &nbsp; <B>$Launchh::reward->{'reward_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Category: &nbsp; <B>$Launchh::reward->{'reward_category'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Points: &nbsp; <B>$Launchh::reward->{'reward_points'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Value: &nbsp; <B>$Launchh::reward->{'reward_value'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Added: &nbsp; <B>$Launchh::reward->{'reward_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Expires: &nbsp; <B>$Launchh::reward->{'reward_expires'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Type: &nbsp; <B>$Launchh::reward->{'reward_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::reward->{'reward_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::REWARDS_CGI">
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
	<FORM ACTION="$Launchh::REWARD_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_id" value="$Launchh::reward->{'reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_name" value="$Launchh::reward->{'reward_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="reward_desc" ROWS="10" COLS="50">$Launchh::reward->{'reward_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="reward_note" ROWS="10" COLS="50">$Launchh::reward->{'reward_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		By: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_by" value="$Launchh::reward->{'reward_by'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_url" value="$Launchh::reward->{'reward_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Category: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_category" value="$Launchh::reward->{'reward_category'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Points: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_points" value="$Launchh::reward->{'reward_points'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Value: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_value" value="$Launchh::reward->{'reward_value'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_added" value="$Launchh::reward->{'reward_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Expires: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_expires" value="$Launchh::reward->{'reward_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_type" value="$Launchh::reward->{'reward_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="reward_status" value="$Launchh::reward->{'reward_status'}">
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
	<FORM ACTION="$Launchh::REWARD_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::reward->{'reward_id'}</B>
		<INPUT TYPE="hidden" NAME="reward_id" value="$Launchh::reward->{'reward_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; <B>$Launchh::reward->{'reward_name'}</B>
		<INPUT TYPE="hidden" NAME="reward_name" value="$Launchh::reward->{'reward_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; <B>$Launchh::reward->{'reward_desc'}</B>
		<INPUT TYPE="hidden" NAME="reward_desc" value="$Launchh::reward->{'reward_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; <B>$Launchh::reward->{'reward_note'}</B>
		<INPUT TYPE="hidden" NAME="reward_note" value="$Launchh::reward->{'reward_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		By: &nbsp; <B>$Launchh::reward->{'reward_by'}</B>
		<INPUT TYPE="hidden" NAME="reward_by" value="$Launchh::reward->{'reward_by'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; <B>$Launchh::reward->{'reward_url'}</B>
		<INPUT TYPE="hidden" NAME="reward_url" value="$Launchh::reward->{'reward_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Category: &nbsp; <B>$Launchh::reward->{'reward_category'}</B>
		<INPUT TYPE="hidden" NAME="reward_category" value="$Launchh::reward->{'reward_category'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Points: &nbsp; <B>$Launchh::reward->{'reward_points'}</B>
		<INPUT TYPE="hidden" NAME="reward_points" value="$Launchh::reward->{'reward_points'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Value: &nbsp; <B>$Launchh::reward->{'reward_value'}</B>
		<INPUT TYPE="hidden" NAME="reward_value" value="$Launchh::reward->{'reward_value'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; <B>$Launchh::reward->{'reward_added'}</B>
		<INPUT TYPE="hidden" NAME="reward_added" value="$Launchh::reward->{'reward_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Expires: &nbsp; <B>$Launchh::reward->{'reward_expires'}</B>
		<INPUT TYPE="hidden" NAME="reward_expires" value="$Launchh::reward->{'reward_expires'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; <B>$Launchh::reward->{'reward_type'}</B>
		<INPUT TYPE="hidden" NAME="reward_type" value="$Launchh::reward->{'reward_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::reward->{'reward_status'}</B>
		<INPUT TYPE="hidden" NAME="reward_status" value="$Launchh::reward->{'reward_status'}">
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
#		if($Launchh::reward->{'reward_id'} eq "" || ($Launchh::reward->{'reward_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_name'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_desc'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_note'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_by'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid By<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_url'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_category'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Category<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_points'} eq "" || ($Launchh::reward->{'reward_points'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Points<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_value'} eq "" || ($Launchh::reward->{'reward_value'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Value<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_added'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_expires'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Expires<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_type'} eq "" || ($Launchh::reward->{'reward_type'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchh::reward->{'reward_status'} eq "" || ($Launchh::reward->{'reward_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
