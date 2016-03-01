sub read_mmatch_status
{

   $mmatch_status->{'mmatch_status_id'} = clean('int', $_query->param('mmatch_status_id'));
   $mmatch_status->{'mmatch_status_name'} = $_query->param('mmatch_status_name');

   return;
}

sub select_mmatch_statuss
{
   my $where = shift;

   my $statement = "SELECT
mmatch_status.mmatch_status_id,mmatch_status.mmatch_status_name         
	FROM mmatch_status
         $where";

   $mmatch_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_mmatch_status
{
   $mmatch_status = HFetch($mmatch_status_sth);

   return $mmatch_status->{'mmatch_status_id'} ne "";
}

sub select_mmatch_status
{
   my $id = shift;

   my $statement = "SELECT 
mmatch_status_id,mmatch_status_name                 
		FROM mmatch_status
                 WHERE mmatch_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $mmatch_status = HFetchone($sth);

   return $mmatch_status->{'mmatch_status_id'} ne "";
}

sub insert_mmatch_status
{
   $mmatch_status->{'mmatch_status_name'} = $dbh->quote($mmatch_status->{'mmatch_status_name'});

   my $statement = "INSERT INTO mmatch_status ( 
mmatch_status_id,mmatch_status_name
	)
	VALUES (
$mmatch_status->{'mmatch_status_id'},$mmatch_status->{'mmatch_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(mmatch_status_id) FROM mmatch_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_mmatch_status
{
    my $setstr = shift;
    my $statement;

   $mmatch_status->{'mmatch_status_name'} = $dbh->quote($mmatch_status->{'mmatch_status_name'});

    if($setstr)
      {  $statement = "UPDATE mmatch_status SET $setstr WHERE mmatch_status_id = $mmatch_status->{'mmatch_status_id'}";  }
    else
      {
        $statement = "UPDATE mmatch_status SET
		mmatch_status_id = $mmatch_status->{'mmatch_status_id'},
		mmatch_status_name = $mmatch_status->{'mmatch_status_name'}               
		WHERE mmatch_status_id = $mmatch_status->{'mmatch_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_mmatch_status
{
my $id = shift;

my $statement = "DELETE FROM mmatch_status
                 WHERE mmatch_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
