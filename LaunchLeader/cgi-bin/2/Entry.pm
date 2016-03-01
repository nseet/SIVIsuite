sub read_entry
{

   $entry->{'entry_id'} = clean('int', $_query->param('entry_id'));
   $entry->{'entry_name'} = $_query->param('entry_name');
   $entry->{'entry_wiki'} = $_query->param('entry_wiki');
   $entry->{'entry_img'} = $_query->param('entry_img');
   $entry->{'entry_url'} = $_query->param('entry_url');
   $entry->{'entry_desc'} = $_query->param('entry_desc');
   $entry->{'entry_note'} = $_query->param('entry_note');
   $entry->{'entry_added'} = $_query->param('entry_added');
   $entry->{'entry_ended'} = $_query->param('entry_ended');
   $entry->{'entry_type'} = clean('int', $_query->param('entry_type'));
   $entry->{'entry_status'} = clean('int', $_query->param('entry_status'));

   return;
}

sub select_entrys
{
   my $where = shift;

   my $statement = "SELECT
entry.entry_id,entry.entry_name,entry.entry_wiki,entry.entry_img,entry.entry_url,entry.entry_desc,entry.entry_note,entry.entry_added,entry.entry_ended,entry.entry_type,entry.entry_status         
	FROM entry
         $where";

   $entry_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_entry
{
   $entry = HFetch($entry_sth);

   return $entry->{'entry_id'} ne "";
}

sub select_entry
{
   my $id = shift;

   my $statement = "SELECT 
entry_id,entry_name,entry_wiki,entry_img,entry_url,entry_desc,entry_note,entry_added,entry_ended,entry_type,entry_status                 
		FROM entry
                 WHERE entry_id = $id";
   my $sth = Execute($statement,$dbh);

   $entry = HFetchone($sth);

   return $entry->{'entry_id'} ne "";
}

sub insert_entry
{
   $entry->{'entry_name'} = $dbh->quote($entry->{'entry_name'});
   $entry->{'entry_wiki'} = $dbh->quote($entry->{'entry_wiki'});
   $entry->{'entry_img'} = $dbh->quote($entry->{'entry_img'});
   $entry->{'entry_url'} = $dbh->quote($entry->{'entry_url'});
   $entry->{'entry_desc'} = $dbh->quote($entry->{'entry_desc'});
   $entry->{'entry_note'} = $dbh->quote($entry->{'entry_note'});

   my $statement = "INSERT INTO entry ( 
entry_id,entry_name,entry_wiki,entry_img,entry_url,entry_desc,entry_note,entry_added,entry_ended,entry_type,entry_status
	)
	VALUES (
$entry->{'entry_id'},$entry->{'entry_name'},$entry->{'entry_wiki'},$entry->{'entry_img'},$entry->{'entry_url'},$entry->{'entry_desc'},$entry->{'entry_note'},NOW(),NOW(),$entry->{'entry_type'},$entry->{'entry_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(entry_id) FROM entry";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_entry
{
    my $setstr = shift;
    my $statement;

   $entry->{'entry_name'} = $dbh->quote($entry->{'entry_name'});
   $entry->{'entry_wiki'} = $dbh->quote($entry->{'entry_wiki'});
   $entry->{'entry_img'} = $dbh->quote($entry->{'entry_img'});
   $entry->{'entry_url'} = $dbh->quote($entry->{'entry_url'});
   $entry->{'entry_desc'} = $dbh->quote($entry->{'entry_desc'});
   $entry->{'entry_note'} = $dbh->quote($entry->{'entry_note'});

    if($setstr)
      {  $statement = "UPDATE entry SET $setstr WHERE entry_id = $entry->{'entry_id'}";  }
    else
      {
        $statement = "UPDATE entry SET
		entry_id = $entry->{'entry_id'},
		entry_name = $entry->{'entry_name'},
		entry_wiki = $entry->{'entry_wiki'},
		entry_img = $entry->{'entry_img'},
		entry_url = $entry->{'entry_url'},
		entry_desc = $entry->{'entry_desc'},
		entry_note = $entry->{'entry_note'},
		entry_added = NOW(),
		entry_ended = NOW(),
		entry_type = $entry->{'entry_type'},
		entry_status = $entry->{'entry_status'}               
		WHERE entry_id = $entry->{'entry_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_entry
{
my $id = shift;

my $statement = "DELETE FROM entry
                 WHERE entry_id = $id";

Execute($statement,$dbh);

return;
}

1;
