sub read_funding_milestones
{

   $funding_milestones->{'funding_milestones_id'} = clean('int', $_query->param('funding_milestones_id'));
   $funding_milestones->{'account_id'} = clean('int', $_query->param('account_id'));
   $funding_milestones->{'element_id'} = clean('int', $_query->param('element_id'));
   $funding_milestones->{'funding_failure_emailed'} = clean('int', $_query->param('funding_failure_emailed'));
   $funding_milestones->{'funding_milestones_datetime'} = $_query->param('funding_milestones_datetime');

   return;
}

sub select_funding_milestoness
{
   my $where = shift;

   my $statement = "SELECT
funding_milestones.funding_milestones_id,funding_milestones.account_id,funding_milestones.element_id,funding_milestones.funding_failure_emailed,funding_milestones.funding_milestones_datetime         
	FROM funding_milestones
         $where";

   $funding_milestones_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_funding_milestones
{
   $funding_milestones = HFetch($funding_milestones_sth);

   return $funding_milestones->{'funding_milestones_id'} ne "";
}

sub select_funding_milestones
{
   my $id = shift;

   my $statement = "SELECT 
funding_milestones_id,account_id,element_id,funding_failure_emailed,funding_milestones_datetime                 
		FROM funding_milestones
                 WHERE funding_milestones_id = $id";
   my $sth = Execute($statement,$dbh);

   $funding_milestones = HFetchone($sth);

   return $funding_milestones->{'funding_milestones_id'} ne "";
}

sub insert_funding_milestones
{

   my $statement = "INSERT INTO funding_milestones ( 
funding_milestones_id,account_id,element_id,funding_failure_emailed,funding_milestones_datetime
	)
	VALUES (
$funding_milestones->{'funding_milestones_id'},$funding_milestones->{'account_id'},$funding_milestones->{'element_id'},$funding_milestones->{'funding_failure_emailed'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(funding_milestones_id) FROM funding_milestones";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_funding_milestones
{
    my $setstr = shift;
    my $statement;


    if($setstr)
      {  $statement = "UPDATE funding_milestones SET $setstr WHERE funding_milestones_id = $funding_milestones->{'funding_milestones_id'}";  }
    else
      {
        $statement = "UPDATE funding_milestones SET
		funding_milestones_id = $funding_milestones->{'funding_milestones_id'},
		account_id = $funding_milestones->{'account_id'},
		element_id = $funding_milestones->{'element_id'},
		funding_failure_emailed = $funding_milestones->{'funding_failure_emailed'},
		funding_milestones_datetime = NOW()               
		WHERE funding_milestones_id = $funding_milestones->{'funding_milestones_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_funding_milestones
{
my $id = shift;

my $statement = "DELETE FROM funding_milestones
                 WHERE funding_milestones_id = $id";

Execute($statement,$dbh);

return;
}

1;
