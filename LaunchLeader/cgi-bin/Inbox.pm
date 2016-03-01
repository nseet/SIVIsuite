sub read_inbox
{

   $inbox->{'inbox_id'} = clean('int', $_query->param('inbox_id'));
   $inbox->{'account_to'} = clean('int', $_query->param('account_to'));
   $inbox->{'account_from'} = clean('int', $_query->param('account_from'));
   $inbox->{'inbox_name'} = $_query->param('inbox_name');
   $inbox->{'inbox_desc'} = $_query->param('inbox_desc');
   $inbox->{'inbox_note'} = $_query->param('inbox_note');
   $inbox->{'inbox_date'} = $_query->param('inbox_date');
   $inbox->{'inbox_type'} = clean('int', $_query->param('inbox_type'));
   $inbox->{'inbox_status'} = clean('int', $_query->param('inbox_status'));

   return;
}

sub select_inboxs
{
   my $where = shift;

   my $statement = "SELECT
inbox.inbox_id,inbox.account_to,inbox.account_from,inbox.inbox_name,inbox.inbox_desc,inbox.inbox_note,inbox.inbox_date,inbox.inbox_type,inbox.inbox_status         
	FROM inbox
         $where";

   $inbox_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_inbox
{
   $inbox = HFetch($inbox_sth);

   return $inbox->{'inbox_id'} ne "";
}

sub select_inbox
{
   my $id = shift;

   my $statement = "SELECT 
inbox_id,account_to,account_from,inbox_name,inbox_desc,inbox_note,inbox_date,inbox_type,inbox_status                 
		FROM inbox
                 WHERE inbox_id = $id";
   my $sth = Execute($statement,$dbh);

   $inbox = HFetchone($sth);

   return $inbox->{'inbox_id'} ne "";
}

sub insert_inbox
{
   $inbox->{'inbox_name'} = $dbh->quote($inbox->{'inbox_name'});
   $inbox->{'inbox_desc'} = $dbh->quote($inbox->{'inbox_desc'});
   $inbox->{'inbox_note'} = $dbh->quote($inbox->{'inbox_note'});

   my $statement = "INSERT INTO inbox ( 
inbox_id,account_to,account_from,inbox_name,inbox_desc,inbox_note,inbox_date,inbox_type,inbox_status
	)
	VALUES (
$inbox->{'inbox_id'},$inbox->{'account_to'},$inbox->{'account_from'},$inbox->{'inbox_name'},$inbox->{'inbox_desc'},$inbox->{'inbox_note'},NOW(),$inbox->{'inbox_type'},$inbox->{'inbox_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(inbox_id) FROM inbox";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_inbox
{
    my $setstr = shift;
    my $statement;

   $inbox->{'inbox_name'} = $dbh->quote($inbox->{'inbox_name'});
   $inbox->{'inbox_desc'} = $dbh->quote($inbox->{'inbox_desc'});
   $inbox->{'inbox_note'} = $dbh->quote($inbox->{'inbox_note'});

    if($setstr)
      {  $statement = "UPDATE inbox SET $setstr WHERE inbox_id = $inbox->{'inbox_id'}";  }
    else
      {
        $statement = "UPDATE inbox SET
		inbox_id = $inbox->{'inbox_id'},
		account_to = $inbox->{'account_to'},
		account_from = $inbox->{'account_from'},
		inbox_name = $inbox->{'inbox_name'},
		inbox_desc = $inbox->{'inbox_desc'},
		inbox_note = $inbox->{'inbox_note'},
		inbox_date = NOW(),
		inbox_type = $inbox->{'inbox_type'},
		inbox_status = $inbox->{'inbox_status'}               
		WHERE inbox_id = $inbox->{'inbox_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_inbox
{
my $id = shift;

my $statement = "DELETE FROM inbox
                 WHERE inbox_id = $id";

Execute($statement,$dbh);

return;
}

1;
