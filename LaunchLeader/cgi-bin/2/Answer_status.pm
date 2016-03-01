sub read_answer_status
{

   $answer_status->{'answer_status_id'} = clean('int', $_query->param('answer_status_id'));
   $answer_status->{'answer_status_name'} = $_query->param('answer_status_name');

   return;
}

sub select_answer_statuss
{
   my $where = shift;

   my $statement = "SELECT
answer_status.answer_status_id,answer_status.answer_status_name         
	FROM answer_status
         $where";

   $answer_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_answer_status
{
   $answer_status = HFetch($answer_status_sth);

   return $answer_status->{'answer_status_id'} ne "";
}

sub select_answer_status
{
   my $id = shift;

   my $statement = "SELECT 
answer_status_id,answer_status_name                 
		FROM answer_status
                 WHERE answer_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $answer_status = HFetchone($sth);

   return $answer_status->{'answer_status_id'} ne "";
}

sub insert_answer_status
{
   $answer_status->{'answer_status_name'} = $dbh->quote($answer_status->{'answer_status_name'});

   my $statement = "INSERT INTO answer_status ( 
answer_status_id,answer_status_name
	)
	VALUES (
$answer_status->{'answer_status_id'},$answer_status->{'answer_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(answer_status_id) FROM answer_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_answer_status
{
    my $setstr = shift;
    my $statement;

   $answer_status->{'answer_status_name'} = $dbh->quote($answer_status->{'answer_status_name'});

    if($setstr)
      {  $statement = "UPDATE answer_status SET $setstr WHERE answer_status_id = $answer_status->{'answer_status_id'}";  }
    else
      {
        $statement = "UPDATE answer_status SET
		answer_status_id = $answer_status->{'answer_status_id'},
		answer_status_name = $answer_status->{'answer_status_name'}               
		WHERE answer_status_id = $answer_status->{'answer_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_answer_status
{
my $id = shift;

my $statement = "DELETE FROM answer_status
                 WHERE answer_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
