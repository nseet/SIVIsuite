sub read_category_type
{

   $category_type->{'category_type_id'} = clean('int', $_query->param('category_type_id'));
   $category_type->{'category_type_name'} = $_query->param('category_type_name');

   return;
}

sub select_category_types
{
   my $where = shift;

   my $statement = "SELECT
category_type.category_type_id,category_type.category_type_name         
	FROM category_type
         $where";

   $category_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_category_type
{
   $category_type = HFetch($category_type_sth);

   return $category_type->{'category_type_id'} ne "";
}

sub select_category_type
{
   my $id = shift;

   my $statement = "SELECT 
category_type_id,category_type_name                 
		FROM category_type
                 WHERE category_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $category_type = HFetchone($sth);

   return $category_type->{'category_type_id'} ne "";
}

sub insert_category_type
{
   $category_type->{'category_type_name'} = $dbh->quote($category_type->{'category_type_name'});

   my $statement = "INSERT INTO category_type ( 
category_type_id,category_type_name
	)
	VALUES (
$category_type->{'category_type_id'},$category_type->{'category_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(category_type_id) FROM category_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_category_type
{
    my $setstr = shift;
    my $statement;

   $category_type->{'category_type_name'} = $dbh->quote($category_type->{'category_type_name'});

    if($setstr)
      {  $statement = "UPDATE category_type SET $setstr WHERE category_type_id = $category_type->{'category_type_id'}";  }
    else
      {
        $statement = "UPDATE category_type SET
		category_type_id = $category_type->{'category_type_id'},
		category_type_name = $category_type->{'category_type_name'}               
		WHERE category_type_id = $category_type->{'category_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_category_type
{
my $id = shift;

my $statement = "DELETE FROM category_type
                 WHERE category_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
