
sub read_element_detail
{

   $element_detail->{'element_detail_id'} = clean('int', $_query->param('element_detail_id'));
   $element_detail->{'element_id'} = clean('int', $_query->param('element_id'));
   $element_detail->{'account_id'} = $_query->param('account_id');
   $element_detail->{'element_detail_datetime'} = $_query->param('element_detail_datetime');
   
   return;
}



sub select_element_details
{
   my $where = shift;

   my $statement = "SELECT 
   element_detail.element_id,element_detail.account_id,element_detail.element_detail_id,element_detail.element_detail_datetime
	FROM element_detail
         $where";

   $element_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_element
{
   $element_detail = HFetch($element_detail_sth);

   return $element_detail->{'element_detail_id'} ne "" if( defined $element_detail->{'element_detail_id'} ) ;
   return 0;
}

sub select_element_detail
{
   my $eid = shift;
   my $aid = shift;

   my $statement = "SELECT 
   element_detail.element_id,element_detail.account_id,element_detail.element_detail_id,element_detail.element_detail_datetime
	FROM element_detail
                 WHERE element_id = $eid AND
                 account_id = $aid 
		 ";
   my $sth = Execute($statement,$dbh);

   $element_detail = HFetchone($sth);

   return $element_detail->{'element_id'} ne "";
}

sub insert_element_detail
{
   $element_detail->{'element_detail_id'} = $dbh->quote($element_detail->{'element_detail_id'});
   $element_detail->{'element_id'} = $dbh->quote($element_detail->{'element_id'});
   $element_detail->{'account_id'} = $dbh->quote($element_detail->{'account_id'});
   $element_detail->{'element_detail_datetime'} = $dbh->quote($element_detail->{'element_detail_datetime'});

   my $statement = "INSERT INTO element_detail ( 
		element_detail_id,element_id,account_id,element_detail_datetime
		)
	VALUES (
		$element_detail->{'element_detail_id'},$element_detail->{'element_id'},$element_detail->{'account_id'},$element_detail->{'element_detail_datetime'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_detail_id) FROM element";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_element_detail
{
    my $setstr = shift;
    my $statement;
    
   $element_detail->{'element_detail_id'} = $dbh->quote($element_detail->{'element_detail_id'});
   $element_detail->{'element_id'} = $dbh->quote($element_detail->{'element_id'});
   $element_detail->{'account_id'} = $dbh->quote($element_detail->{'account_id'});
   $element_detail->{'element_detail_datetime'} = $dbh->quote($element_detail->{'element_detail_datetime'});

    if($setstr)
      {  $statement = "UPDATE element_detail SET $setstr WHERE element_detail_id = $element_detail->{'element_detail_id'}";  }
    else
      {
        $statement = "UPDATE element_detail SET
        element_id = $element_detail->{'element_id'},
        element_detail_id = $element_detail->{'element_detail_id'},
        account_id = $element_detail->{'account_id'},
        element_detail_datetime = $element_detail->{'element_detail_datetime'}
        WHERE element_detail_id = $element_detail->{'element_detail_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_element_detail
{
my $id = shift;

my $statement = "DELETE FROM element_detail
                 WHERE element_detail_id = $id";

Execute($statement,$dbh);

return;
}

1;
