sub read_entry_type
{

   $entry_type->{'entry_type_id'} = clean('int', $_query->param('entry_type_id'));
   $entry_type->{'entry_type_name'} = $_query->param('entry_type_name');

   return;
}

sub select_entry_types
{
   my $where = shift;

   my $statement = "SELECT
entry_type.entry_type_id,entry_type.entry_type_name         
	FROM entry_type
         $where";

   $entry_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_entry_type
{
   $entry_type = HFetch($entry_type_sth);

   return $entry_type->{'entry_type_id'} ne "";
}

sub select_entry_type
{
   my $id = shift;

   my $statement = "SELECT 
entry_type_id,entry_type_name                 
		FROM entry_type
                 WHERE entry_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $entry_type = HFetchone($sth);

   return $entry_type->{'entry_type_id'} ne "";
}

sub insert_entry_type
{
   $entry_type->{'entry_type_name'} = $dbh->quote($entry_type->{'entry_type_name'});

   my $statement = "INSERT INTO entry_type ( 
entry_type_id,entry_type_name
	)
	VALUES (
$entry_type->{'entry_type_id'},$entry_type->{'entry_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(entry_type_id) FROM entry_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_entry_type
{
    my $setstr = shift;
    my $statement;

   $entry_type->{'entry_type_name'} = $dbh->quote($entry_type->{'entry_type_name'});

    if($setstr)
      {  $statement = "UPDATE entry_type SET $setstr WHERE entry_type_id = $entry_type->{'entry_type_id'}";  }
    else
      {
        $statement = "UPDATE entry_type SET
		entry_type_id = $entry_type->{'entry_type_id'},
		entry_type_name = $entry_type->{'entry_type_name'}               
		WHERE entry_type_id = $entry_type->{'entry_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_entry_type
{
my $id = shift;

my $statement = "DELETE FROM entry_type
                 WHERE entry_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
