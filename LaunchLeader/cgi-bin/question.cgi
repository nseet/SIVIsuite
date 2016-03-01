#!/usr/bin/perl

use lib '..';
use Launchh;
use strict;

my $stage = $Launchh::_query->param('stage') || 0;
my $mode = $Launchh::_query->param('mode') || "view";

&Launchh::do_check_login();
&Launchh::select_account($Launchh::uid);

&Launchh::read_question();
&Launchh::select_question($Launchh::question->{'question_id'}) if($Launchh::question->{'question_id'});
&Launchh::read_question() if($stage>=2 && $mode eq "edit");


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
	   &Launchh::delete_question($Launchh::question->{'question_id'});
	}
	else
	{
	   if( !$Launchh::question->{'question_id'})
	   {
		&Launchh::insert_question();
	   }
	   else
	   {
		&Launchh::update_question();
	   }
	}



   print "Location: $Launchh::QUESTIONS_CGI?$Launchh::HSTR&stage=2\n\n";
}

&Launchh::clean_exit();

sub html_stage0
{
my $str = << "EOM";
<TABLE WIDTH="$Launchh::TABLE_WIDTH" BORDER="0">   

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Id: &nbsp; <B>$Launchh::question->{'question_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Category id: &nbsp; <B>$Launchh::question->{'category_id'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Name: &nbsp; <B>$Launchh::question->{'question_name'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Wiki: &nbsp; <B>$Launchh::question->{'question_wiki'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Img: &nbsp; <B>$Launchh::question->{'question_img'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Url: &nbsp; <B>$Launchh::question->{'question_url'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Desc: &nbsp; <B>$Launchh::question->{'question_desc'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Note: &nbsp; <B>$Launchh::question->{'question_note'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Added: &nbsp; <B>$Launchh::question->{'question_added'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Ended: &nbsp; <B>$Launchh::question->{'question_ended'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Type: &nbsp; <B>$Launchh::question->{'question_type'}</B>
                </FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
                 Status: &nbsp; <B>$Launchh::question->{'question_status'}</B>
                </FONT></TD></TR>


   <TR>
        <TD>
        <FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
 
        <FORM ACTION="$Launchh::QUESTIONS_CGI">
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
	<FORM ACTION="$Launchh::QUESTION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="2">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_id" value="$Launchh::question->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Category id: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="category_id" value="$Launchh::question->{'category_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_name" value="$Launchh::question->{'question_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Wiki: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_wiki" value="$Launchh::question->{'question_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Img: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_img" value="$Launchh::question->{'question_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_url" value="$Launchh::question->{'question_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="question_desc" ROWS="10" COLS="50">$Launchh::question->{'question_desc'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; &nbsp; &nbsp;<BR>
                <TEXTAREA NAME="question_note" ROWS="10" COLS="50">$Launchh::question->{'question_note'}</TEXTAREA>
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_added" value="$Launchh::question->{'question_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Ended: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_ended" value="$Launchh::question->{'question_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_type" value="$Launchh::question->{'question_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; &nbsp; &nbsp;<BR>
		<INPUT TYPE="text" SIZE="50" MAXLENGTH="255" NAME="question_status" value="$Launchh::question->{'question_status'}">
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
	<FORM ACTION="$Launchh::QUESTION_CGI" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="stage" VALUE="3">
	<INPUT TYPE="HIDDEN" NAME="mode" VALUE="$mode">
        $Launchh::HIDDEN
	<TABLE BORDER="0" CELLPADDING="3">

		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Id: &nbsp; <B>$Launchh::question->{'question_id'}</B>
		<INPUT TYPE="hidden" NAME="question_id" value="$Launchh::question->{'question_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Category id: &nbsp; <B>$Launchh::question->{'category_id'}</B>
		<INPUT TYPE="hidden" NAME="category_id" value="$Launchh::question->{'category_id'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Name: &nbsp; <B>$Launchh::question->{'question_name'}</B>
		<INPUT TYPE="hidden" NAME="question_name" value="$Launchh::question->{'question_name'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Wiki: &nbsp; <B>$Launchh::question->{'question_wiki'}</B>
		<INPUT TYPE="hidden" NAME="question_wiki" value="$Launchh::question->{'question_wiki'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Img: &nbsp; <B>$Launchh::question->{'question_img'}</B>
		<INPUT TYPE="hidden" NAME="question_img" value="$Launchh::question->{'question_img'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Url: &nbsp; <B>$Launchh::question->{'question_url'}</B>
		<INPUT TYPE="hidden" NAME="question_url" value="$Launchh::question->{'question_url'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Desc: &nbsp; <B>$Launchh::question->{'question_desc'}</B>
		<INPUT TYPE="hidden" NAME="question_desc" value="$Launchh::question->{'question_desc'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Note: &nbsp; <B>$Launchh::question->{'question_note'}</B>
		<INPUT TYPE="hidden" NAME="question_note" value="$Launchh::question->{'question_note'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Added: &nbsp; <B>$Launchh::question->{'question_added'}</B>
		<INPUT TYPE="hidden" NAME="question_added" value="$Launchh::question->{'question_added'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Ended: &nbsp; <B>$Launchh::question->{'question_ended'}</B>
		<INPUT TYPE="hidden" NAME="question_ended" value="$Launchh::question->{'question_ended'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Type: &nbsp; <B>$Launchh::question->{'question_type'}</B>
		<INPUT TYPE="hidden" NAME="question_type" value="$Launchh::question->{'question_type'}">
		</FONT></TD></TR>
		<TR><TD><FONT FACE="$Launchh::FONT" SIZE="$Launchh::SIZE">
		Status: &nbsp; <B>$Launchh::question->{'question_status'}</B>
		<INPUT TYPE="hidden" NAME="question_status" value="$Launchh::question->{'question_status'}">
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
#		if($Launchh::question->{'question_id'} eq "" || ($Launchh::question->{'question_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Id<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'category_id'} eq "" || ($Launchh::question->{'category_id'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Category id<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_name'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Name<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_wiki'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Wiki<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_img'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Img<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_url'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Url<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_desc'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Desc<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_note'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Note<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_added'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Added<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_ended'} eq "" )
#		{
#		$Launchh::ERROR .= "Please enter a valid Ended<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_type'} eq "" || ($Launchh::question->{'question_type'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Type<BR>";
#		return 0;
#		}
#		if($Launchh::question->{'question_status'} eq "" || ($Launchh::question->{'question_status'} =~ /\D/is))
#		{
#		$Launchh::ERROR .= "Please enter a valid Status<BR>";
#		return 0;
#		}


return 1;
}

 
  
