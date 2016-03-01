sub read_answer_type
{

   $answer_type->{'answer_type_id'} = clean('int', $_query->param('answer_type_id'));
   $answer_type->{'answer_type_name'} = $_query->param('answer_type_name');

   return;
}

sub select_answer_types
{
   my $where = shift;

   my $statement = "SELECT
answer_type.answer_type_id,answer_type.answer_type_name         
	FROM answer_type
         $where";

   $answer_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_answer_type
{
   $answer_type = HFetch($answer_type_sth);

   return $answer_type->{'answer_type_id'} ne "";
}

sub select_answer_type
{
   my $id = shift;

   my $statement = "SELECT 
answer_type_id,answer_type_name                 
		FROM answer_type
                 WHERE answer_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $answer_type = HFetchone($sth);

   return $answer_type->{'answer_type_id'} ne "";
}

sub insert_answer_type
{
   $answer_type->{'answer_type_name'} = $dbh->quote($answer_type->{'answer_type_name'});

   my $statement = "INSERT INTO answer_type ( 
answer_type_id,answer_type_name
	)
	VALUES (
$answer_type->{'answer_type_id'},$answer_type->{'answer_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(answer_type_id) FROM answer_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_answer_type
{
    my $setstr = shift;
    my $statement;

   $answer_type->{'answer_type_name'} = $dbh->quote($answer_type->{'answer_type_name'});

    if($setstr)
      {  $statement = "UPDATE answer_type SET $setstr WHERE answer_type_id = $answer_type->{'answer_type_id'}";  }
    else
      {
        $statement = "UPDATE answer_type SET
		answer_type_id = $answer_type->{'answer_type_id'},
		answer_type_name = $answer_type->{'answer_type_name'}               
		WHERE answer_type_id = $answer_type->{'answer_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_answer_type
{
my $id = shift;

my $statement = "DELETE FROM answer_type
                 WHERE answer_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
