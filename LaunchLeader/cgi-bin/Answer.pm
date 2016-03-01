sub read_answer
{

   $answer->{'answer_id'} = clean('int', $_query->param('answer_id'));
   $answer->{'question_id'} = clean('int', $_query->param('question_id'));
   $answer->{'account_id'} = clean('int', $_query->param('account_id'));
   $answer->{'answer_name'} = $_query->param('answer_name');
   $answer->{'answer_wiki'} = $_query->param('answer_wiki');
   $answer->{'answer_img'} = $_query->param('answer_img');
   $answer->{'answer_url'} = $_query->param('answer_url');
   $answer->{'answer_desc'} = $_query->param('answer_desc');
   $answer->{'answer_note'} = $_query->param('answer_note');
   $answer->{'answer_added'} = $_query->param('answer_added');
   $answer->{'answer_ended'} = $_query->param('answer_ended');
   $answer->{'answer_type'} = clean('int', $_query->param('answer_type'));
   $answer->{'answer_status'} = clean('int', $_query->param('answer_status'));

   return;
}

sub select_answers
{
   my $where = shift;

   my $statement = "SELECT
answer.answer_id,answer.question_id,answer.account_id,answer.answer_name,answer.answer_wiki,answer.answer_img,answer.answer_url,answer.answer_desc,answer.answer_note,answer.answer_added,answer.answer_ended,answer.answer_type,answer.answer_status         
	FROM answer
         $where";

   $answer_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_answer
{
   $answer = HFetch($answer_sth);

   return $answer->{'answer_id'} ne "";
}

sub select_answer
{
   my $id = shift;

   my $statement = "SELECT 
answer_id,question_id,account_id,answer_name,answer_wiki,answer_img,answer_url,answer_desc,answer_note,answer_added,answer_ended,answer_type,answer_status                 
		FROM answer
                 WHERE answer_id = $id";
   my $sth = Execute($statement,$dbh);

   $answer = HFetchone($sth);

   return $answer->{'answer_id'} ne "";
}

sub insert_answer
{
   $answer->{'answer_name'} = $dbh->quote($answer->{'answer_name'});
   $answer->{'answer_wiki'} = $dbh->quote($answer->{'answer_wiki'});
   $answer->{'answer_img'} = $dbh->quote($answer->{'answer_img'});
   $answer->{'answer_url'} = $dbh->quote($answer->{'answer_url'});
   $answer->{'answer_desc'} = $dbh->quote($answer->{'answer_desc'});
   $answer->{'answer_note'} = $dbh->quote($answer->{'answer_note'});

   my $statement = "INSERT INTO answer ( 
answer_id,question_id,account_id,answer_name,answer_wiki,answer_img,answer_url,answer_desc,answer_note,answer_added,answer_ended,answer_type,answer_status
	)
	VALUES (
$answer->{'answer_id'},$answer->{'question_id'},$answer->{'account_id'},$answer->{'answer_name'},$answer->{'answer_wiki'},$answer->{'answer_img'},$answer->{'answer_url'},$answer->{'answer_desc'},$answer->{'answer_note'},NOW(),NOW(),$answer->{'answer_type'},$answer->{'answer_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(answer_id) FROM answer";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_answer
{
    my $setstr = shift;
    my $statement;

   $answer->{'answer_name'} = $dbh->quote($answer->{'answer_name'});
   $answer->{'answer_wiki'} = $dbh->quote($answer->{'answer_wiki'});
   $answer->{'answer_img'} = $dbh->quote($answer->{'answer_img'});
   $answer->{'answer_url'} = $dbh->quote($answer->{'answer_url'});
   $answer->{'answer_desc'} = $dbh->quote($answer->{'answer_desc'});
   $answer->{'answer_note'} = $dbh->quote($answer->{'answer_note'});

    if($setstr)
      {  $statement = "UPDATE answer SET $setstr WHERE answer_id = $answer->{'answer_id'}";  }
    else
      {
        $statement = "UPDATE answer SET
		answer_id = $answer->{'answer_id'},
		question_id = $answer->{'question_id'},
		account_id = $answer->{'account_id'},
		answer_name = $answer->{'answer_name'},
		answer_wiki = $answer->{'answer_wiki'},
		answer_img = $answer->{'answer_img'},
		answer_url = $answer->{'answer_url'},
		answer_desc = $answer->{'answer_desc'},
		answer_note = $answer->{'answer_note'},
		answer_added = NOW(),
		answer_ended = NOW(),
		answer_type = $answer->{'answer_type'},
		answer_status = $answer->{'answer_status'}               
		WHERE answer_id = $answer->{'answer_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_answer
{
my $id = shift;

my $statement = "DELETE FROM answer
                 WHERE answer_id = $id";

Execute($statement,$dbh);

return;
}

1;
