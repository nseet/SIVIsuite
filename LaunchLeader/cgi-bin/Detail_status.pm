sub read_detail_status
{

   $detail_status->{'detail_status_id'} = clean('int', $_query->param('detail_status_id'));
   $detail_status->{'detail_status_name'} = $_query->param('detail_status_name');

   return;
}

sub select_detail_statuss
{
   my $where = shift;

   my $statement = "SELECT
detail_status.detail_status_id,detail_status.detail_status_name         
	FROM detail_status
         $where";

   $detail_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_detail_status
{
   $detail_status = HFetch($detail_status_sth);

   return $detail_status->{'detail_status_id'} ne "";
}

sub select_detail_status
{
   my $id = shift;

   my $statement = "SELECT 
detail_status_id,detail_status_name                 
		FROM detail_status
                 WHERE detail_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $detail_status = HFetchone($sth);

   return $detail_status->{'detail_status_id'} ne "";
}

sub insert_detail_status
{
   $detail_status->{'detail_status_name'} = $dbh->quote($detail_status->{'detail_status_name'});

   my $statement = "INSERT INTO detail_status ( 
detail_status_id,detail_status_name
	)
	VALUES (
$detail_status->{'detail_status_id'},$detail_status->{'detail_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(detail_status_id) FROM detail_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_detail_status
{
    my $setstr = shift;
    my $statement;

   $detail_status->{'detail_status_name'} = $dbh->quote($detail_status->{'detail_status_name'});

    if($setstr)
      {  $statement = "UPDATE detail_status SET $setstr WHERE detail_status_id = $detail_status->{'detail_status_id'}";  }
    else
      {
        $statement = "UPDATE detail_status SET
		detail_status_id = $detail_status->{'detail_status_id'},
		detail_status_name = $detail_status->{'detail_status_name'}               
		WHERE detail_status_id = $detail_status->{'detail_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_detail_status
{
my $id = shift;

my $statement = "DELETE FROM detail_status
                 WHERE detail_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
