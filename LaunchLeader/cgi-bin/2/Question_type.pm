sub read_question_type
{

   $question_type->{'question_type_id'} = clean('int', $_query->param('question_type_id'));
   $question_type->{'question_type_name'} = $_query->param('question_type_name');

   return;
}

sub select_question_types
{
   my $where = shift;

   my $statement = "SELECT
question_type.question_type_id,question_type.question_type_name         
	FROM question_type
         $where";

   $question_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_question_type
{
   $question_type = HFetch($question_type_sth);

   return $question_type->{'question_type_id'} ne "";
}

sub select_question_type
{
   my $id = shift;

   my $statement = "SELECT 
question_type_id,question_type_name                 
		FROM question_type
                 WHERE question_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $question_type = HFetchone($sth);

   return $question_type->{'question_type_id'} ne "";
}

sub insert_question_type
{
   $question_type->{'question_type_name'} = $dbh->quote($question_type->{'question_type_name'});

   my $statement = "INSERT INTO question_type ( 
question_type_id,question_type_name
	)
	VALUES (
$question_type->{'question_type_id'},$question_type->{'question_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(question_type_id) FROM question_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_question_type
{
    my $setstr = shift;
    my $statement;

   $question_type->{'question_type_name'} = $dbh->quote($question_type->{'question_type_name'});

    if($setstr)
      {  $statement = "UPDATE question_type SET $setstr WHERE question_type_id = $question_type->{'question_type_id'}";  }
    else
      {
        $statement = "UPDATE question_type SET
		question_type_id = $question_type->{'question_type_id'},
		question_type_name = $question_type->{'question_type_name'}               
		WHERE question_type_id = $question_type->{'question_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_question_type
{
my $id = shift;

my $statement = "DELETE FROM question_type
                 WHERE question_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
