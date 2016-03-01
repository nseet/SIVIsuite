sub read_category
{

   $category->{'category_id'} = clean('int', $_query->param('category_id'));
   $category->{'category_name'} = $_query->param('category_name');
   $category->{'category_desc'} = $_query->param('category_desc');
   $category->{'category_note'} = $_query->param('category_note');
   $category->{'category_type'} = clean('int', $_query->param('category_type'));
   $category->{'category_status'} = clean('int', $_query->param('category_status'));

   return;
}

sub select_categorys
{
   my $where = shift;

   my $statement = "SELECT
category.category_id,category.category_name,category.category_desc,category.category_note,category.category_type,category.category_status         
	FROM category
         $where";

   $category_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_category
{
   $category = HFetch($category_sth);

   return $category->{'category_id'} ne "";
}

sub select_category
{
   my $id = shift;

   my $statement = "SELECT 
category_id,category_name,category_desc,category_note,category_type,category_status                 
		FROM category
                 WHERE category_id = $id";
   my $sth = Execute($statement,$dbh);

   $category = HFetchone($sth);

   return $category->{'category_id'} ne "";
}

sub insert_category
{
   $category->{'category_name'} = $dbh->quote($category->{'category_name'});
   $category->{'category_desc'} = $dbh->quote($category->{'category_desc'});
   $category->{'category_note'} = $dbh->quote($category->{'category_note'});

   my $statement = "INSERT INTO category ( 
category_id,category_name,category_desc,category_note,category_type,category_status
	)
	VALUES (
$category->{'category_id'},$category->{'category_name'},$category->{'category_desc'},$category->{'category_note'},$category->{'category_type'},$category->{'category_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(category_id) FROM category";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_category
{
    my $setstr = shift;
    my $statement;

   $category->{'category_name'} = $dbh->quote($category->{'category_name'});
   $category->{'category_desc'} = $dbh->quote($category->{'category_desc'});
   $category->{'category_note'} = $dbh->quote($category->{'category_note'});

    if($setstr)
      {  $statement = "UPDATE category SET $setstr WHERE category_id = $category->{'category_id'}";  }
    else
      {
        $statement = "UPDATE category SET
		category_id = $category->{'category_id'},
		category_name = $category->{'category_name'},
		category_desc = $category->{'category_desc'},
		category_note = $category->{'category_note'},
		category_type = $category->{'category_type'},
		category_status = $category->{'category_status'}               
		WHERE category_id = $category->{'category_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_category
{
my $id = shift;

my $statement = "DELETE FROM category
                 WHERE category_id = $id";

Execute($statement,$dbh);

return;
}

1;
