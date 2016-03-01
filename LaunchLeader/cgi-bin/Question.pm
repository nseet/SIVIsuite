sub read_question
{

   $question->{'question_id'} = clean('int', $_query->param('question_id'));
   $question->{'category_id'} = clean('int', $_query->param('category_id'));
   $question->{'question_name'} = $_query->param('question_name');
   $question->{'question_wiki'} = $_query->param('question_wiki');
   $question->{'question_img'} = $_query->param('question_img');
   $question->{'question_url'} = $_query->param('question_url');
   $question->{'question_desc'} = $_query->param('question_desc');
   $question->{'question_note'} = $_query->param('question_note');
   $question->{'question_added'} = $_query->param('question_added');
   $question->{'question_ended'} = $_query->param('question_ended');
   $question->{'question_type'} = clean('int', $_query->param('question_type'));
   $question->{'question_limit'} = clean('int', $_query->param('question_limit'));
   $question->{'question_status'} = clean('int', $_query->param('question_status'));

   return;
}

sub select_questions
{
   my $where = shift;

   my $statement = "SELECT
question.question_id,question.category_id,question.question_name,question.question_wiki,question.question_img,question.question_url,question.question_desc,question.question_note,question.question_added,question.question_ended,question.question_type,question.question_limit,question.question_status         
	FROM question
         $where";

   $question_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_question
{
   $question = HFetch($question_sth);

   return $question->{'question_id'} ne "";
}

sub select_question
{
   my $id = shift;

   my $statement = "SELECT 
question_id,category_id,question_name,question_wiki,question_img,question_url,question_desc,question_note,question_added,question_ended,question_type,question_limit,question_status                 
		FROM question
                 WHERE question_id = $id";
   my $sth = Execute($statement,$dbh);

   $question = HFetchone($sth);

   return $question->{'question_id'} ne "";
}

sub insert_question
{
   $question->{'question_name'} = $dbh->quote($question->{'question_name'});
   $question->{'question_wiki'} = $dbh->quote($question->{'question_wiki'});
   $question->{'question_img'} = $dbh->quote($question->{'question_img'});
   $question->{'question_url'} = $dbh->quote($question->{'question_url'});
   $question->{'question_desc'} = $dbh->quote($question->{'question_desc'});
   $question->{'question_note'} = $dbh->quote($question->{'question_note'});

   my $statement = "INSERT INTO question ( 
question_id,category_id,question_name,question_wiki,question_img,question_url,question_desc,question_note,question_added,question_ended,question_type,question_limit,question_status
	)
	VALUES (
$question->{'question_id'},$question->{'category_id'},$question->{'question_name'},$question->{'question_wiki'},$question->{'question_img'},$question->{'question_url'},$question->{'question_desc'},$question->{'question_note'},NOW(),NOW(),$question->{'question_type'},$question->{'question_limit'},$question->{'question_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(question_id) FROM question";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_question
{
    my $setstr = shift;
    my $statement;

   $question->{'question_name'} = $dbh->quote($question->{'question_name'});
   $question->{'question_wiki'} = $dbh->quote($question->{'question_wiki'});
   $question->{'question_img'} = $dbh->quote($question->{'question_img'});
   $question->{'question_url'} = $dbh->quote($question->{'question_url'});
   $question->{'question_desc'} = $dbh->quote($question->{'question_desc'});
   $question->{'question_note'} = $dbh->quote($question->{'question_note'});

    if($setstr)
      {  $statement = "UPDATE question SET $setstr WHERE question_id = $question->{'question_id'}";  }
    else
      {
        $statement = "UPDATE question SET
		question_id = $question->{'question_id'},
		category_id = $question->{'category_id'},
		question_name = $question->{'question_name'},
		question_wiki = $question->{'question_wiki'},
		question_img = $question->{'question_img'},
		question_url = $question->{'question_url'},
		question_desc = $question->{'question_desc'},
		question_note = $question->{'question_note'},
		question_added = NOW(),
		question_ended = NOW(),
		question_type = $question->{'question_type'},
		question_limit = $question->{'question_limit'},
		question_status = $question->{'question_status'}               
		WHERE question_id = $question->{'question_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_question
{
my $id = shift;

my $statement = "DELETE FROM question
                 WHERE question_id = $id";

Execute($statement,$dbh);

return;
}

1;
