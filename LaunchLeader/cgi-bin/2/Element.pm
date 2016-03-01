sub read_element
{

   $element->{'element_id'} = clean('int', $_query->param('element_id'));
   $element->{'project_id'} = clean('int', $_query->param('project_id'));
   $element->{'element_name'} = $_query->param('element_name');
   $element->{'element_desc'} = $_query->param('element_desc');
   $element->{'element_note'} = $_query->param('element_note');
   $element->{'element_completed_note'} = $_query->param('element_completed_note');
   $element->{'element_completed_placeholder'} = $_query->param('element_completed_placeholder');
   $element->{'element_amount'} = clean('int', $_query->param('element_amount'));
   $element->{'element_type'} = clean('int', $_query->param('element_type'));
   $element->{'element_status'} = clean('int', $_query->param('element_status'));

   return;
}

sub select_elements
{
   my $where = shift;

   my $statement = "SELECT
element.element_id,element.project_id,element.element_name,element.element_desc,element.element_note,element.element_completed_note,element.element_completed_placeholder,element.element_amount,element.element_type,element.element_status         
	FROM element
         $where";

   $element_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_element
{
   $element = HFetch($element_sth);

   return $element->{'element_id'} ne "";
}

sub select_element
{
   my $id = shift;

   my $statement = "SELECT 
element_id,project_id,element_name,element_desc,element_note,element_completed_note,element_completed_placeholder,element_amount,element_type,element_status                 
		FROM element
                 WHERE element_id = $id";
   my $sth = Execute($statement,$dbh);

   $element = HFetchone($sth);

   return $element->{'element_id'} ne "";
}

sub insert_element
{
   $element->{'element_name'} = $dbh->quote($element->{'element_name'});
   $element->{'element_desc'} = $dbh->quote($element->{'element_desc'});
   $element->{'element_note'} = $dbh->quote($element->{'element_note'});
   $element->{'element_completed_note'} = $dbh->quote($element->{'element_completed_note'});
   $element->{'element_completed_placeholder'} = $dbh->quote($element->{'element_completed_placeholder'});

   my $statement = "INSERT INTO element ( 
element_id,project_id,element_name,element_desc,element_note,element_completed_note,element_completed_placeholder,element_amount,element_type,element_status
	)
	VALUES (
$element->{'element_id'},$element->{'project_id'},$element->{'element_name'},$element->{'element_desc'},$element->{'element_note'},$element->{'element_completed_note'},$element->{'element_completed_placeholder'},$element->{'element_amount'},$element->{'element_type'},$element->{'element_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_id) FROM element";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_element
{
    my $setstr = shift;
    my $statement;

   $element->{'element_name'} = $dbh->quote($element->{'element_name'});
   $element->{'element_desc'} = $dbh->quote($element->{'element_desc'});
   $element->{'element_note'} = $dbh->quote($element->{'element_note'});
   $element->{'element_completed_note'} = $dbh->quote($element->{'element_completed_note'});
   $element->{'element_completed_placeholder'} = $dbh->quote($element->{'element_completed_placeholder'});

    if($setstr)
      {  $statement = "UPDATE element SET $setstr WHERE element_id = $element->{'element_id'}";  }
    else
      {
        $statement = "UPDATE element SET
		element_id = $element->{'element_id'},
		project_id = $element->{'project_id'},
		element_name = $element->{'element_name'},
		element_desc = $element->{'element_desc'},
		element_note = $element->{'element_note'},
		element_completed_note = $element->{'element_completed_note'},
		element_completed_placeholder = $element->{'element_completed_placeholder'},
		element_amount = $element->{'element_amount'},
		element_type = $element->{'element_type'},
		element_status = $element->{'element_status'}               
		WHERE element_id = $element->{'element_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_element
{
my $id = shift;

my $statement = "DELETE FROM element
                 WHERE element_id = $id";

Execute($statement,$dbh);

return;
}

1;
