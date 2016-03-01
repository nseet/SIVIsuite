sub read_detail_type
{

   $detail_type->{'detail_type_id'} = clean('int', $_query->param('detail_type_id'));
   $detail_type->{'detail_type_name'} = $_query->param('detail_type_name');

   return;
}

sub select_detail_types
{
   my $where = shift;

   my $statement = "SELECT
detail_type.detail_type_id,detail_type.detail_type_name         
	FROM detail_type
         $where";

   $detail_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_detail_type
{
   $detail_type = HFetch($detail_type_sth);

   return $detail_type->{'detail_type_id'} ne "";
}

sub select_detail_type
{
   my $id = shift;

   my $statement = "SELECT 
detail_type_id,detail_type_name                 
		FROM detail_type
                 WHERE detail_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $detail_type = HFetchone($sth);

   return $detail_type->{'detail_type_id'} ne "";
}

sub insert_detail_type
{
   $detail_type->{'detail_type_name'} = $dbh->quote($detail_type->{'detail_type_name'});

   my $statement = "INSERT INTO detail_type ( 
detail_type_id,detail_type_name
	)
	VALUES (
$detail_type->{'detail_type_id'},$detail_type->{'detail_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(detail_type_id) FROM detail_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_detail_type
{
    my $setstr = shift;
    my $statement;

   $detail_type->{'detail_type_name'} = $dbh->quote($detail_type->{'detail_type_name'});

    if($setstr)
      {  $statement = "UPDATE detail_type SET $setstr WHERE detail_type_id = $detail_type->{'detail_type_id'}";  }
    else
      {
        $statement = "UPDATE detail_type SET
		detail_type_id = $detail_type->{'detail_type_id'},
		detail_type_name = $detail_type->{'detail_type_name'}               
		WHERE detail_type_id = $detail_type->{'detail_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_detail_type
{
my $id = shift;

my $statement = "DELETE FROM detail_type
                 WHERE detail_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
