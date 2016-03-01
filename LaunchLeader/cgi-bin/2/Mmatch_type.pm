sub read_mmatch_type
{

   $mmatch_type->{'mmatch_type_id'} = clean('int', $_query->param('mmatch_type_id'));
   $mmatch_type->{'mmatch_type_name'} = $_query->param('mmatch_type_name');

   return;
}

sub select_mmatch_types
{
   my $where = shift;

   my $statement = "SELECT
mmatch_type.mmatch_type_id,mmatch_type.mmatch_type_name         
	FROM mmatch_type
         $where";

   $mmatch_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_mmatch_type
{
   $mmatch_type = HFetch($mmatch_type_sth);

   return $mmatch_type->{'mmatch_type_id'} ne "";
}

sub select_mmatch_type
{
   my $id = shift;

   my $statement = "SELECT 
mmatch_type_id,mmatch_type_name                 
		FROM mmatch_type
                 WHERE mmatch_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $mmatch_type = HFetchone($sth);

   return $mmatch_type->{'mmatch_type_id'} ne "";
}

sub insert_mmatch_type
{
   $mmatch_type->{'mmatch_type_name'} = $dbh->quote($mmatch_type->{'mmatch_type_name'});

   my $statement = "INSERT INTO mmatch_type ( 
mmatch_type_id,mmatch_type_name
	)
	VALUES (
$mmatch_type->{'mmatch_type_id'},$mmatch_type->{'mmatch_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(mmatch_type_id) FROM mmatch_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_mmatch_type
{
    my $setstr = shift;
    my $statement;

   $mmatch_type->{'mmatch_type_name'} = $dbh->quote($mmatch_type->{'mmatch_type_name'});

    if($setstr)
      {  $statement = "UPDATE mmatch_type SET $setstr WHERE mmatch_type_id = $mmatch_type->{'mmatch_type_id'}";  }
    else
      {
        $statement = "UPDATE mmatch_type SET
		mmatch_type_id = $mmatch_type->{'mmatch_type_id'},
		mmatch_type_name = $mmatch_type->{'mmatch_type_name'}               
		WHERE mmatch_type_id = $mmatch_type->{'mmatch_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_mmatch_type
{
my $id = shift;

my $statement = "DELETE FROM mmatch_type
                 WHERE mmatch_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
