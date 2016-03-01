sub read_feedback
{

   $feedback->{'feedback_id'} = clean('int', $_query->param('feedback_id'));
   $feedback->{'task_id'} = clean('int', $_query->param('task_id'));
   $feedback->{'feedback_name'} = $_query->param('feedback_name');
   $feedback->{'feedback_desc'} = $_query->param('feedback_desc');
   $feedback->{'feedback_type'} = clean('int', $_query->param('feedback_type'));
   $feedback->{'feedback_date'} = $_query->param('feedback_date');
   $feedback->{'feedback_status'} = clean('int', $_query->param('feedback_status'));

   return;
}

sub select_feedbacks
{
   my $where = shift;

   my $statement = "SELECT
feedback.feedback_id,feedback.task_id,feedback.feedback_name,feedback.feedback_desc,feedback.feedback_type,feedback.feedback_date,feedback.feedback_status         
	FROM feedback
         $where";

   $feedback_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_feedback
{
   $feedback = HFetch($feedback_sth);

   return $feedback->{'feedback_id'} ne "";
}

sub select_feedback
{
   my $id = shift;

   my $statement = "SELECT 
feedback_id,task_id,feedback_name,feedback_desc,feedback_type,feedback_date,feedback_status                 
		FROM feedback
                 WHERE feedback_id = $id";
   my $sth = Execute($statement,$dbh);

   $feedback = HFetchone($sth);

   return $feedback->{'feedback_id'} ne "";
}

sub insert_feedback
{
   $feedback->{'feedback_name'} = $dbh->quote($feedback->{'feedback_name'});
   $feedback->{'feedback_desc'} = $dbh->quote($feedback->{'feedback_desc'});

   my $statement = "INSERT INTO feedback ( 
feedback_id,task_id,feedback_name,feedback_desc,feedback_type,feedback_date,feedback_status
	)
	VALUES (
$feedback->{'feedback_id'},$feedback->{'task_id'},$feedback->{'feedback_name'},$feedback->{'feedback_desc'},$feedback->{'feedback_type'},NOW(),$feedback->{'feedback_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(feedback_id) FROM feedback";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_feedback
{
    my $setstr = shift;
    my $statement;

   $feedback->{'feedback_name'} = $dbh->quote($feedback->{'feedback_name'});
   $feedback->{'feedback_desc'} = $dbh->quote($feedback->{'feedback_desc'});

    if($setstr)
      {  $statement = "UPDATE feedback SET $setstr WHERE feedback_id = $feedback->{'feedback_id'}";  }
    else
      {
        $statement = "UPDATE feedback SET
		feedback_id = $feedback->{'feedback_id'},
		task_id = $feedback->{'task_id'},
		feedback_name = $feedback->{'feedback_name'},
		feedback_desc = $feedback->{'feedback_desc'},
		feedback_type = $feedback->{'feedback_type'},
		feedback_date = NOW(),
		feedback_status = $feedback->{'feedback_status'}               
		WHERE feedback_id = $feedback->{'feedback_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_feedback
{
my $id = shift;

my $statement = "DELETE FROM feedback
                 WHERE feedback_id = $id";

Execute($statement,$dbh);

return;
}

1;
