sub read_completed_tools
{

   $completed_tools->{'completed_tools_id'} = clean('int', $_query->param('completed_tools_id'));
   $completed_tools->{'account_id'} = clean('int', $_query->param('account_id'));
   $completed_tools->{'project_id'} = clean('int', $_query->param('project_id'));
   $completed_tools->{'element_id'} = clean('int', $_query->param('element_id'));
   $completed_tools->{'completed_tools_title'} = $_query->param('completed_tools_title');
   $completed_tools->{'completed_tools_url'} = $_query->param('completed_tools_url');
   $completed_tools->{'completed_tools_datetime'} = $_query->param('completed_tools_datetime');

   return;
}

sub select_completed_toolss
{
   my $where = shift;

   my $statement = "SELECT
completed_tools.completed_tools_id,completed_tools.account_id,completed_tools.project_id,completed_tools.element_id,completed_tools.completed_tools_title,completed_tools.completed_tools_url,completed_tools.completed_tools_datetime         
	FROM completed_tools
         $where";

   $completed_tools_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_completed_tools
{
   $completed_tools = HFetch($completed_tools_sth);

   return $completed_tools->{'completed_tools_id'} ne "";
}

sub select_completed_tools
{
   my $id = shift;

   my $statement = "SELECT 
completed_tools_id,account_id,project_id,element_id,completed_tools_title,completed_tools_url,completed_tools_datetime                 
		FROM completed_tools
                 WHERE completed_tools_id = $id";
   my $sth = Execute($statement,$dbh);

   $completed_tools = HFetchone($sth);

   return $completed_tools->{'completed_tools_id'} ne "";
}

sub insert_completed_tools
{
   $completed_tools->{'completed_tools_title'} = $dbh->quote($completed_tools->{'completed_tools_title'});
   $completed_tools->{'completed_tools_url'} = $dbh->quote($completed_tools->{'completed_tools_url'});

   my $statement = "INSERT INTO completed_tools ( 
completed_tools_id,account_id,project_id,element_id,completed_tools_title,completed_tools_url,completed_tools_datetime
	)
	VALUES (
$completed_tools->{'completed_tools_id'},$completed_tools->{'account_id'},$completed_tools->{'project_id'},$completed_tools->{'element_id'},$completed_tools->{'completed_tools_title'},$completed_tools->{'completed_tools_url'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(completed_tools_id) FROM completed_tools";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_completed_tools
{
    my $setstr = shift;
    my $statement;

   $completed_tools->{'completed_tools_title'} = $dbh->quote($completed_tools->{'completed_tools_title'});
   $completed_tools->{'completed_tools_url'} = $dbh->quote($completed_tools->{'completed_tools_url'});

    if($setstr)
      {  $statement = "UPDATE completed_tools SET $setstr WHERE completed_tools_id = $completed_tools->{'completed_tools_id'}";  }
    else
      {
        $statement = "UPDATE completed_tools SET
		completed_tools_id = $completed_tools->{'completed_tools_id'},
		account_id = $completed_tools->{'account_id'},
		project_id = $completed_tools->{'project_id'},
		element_id = $completed_tools->{'element_id'},
		completed_tools_title = $completed_tools->{'completed_tools_title'},
		completed_tools_url = $completed_tools->{'completed_tools_url'},
		completed_tools_datetime = NOW()               
		WHERE completed_tools_id = $completed_tools->{'completed_tools_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_completed_tools
{
my $id = shift;

my $statement = "DELETE FROM completed_tools
                 WHERE completed_tools_id = $id";

Execute($statement,$dbh);

return;
}

1;
