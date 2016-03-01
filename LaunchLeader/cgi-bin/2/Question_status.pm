sub read_question_status
{

   $question_status->{'question_status_id'} = clean('int', $_query->param('question_status_id'));
   $question_status->{'question_status_name'} = $_query->param('question_status_name');

   return;
}

sub select_question_statuss
{
   my $where = shift;

   my $statement = "SELECT
question_status.question_status_id,question_status.question_status_name         
	FROM question_status
         $where";

   $question_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_question_status
{
   $question_status = HFetch($question_status_sth);

   return $question_status->{'question_status_id'} ne "";
}

sub select_question_status
{
   my $id = shift;

   my $statement = "SELECT 
question_status_id,question_status_name                 
		FROM question_status
                 WHERE question_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $question_status = HFetchone($sth);

   return $question_status->{'question_status_id'} ne "";
}

sub insert_question_status
{
   $question_status->{'question_status_name'} = $dbh->quote($question_status->{'question_status_name'});

   my $statement = "INSERT INTO question_status ( 
question_status_id,question_status_name
	)
	VALUES (
$question_status->{'question_status_id'},$question_status->{'question_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(question_status_id) FROM question_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_question_status
{
    my $setstr = shift;
    my $statement;

   $question_status->{'question_status_name'} = $dbh->quote($question_status->{'question_status_name'});

    if($setstr)
      {  $statement = "UPDATE question_status SET $setstr WHERE question_status_id = $question_status->{'question_status_id'}";  }
    else
      {
        $statement = "UPDATE question_status SET
		question_status_id = $question_status->{'question_status_id'},
		question_status_name = $question_status->{'question_status_name'}               
		WHERE question_status_id = $question_status->{'question_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_question_status
{
my $id = shift;

my $statement = "DELETE FROM question_status
                 WHERE question_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
