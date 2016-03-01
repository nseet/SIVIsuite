sub read_category_status
{

   $category_status->{'category_status_id'} = clean('int', $_query->param('category_status_id'));
   $category_status->{'category_status_name'} = $_query->param('category_status_name');

   return;
}

sub select_category_statuss
{
   my $where = shift;

   my $statement = "SELECT
category_status.category_status_id,category_status.category_status_name         
	FROM category_status
         $where";

   $category_status_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_category_status
{
   $category_status = HFetch($category_status_sth);

   return $category_status->{'category_status_id'} ne "";
}

sub select_category_status
{
   my $id = shift;

   my $statement = "SELECT 
category_status_id,category_status_name                 
		FROM category_status
                 WHERE category_status_id = $id";
   my $sth = Execute($statement,$dbh);

   $category_status = HFetchone($sth);

   return $category_status->{'category_status_id'} ne "";
}

sub insert_category_status
{
   $category_status->{'category_status_name'} = $dbh->quote($category_status->{'category_status_name'});

   my $statement = "INSERT INTO category_status ( 
category_status_id,category_status_name
	)
	VALUES (
$category_status->{'category_status_id'},$category_status->{'category_status_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(category_status_id) FROM category_status";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_category_status
{
    my $setstr = shift;
    my $statement;

   $category_status->{'category_status_name'} = $dbh->quote($category_status->{'category_status_name'});

    if($setstr)
      {  $statement = "UPDATE category_status SET $setstr WHERE category_status_id = $category_status->{'category_status_id'}";  }
    else
      {
        $statement = "UPDATE category_status SET
		category_status_id = $category_status->{'category_status_id'},
		category_status_name = $category_status->{'category_status_name'}               
		WHERE category_status_id = $category_status->{'category_status_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_category_status
{
my $id = shift;

my $statement = "DELETE FROM category_status
                 WHERE category_status_id = $id";

Execute($statement,$dbh);

return;
}

1;
