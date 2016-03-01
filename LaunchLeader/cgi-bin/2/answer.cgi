#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_answer();
&Launchleader::select_answer($Launchleader::answer->{'answer_id'}) if($Launchleader::answer->{'answer_id'});
&Launchleader::read_answer() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_answer($Launchleader::answer->{'answer_id'});
	}
	else
	{
	   if( !$Launchleader::answer->{'answer_id'})
	   {
		&Launchleader::insert_answer();
	   }
	   else
	   {
		&Launchleader::update_answer();
	   }
	}



   print "Location: $Launchleader::ANSWERS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::answer->{'answer_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Question id: &nbsp; <B>$Launchleader::answer->{'question_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Account id: &nbsp; <B>$Launchleader::answer->{'account_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::answer->{'answer_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Wiki: &nbsp; <B>$Launchleader::answer->{'answer_wiki'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Img: &nbsp; <B>$Launchleader::answer->{'answer_img'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Url: &nbsp; <B>$Launchleader::answer->{'answer_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Desc: &nbsp; <B>$Launchleader::answer->{'answer_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::answer->{'answer_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Added: &nbsp; <B>$Launchleader::answer->{'answer_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Ended: &nbsp; <B>$Launchleader::answer->{'answer_ended'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::answer->{'answer_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::answer->{'answer_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::ANSWERS_CGI">
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
	<FORM ACTION="$Launchleader::ANSWER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_id" value="$Launchleader::answer->{'answer_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Question id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_id" value="$Launchleader::answer->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="account_id" value="$Launchleader::answer->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_name" value="$Launchleader::answer->{'answer_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Wiki: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_wiki" value="$Launchleader::answer->{'answer_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Img: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_img" value="$Launchleader::answer->{'answer_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_url" value="$Launchleader::answer->{'answer_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="answer_desc" ROWS="10" COLS="50">$Launchleader::answer->{'answer_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="answer_note" ROWS="10" COLS="50">$Launchleader::answer->{'answer_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_added" value="$Launchleader::answer->{'answer_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ended: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_ended" value="$Launchleader::answer->{'answer_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_type" value="$Launchleader::answer->{'answer_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="answer_status" value="$Launchleader::answer->{'answer_status'}">
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
	<FORM ACTION="$Launchleader::ANSWER_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::answer->{'answer_id'}</B>
		<INPUT TYPE="hidden" NAME="answer_id" value="$Launchleader::answer->{'answer_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Question id: &nbsp; <B>$Launchleader::answer->{'question_id'}</B>
		<INPUT TYPE="hidden" NAME="question_id" value="$Launchleader::answer->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Account id: &nbsp; <B>$Launchleader::answer->{'account_id'}</B>
		<INPUT TYPE="hidden" NAME="account_id" value="$Launchleader::answer->{'account_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::answer->{'answer_name'}</B>
		<INPUT TYPE="hidden" NAME="answer_name" value="$Launchleader::answer->{'answer_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Wiki: &nbsp; <B>$Launchleader::answer->{'answer_wiki'}</B>
		<INPUT TYPE="hidden" NAME="answer_wiki" value="$Launchleader::answer->{'answer_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Img: &nbsp; <B>$Launchleader::answer->{'answer_img'}</B>
		<INPUT TYPE="hidden" NAME="answer_img" value="$Launchleader::answer->{'answer_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; <B>$Launchleader::answer->{'answer_url'}</B>
		<INPUT TYPE="hidden" NAME="answer_url" value="$Launchleader::answer->{'answer_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; <B>$Launchleader::answer->{'answer_desc'}</B>
		<INPUT TYPE="hidden" NAME="answer_desc" value="$Launchleader::answer->{'answer_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::answer->{'answer_note'}</B>
		<INPUT TYPE="hidden" NAME="answer_note" value="$Launchleader::answer->{'answer_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; <B>$Launchleader::answer->{'answer_added'}</B>
		<INPUT TYPE="hidden" NAME="answer_added" value="$Launchleader::answer->{'answer_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ended: &nbsp; <B>$Launchleader::answer->{'answer_ended'}</B>
		<INPUT TYPE="hidden" NAME="answer_ended" value="$Launchleader::answer->{'answer_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::answer->{'answer_type'}</B>
		<INPUT TYPE="hidden" NAME="answer_type" value="$Launchleader::answer->{'answer_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::answer->{'answer_status'}</B>
		<INPUT TYPE="hidden" NAME="answer_status" value="$Launchleader::answer->{'answer_status'}">
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
#		if($Launchleader::answer->{'answer_id'} eq "" || ($Launchleader::answer->{'answer_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'question_id'} eq "" || ($Launchleader::answer->{'question_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Question id<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'account_id'} eq "" || ($Launchleader::answer->{'account_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Account id<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_wiki'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Wiki<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_img'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Img<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_url'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_desc'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_added'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_ended'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Ended<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_type'} eq "" || ($Launchleader::answer->{'answer_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::answer->{'answer_status'} eq "" || ($Launchleader::answer->{'answer_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
