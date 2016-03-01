sub read_detail
{

   $detail->{'detail_id'} = clean('int', $_query->param('detail_id'));
   $detail->{'detail_name'} = $_query->param('detail_name');
   $detail->{'detail_desc'} = $_query->param('detail_desc');
   $detail->{'detail_note'} = $_query->param('detail_note');
   $detail->{'detail_type'} = clean('int', $_query->param('detail_type'));
   $detail->{'detail_status'} = clean('int', $_query->param('detail_status'));

   return;
}

sub select_details
{
   my $where = shift;

   my $statement = "SELECT
detail.detail_id,detail.detail_name,detail.detail_desc,detail.detail_note,detail.detail_type,detail.detail_status         
	FROM detail
         $where";

   $detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_detail
{
   $detail = HFetch($detail_sth);

   return $detail->{'detail_id'} ne "";
}

sub select_detail
{
   my $id = shift;

   my $statement = "SELECT 
detail_id,detail_name,detail_desc,detail_note,detail_type,detail_status                 
		FROM detail
                 WHERE detail_id = $id";
   my $sth = Execute($statement,$dbh);

   $detail = HFetchone($sth);

   return $detail->{'detail_id'} ne "";
}

sub insert_detail
{
   $detail->{'detail_name'} = $dbh->quote($detail->{'detail_name'});
   $detail->{'detail_desc'} = $dbh->quote($detail->{'detail_desc'});
   $detail->{'detail_note'} = $dbh->quote($detail->{'detail_note'});

   my $statement = "INSERT INTO detail ( 
detail_id,detail_name,detail_desc,detail_note,detail_type,detail_status
	)
	VALUES (
$detail->{'detail_id'},$detail->{'detail_name'},$detail->{'detail_desc'},$detail->{'detail_note'},$detail->{'detail_type'},$detail->{'detail_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(detail_id) FROM detail";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_detail
{
    my $setstr = shift;
    my $statement;

   $detail->{'detail_name'} = $dbh->quote($detail->{'detail_name'});
   $detail->{'detail_desc'} = $dbh->quote($detail->{'detail_desc'});
   $detail->{'detail_note'} = $dbh->quote($detail->{'detail_note'});

    if($setstr)
      {  $statement = "UPDATE detail SET $setstr WHERE detail_id = $detail->{'detail_id'}";  }
    else
      {
        $statement = "UPDATE detail SET
		detail_id = $detail->{'detail_id'},
		detail_name = $detail->{'detail_name'},
		detail_desc = $detail->{'detail_desc'},
		detail_note = $detail->{'detail_note'},
		detail_type = $detail->{'detail_type'},
		detail_status = $detail->{'detail_status'}               
		WHERE detail_id = $detail->{'detail_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_detail
{
my $id = shift;

my $statement = "DELETE FROM detail
                 WHERE detail_id = $id";

Execute($statement,$dbh);

return;
}

1;
