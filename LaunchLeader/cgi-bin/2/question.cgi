#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);

&Launchleader::read_question();
&Launchleader::select_question($Launchleader::question->{'question_id'}) if($Launchleader::question->{'question_id'});
&Launchleader::read_question() if($stage>=2 && $mode eq "edit");


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
	   &Launchleader::delete_question($Launchleader::question->{'question_id'});
	}
	else
	{
	   if( !$Launchleader::question->{'question_id'})
	   {
		&Launchleader::insert_question();
	   }
	   else
	   {
		&Launchleader::update_question();
	   }
	}



   print "Location: $Launchleader::QUESTIONS_CGI?$Launchleader::HSTR&stage=2\n\n";
}

&Launchleader::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchleader::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Id: &nbsp; <B>$Launchleader::question->{'question_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Category id: &nbsp; <B>$Launchleader::question->{'category_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Name: &nbsp; <B>$Launchleader::question->{'question_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Wiki: &nbsp; <B>$Launchleader::question->{'question_wiki'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Img: &nbsp; <B>$Launchleader::question->{'question_img'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Url: &nbsp; <B>$Launchleader::question->{'question_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Desc: &nbsp; <B>$Launchleader::question->{'question_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Note: &nbsp; <B>$Launchleader::question->{'question_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Added: &nbsp; <B>$Launchleader::question->{'question_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Ended: &nbsp; <B>$Launchleader::question->{'question_ended'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Type: &nbsp; <B>$Launchleader::question->{'question_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Limit: &nbsp; <B>$Launchleader::question->{'question_limit'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
                 Status: &nbsp; <B>$Launchleader::question->{'question_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
 
        <FORM ACTION="$Launchleader::QUESTIONS_CGI">
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
	<FORM ACTION="$Launchleader::QUESTION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_id" value="$Launchleader::question->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Category id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="category_id" value="$Launchleader::question->{'category_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_name" value="$Launchleader::question->{'question_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Wiki: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_wiki" value="$Launchleader::question->{'question_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Img: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_img" value="$Launchleader::question->{'question_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_url" value="$Launchleader::question->{'question_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="question_desc" ROWS="10" COLS="50">$Launchleader::question->{'question_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="question_note" ROWS="10" COLS="50">$Launchleader::question->{'question_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_added" value="$Launchleader::question->{'question_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ended: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_ended" value="$Launchleader::question->{'question_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_type" value="$Launchleader::question->{'question_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Limit: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_limit" value="$Launchleader::question->{'question_limit'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_status" value="$Launchleader::question->{'question_status'}">
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
	<FORM ACTION="$Launchleader::QUESTION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchleader::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Id: &nbsp; <B>$Launchleader::question->{'question_id'}</B>
		<INPUT TYPE="hidden" NAME="question_id" value="$Launchleader::question->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Category id: &nbsp; <B>$Launchleader::question->{'category_id'}</B>
		<INPUT TYPE="hidden" NAME="category_id" value="$Launchleader::question->{'category_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Name: &nbsp; <B>$Launchleader::question->{'question_name'}</B>
		<INPUT TYPE="hidden" NAME="question_name" value="$Launchleader::question->{'question_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Wiki: &nbsp; <B>$Launchleader::question->{'question_wiki'}</B>
		<INPUT TYPE="hidden" NAME="question_wiki" value="$Launchleader::question->{'question_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Img: &nbsp; <B>$Launchleader::question->{'question_img'}</B>
		<INPUT TYPE="hidden" NAME="question_img" value="$Launchleader::question->{'question_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Url: &nbsp; <B>$Launchleader::question->{'question_url'}</B>
		<INPUT TYPE="hidden" NAME="question_url" value="$Launchleader::question->{'question_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Desc: &nbsp; <B>$Launchleader::question->{'question_desc'}</B>
		<INPUT TYPE="hidden" NAME="question_desc" value="$Launchleader::question->{'question_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Note: &nbsp; <B>$Launchleader::question->{'question_note'}</B>
		<INPUT TYPE="hidden" NAME="question_note" value="$Launchleader::question->{'question_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Added: &nbsp; <B>$Launchleader::question->{'question_added'}</B>
		<INPUT TYPE="hidden" NAME="question_added" value="$Launchleader::question->{'question_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Ended: &nbsp; <B>$Launchleader::question->{'question_ended'}</B>
		<INPUT TYPE="hidden" NAME="question_ended" value="$Launchleader::question->{'question_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Type: &nbsp; <B>$Launchleader::question->{'question_type'}</B>
		<INPUT TYPE="hidden" NAME="question_type" value="$Launchleader::question->{'question_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Limit: &nbsp; <B>$Launchleader::question->{'question_limit'}</B>
		<INPUT TYPE="hidden" NAME="question_limit" value="$Launchleader::question->{'question_limit'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchleader::FONT" SIZE="$Launchleader::SIZE">
		Status: &nbsp; <B>$Launchleader::question->{'question_status'}</B>
		<INPUT TYPE="hidden" NAME="question_status" value="$Launchleader::question->{'question_status'}">
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
#		if($Launchleader::question->{'question_id'} eq "" || ($Launchleader::question->{'question_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'category_id'} eq "" || ($Launchleader::question->{'category_id'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Category id<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_name'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_wiki'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Wiki<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_img'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Img<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_url'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_desc'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_note'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_added'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_ended'} eq "" )
#		{
#		$Launchleader::ERROR .= "Please enter a valid Ended<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_type'} eq "" || ($Launchleader::question->{'question_type'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_limit'} eq "" || ($Launchleader::question->{'question_limit'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Limit<BR>";
#		return 0;
#		}
#		if($Launchleader::question->{'question_status'} eq "" || ($Launchleader::question->{'question_status'} =~ /\D/is))
#		{
#		$Launchleader::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
