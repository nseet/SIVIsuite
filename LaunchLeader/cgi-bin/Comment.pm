sub read_comment
{

   $comment->{'comment_id'} = clean('int', $_query->param('comment_id'));
   $comment->{'account_id'} = clean('int', $_query->param('account_id'));
   $comment->{'question_id'} = clean('int', $_query->param('question_id'));
   $comment->{'answer_id'} = clean('int', $_query->param('answer_id'));
   $comment->{'comment_name'} = $_query->param('comment_name');
   $comment->{'comment_desc'} = $_query->param('comment_desc');
   $comment->{'comment_note'} = $_query->param('comment_note');
   $comment->{'comment_added'} = $_query->param('comment_added');
   $comment->{'comment_updated'} = $_query->param('comment_updated');
   $comment->{'comment_type'} = clean('int', $_query->param('comment_type'));
   $comment->{'comment_status'} = clean('int', $_query->param('comment_status'));

   return;
}

sub select_comments
{
   my $where = shift;

   my $statement = "SELECT
comment.comment_id,comment.account_id,comment.question_id,comment.answer_id,comment.comment_name,comment.comment_desc,comment.comment_note,comment.comment_added,comment.comment_updated,comment.comment_type,comment.comment_status         
	FROM comment
         $where";

   $comment_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_comment
{
   $comment = HFetch($comment_sth);

   return $comment->{'comment_id'} ne "";
}

sub select_comment
{
   my $id = shift;

   my $statement = "SELECT 
comment_id,account_id,question_id,answer_id,comment_name,comment_desc,comment_note,comment_added,comment_updated,comment_type,comment_status                 
		FROM comment
                 WHERE comment_id = $id";
   my $sth = Execute($statement,$dbh);

   $comment = HFetchone($sth);

   return $comment->{'comment_id'} ne "";
}

sub insert_comment
{
   $comment->{'comment_name'} = $dbh->quote($comment->{'comment_name'});
   $comment->{'comment_desc'} = $dbh->quote($comment->{'comment_desc'});
   $comment->{'comment_note'} = $dbh->quote($comment->{'comment_note'});

   my $statement = "INSERT INTO comment ( 
comment_id,account_id,question_id,answer_id,comment_name,comment_desc,comment_note,comment_added,comment_updated,comment_type,comment_status
	)
	VALUES (
$comment->{'comment_id'},$comment->{'account_id'},$comment->{'question_id'},$comment->{'answer_id'},$comment->{'comment_name'},$comment->{'comment_desc'},$comment->{'comment_note'},NOW(),NOW(),$comment->{'comment_type'},$comment->{'comment_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(comment_id) FROM comment";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_comment
{
    my $setstr = shift;
    my $statement;

   $comment->{'comment_name'} = $dbh->quote($comment->{'comment_name'});
   $comment->{'comment_desc'} = $dbh->quote($comment->{'comment_desc'});
   $comment->{'comment_note'} = $dbh->quote($comment->{'comment_note'});

    if($setstr)
      {  $statement = "UPDATE comment SET $setstr WHERE comment_id = $comment->{'comment_id'}";  }
    else
      {
        $statement = "UPDATE comment SET
		comment_id = $comment->{'comment_id'},
		account_id = $comment->{'account_id'},
		question_id = $comment->{'question_id'},
		answer_id = $comment->{'answer_id'},
		comment_name = $comment->{'comment_name'},
		comment_desc = $comment->{'comment_desc'},
		comment_note = $comment->{'comment_note'},
		comment_added = NOW(),
		comment_updated = NOW(),
		comment_type = $comment->{'comment_type'},
		comment_status = $comment->{'comment_status'}               
		WHERE comment_id = $comment->{'comment_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_comment
{
my $id = shift;

my $statement = "DELETE FROM comment
                 WHERE comment_id = $id";

Execute($statement,$dbh);

return;
}

1;
