sub read_mmatch
{

   $mmatch->{'mmatch_id'} = clean('int', $_query->param('mmatch_id'));
   $mmatch->{'account_id'} = clean('int', $_query->param('account_id'));
   $mmatch->{'mmatch_account_id'} = clean('int', $_query->param('mmatch_account_id'));
   $mmatch->{'mmatch_score'} = clean('int', $_query->param('mmatch_score'));
   $mmatch->{'mmatch_note'} = $_query->param('mmatch_note');
   $mmatch->{'mmatch_made'} = $_query->param('mmatch_made');
   $mmatch->{'mmatch_notified'} = $_query->param('mmatch_notified');
   $mmatch->{'mmatch_contacted'} = $_query->param('mmatch_contacted');
   $mmatch->{'mmatch_expires'} = $_query->param('mmatch_expires');
   $mmatch->{'mmatch_type'} = clean('int', $_query->param('mmatch_type'));
   $mmatch->{'mmatch_status'} = clean('int', $_query->param('mmatch_status'));

   return;
}

sub select_mmatchs
{
   my $where = shift;

   my $statement = "SELECT
mmatch.mmatch_id,mmatch.account_id,mmatch.mmatch_account_id,mmatch.mmatch_score,mmatch.mmatch_note,mmatch.mmatch_made,mmatch.mmatch_notified,mmatch.mmatch_contacted,mmatch.mmatch_expires,mmatch.mmatch_type,mmatch.mmatch_status         
	FROM mmatch
         $where";

   $mmatch_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_mmatch
{
   $mmatch = HFetch($mmatch_sth);

   return $mmatch->{'mmatch_id'} ne "";
}

sub select_mmatch
{
   my $id = shift;

   my $statement = "SELECT 
mmatch_id,account_id,mmatch_account_id,mmatch_score,mmatch_note,mmatch_made,mmatch_notified,mmatch_contacted,mmatch_expires,mmatch_type,mmatch_status                 
		FROM mmatch
                 WHERE mmatch_id = $id";
   my $sth = Execute($statement,$dbh);

   $mmatch = HFetchone($sth);

   return $mmatch->{'mmatch_id'} ne "";
}

sub insert_mmatch
{
   $mmatch->{'mmatch_note'} = $dbh->quote($mmatch->{'mmatch_note'});

   my $statement = "INSERT INTO mmatch ( 
mmatch_id,account_id,mmatch_account_id,mmatch_score,mmatch_note,mmatch_made,mmatch_notified,mmatch_contacted,mmatch_expires,mmatch_type,mmatch_status
	)
	VALUES (
$mmatch->{'mmatch_id'},$mmatch->{'account_id'},$mmatch->{'mmatch_account_id'},$mmatch->{'mmatch_score'},$mmatch->{'mmatch_note'},NOW(),NULL,NULL,NULL,$mmatch->{'mmatch_type'},$mmatch->{'mmatch_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(mmatch_id) FROM mmatch";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_mmatch
{
    my $setstr = shift;
    my $statement;

   $mmatch->{'mmatch_note'} = $dbh->quote($mmatch->{'mmatch_note'});

    if($setstr)
      {  $statement = "UPDATE mmatch SET $setstr WHERE mmatch_id = $mmatch->{'mmatch_id'}";  }
    else
      {
        $statement = "UPDATE mmatch SET
		mmatch_id = $mmatch->{'mmatch_id'},
		account_id = $mmatch->{'account_id'},
		mmatch_account_id = $mmatch->{'mmatch_account_id'},
		mmatch_score = $mmatch->{'mmatch_score'},
		mmatch_note = $mmatch->{'mmatch_note'},
		mmatch_made = NOW(),
		mmatch_notified = NOW(),
		mmatch_contacted = NOW(),
		mmatch_expires = NOW(),
		mmatch_type = $mmatch->{'mmatch_type'},
		mmatch_status = $mmatch->{'mmatch_status'}               
		WHERE mmatch_id = $mmatch->{'mmatch_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_mmatch
{
my $id = shift;

my $statement = "DELETE FROM mmatch
                 WHERE mmatch_id = $id";

Execute($statement,$dbh);

return;
}

1;
