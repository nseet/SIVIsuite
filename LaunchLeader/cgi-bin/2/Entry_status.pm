sub read_entry_status
{

   $entry_status->{'entry_status_id'} = clean('int', $_query->param('entry_status_id'));
   $entry_status->{'entry_status_name'} = $_query->param('entry_status_name');

   return;
}

sub select_entry_statuss
{
   my $where = shift;

   my $statement = "SELECT
entry_status.entry_status_id,entry_status.entry_status_name         
	FROM entry_status
         $where";

   $entry_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_entry_status
{
   $entry_status = HFetch($entry_status_sth);

   return $entry_status->{'entry_status_id'} ne "";
}

sub select_entry_status
{
   my $id = shift;

   my $statement = "SELECT 
entry_status_id,entry_status_name                 
		FROM entry_status
                 WHERE entry_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $entry_status = HFetchone($sth);

   return $entry_status->{'entry_status_id'} ne "";
}

sub insert_entry_status
{
   $entry_status->{'entry_status_name'} = $dbh->quote($entry_status->{'entry_status_name'});

   my $statement = "INSERT INTO entry_status ( 
entry_status_id,entry_status_name
	)
	VALUES (
$entry_status->{'entry_status_id'},$entry_status->{'entry_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(entry_status_id) FROM entry_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_entry_status
{
    my $setstr = shift;
    my $statement;

   $entry_status->{'entry_status_name'} = $dbh->quote($entry_status->{'entry_status_name'});

    if($setstr)
      {  $statement = "UPDATE entry_status SET $setstr WHERE entry_status_id = $entry_status->{'entry_status_id'}";  }
    else
      {
        $statement = "UPDATE entry_status SET
		entry_status_id = $entry_status->{'entry_status_id'},
		entry_status_name = $entry_status->{'entry_status_name'}               
		WHERE entry_status_id = $entry_status->{'entry_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_entry_status
{
my $id = shift;

my $statement = "DELETE FROM entry_status
                 WHERE entry_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
