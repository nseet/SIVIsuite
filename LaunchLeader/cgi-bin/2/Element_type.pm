sub read_element_type
{

   $element_type->{'element_type_id'} = clean('int', $_query->param('element_type_id'));
   $element_type->{'element_type_desc'} = $_query->param('element_type_desc');

   return;
}

sub select_element_types
{
   my $where = shift;

   my $statement = "SELECT
element_type.element_type_id,element_type.element_type_desc         
	FROM element_type
         $where";

   $element_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_element_type
{
   $element_type = HFetch($element_type_sth);

   return $element_type->{'element_type_id'} ne "";
}

sub select_element_type
{
   my $id = shift;

   my $statement = "SELECT 
element_type_id,element_type_desc                 
		FROM element_type
                 WHERE element_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $element_type = HFetchone($sth);

   return $element_type->{'element_type_id'} ne "";
}

sub insert_element_type
{
   $element_type->{'element_type_desc'} = $dbh->quote($element_type->{'element_type_desc'});

   my $statement = "INSERT INTO element_type ( 
element_type_id,element_type_desc
	)
	VALUES (
$element_type->{'element_type_id'},$element_type->{'element_type_desc'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_type_id) FROM element_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_element_type
{
    my $setstr = shift;
    my $statement;

   $element_type->{'element_type_desc'} = $dbh->quote($element_type->{'element_type_desc'});

    if($setstr)
      {  $statement = "UPDATE element_type SET $setstr WHERE element_type_id = $element_type->{'element_type_id'}";  }
    else
      {
        $statement = "UPDATE element_type SET
		element_type_id = $element_type->{'element_type_id'},
		element_type_desc = $element_type->{'element_type_desc'}               
		WHERE element_type_id = $element_type->{'element_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_element_type
{
my $id = shift;

my $statement = "DELETE FROM element_type
                 WHERE element_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
