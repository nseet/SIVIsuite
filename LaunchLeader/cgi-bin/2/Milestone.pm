sub read_milestone
{

   $milestone->{'milestone_id'} = clean('int', $_query->param('milestone_id'));
   $milestone->{'milestone_name'} = $_query->param('milestone_name');
   $milestone->{'milestone_desc'} = $_query->param('milestone_desc');
   $milestone->{'milestone_note'} = $_query->param('milestone_note');
   $milestone->{'milestone_status'} = clean('int', $_query->param('milestone_status'));
   $milestone->{'milestone_type'} = clean('int', $_query->param('milestone_type'));

   return;
}

sub select_milestones
{
   my $where = shift;

   my $statement = "SELECT
milestone.milestone_id,milestone.milestone_name,milestone.milestone_desc,milestone.milestone_note,milestone.milestone_status,milestone.milestone_type         
	FROM milestone
         $where";

   $milestone_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_milestone
{
   $milestone = HFetch($milestone_sth);

   return $milestone->{'milestone_id'} ne "";
}

sub select_milestone
{
   my $id = shift;

   my $statement = "SELECT 
milestone_id,milestone_name,milestone_desc,milestone_note,milestone_status,milestone_type                 
		FROM milestone
                 WHERE milestone_id = $id";
   my $sth = Execute($statement,$dbh);

   $milestone = HFetchone($sth);

   return $milestone->{'milestone_id'} ne "";
}

sub insert_milestone
{
   $milestone->{'milestone_name'} = $dbh->quote($milestone->{'milestone_name'});
   $milestone->{'milestone_desc'} = $dbh->quote($milestone->{'milestone_desc'});
   $milestone->{'milestone_note'} = $dbh->quote($milestone->{'milestone_note'});

   my $statement = "INSERT INTO milestone ( 
milestone_id,milestone_name,milestone_desc,milestone_note,milestone_status,milestone_type
	)
	VALUES (
$milestone->{'milestone_id'},$milestone->{'milestone_name'},$milestone->{'milestone_desc'},$milestone->{'milestone_note'},$milestone->{'milestone_status'},$milestone->{'milestone_type'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(milestone_id) FROM milestone";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_milestone
{
    my $setstr = shift;
    my $statement;

   $milestone->{'milestone_name'} = $dbh->quote($milestone->{'milestone_name'});
   $milestone->{'milestone_desc'} = $dbh->quote($milestone->{'milestone_desc'});
   $milestone->{'milestone_note'} = $dbh->quote($milestone->{'milestone_note'});

    if($setstr)
      {  $statement = "UPDATE milestone SET $setstr WHERE milestone_id = $milestone->{'milestone_id'}";  }
    else
      {
        $statement = "UPDATE milestone SET
		milestone_id = $milestone->{'milestone_id'},
		milestone_name = $milestone->{'milestone_name'},
		milestone_desc = $milestone->{'milestone_desc'},
		milestone_note = $milestone->{'milestone_note'},
		milestone_status = $milestone->{'milestone_status'},
		milestone_type = $milestone->{'milestone_type'}               
		WHERE milestone_id = $milestone->{'milestone_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_milestone
{
my $id = shift;

my $statement = "DELETE FROM milestone
                 WHERE milestone_id = $id";

Execute($statement,$dbh);

return;
}

1;
