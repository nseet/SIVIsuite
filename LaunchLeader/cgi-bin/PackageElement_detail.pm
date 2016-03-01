
sub read_element_detail
{

   $element_detail->{'element_detail_id'} = clean('int', $_query->param('element_detail_id'));
   $element_detail->{'element_id'} = clean('int', $_query->param('element_id'));
   $element_detail->{'account_id'} = $_query->param('account_id');
   $element_detail->{'element_detail_disbursed'} = $_query->param('element_detail_disbursed');
   $element_detail->{'element_detail_datetime'} = $_query->param('element_detail_datetime');
   
   return;
}

sub select_element_details
{
   my $where = shift;

   my $statement = "SELECT 
   element_detail.element_id,element_detail.account_id,element_detail.element_detail_id,element_detail.element_detail_status,element_detail.element_detail_disbursed,element_detail.element_detail_datetime
	FROM element_detail
         $where";

   $element_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub select_element_detail
{
   my $eid = shift;
   my $aid = shift;

   my $statement = "SELECT 
   element_detail.element_id,element_detail.account_id,element_detail.element_detail_id,element_detail.element_detail_status,element_detail.element_detail_disbursed,element_detail.element_detail_datetime
	FROM element_detail
                 WHERE element_id = $eid AND
                 account_id = $aid 
		 ";
   my $sth = Execute($statement,$dbh);

   $element_detail = HFetchone($sth);

   return $element_detail->{'element_id'} ne "";
}

sub next_element_detail
{
   $element_detail = HFetch($element_detail_sth);

   return $element_detail->{'element_detail_id'} ne "";
}


sub insert_element_detail
{
   $element_detail->{'element_detail_id'} = $dbh->quote($element_detail->{'element_detail_id'});
   $element_detail->{'element_id'} = $dbh->quote($element_detail->{'element_id'});
   $element_detail->{'account_id'} = $dbh->quote($element_detail->{'account_id'});
   $element_detail->{'element_detail_status'} = $dbh->quote($element_detail->{'element_detail_status'});   
   #$element_detail->{'element_detail_datetime'} = $dbh->quote($element_detail->{'element_detail_datetime'});

   my $statement = "INSERT INTO element_detail ( 
		element_detail_id,element_id,account_id,element_detail_status,element_detail_disbursed,  element_detail_datetime
		)
	VALUES (
		$element_detail->{'element_detail_id'},$element_detail->{'element_id'},$element_detail->{'account_id'},$element_detail->{'element_detail_status'},0,  NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_detail_id) FROM element_detail";
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
   $element_detail->{'element_detail_status'} = $dbh->quote($element_detail->{'element_detail_status'});   
   $element_detail->{'element_detail_disbursed'} = $dbh->quote($element_detail->{'element_detail_disbursed'});   
   $element_detail->{'element_detail_datetime'} = $dbh->quote($element_detail->{'element_detail_datetime'});

    if($setstr)
      {  $statement = "UPDATE element_detail SET $setstr WHERE element_detail_id = $element_detail->{'element_detail_id'}";  }
    else
      {
        $statement = "UPDATE element_detail SET
        element_id = $element_detail->{'element_id'},
        element_detail_id = $element_detail->{'element_detail_id'},
        account_id = $element_detail->{'account_id'},
        element_detail_status = $element_detail->{'element_detail_status'},
        element_detail_datetime = $element_detail->{'element_detail_datetime'}
        WHERE element_detail_id = $element_detail->{'element_detail_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub update_all_element_detail
{
    my $setstr = shift;
    my $account_id = shift;

    if($setstr){  
	$statement = "UPDATE element_detail SET $setstr WHERE account_id = '$account_id'";  
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


sub read_package_detail
{

   $package_detail->{'package_detail_id'} = clean('int', $_query->param('package_detail_id'));
   $package_detail->{'package_id'} = clean('int', $_query->param('package'));
   $package_detail->{'account_id'} = $_query->param('account_id');
   $package_detail->{'package_detail_datetime'} = $_query->param('package_detail_datetime');
   
   return;
}

sub select_package_details
{
   my $where = shift;

   my $statement = "SELECT 
   package_detail.package_id,package_detail.account_id,package_detail.package_detail_id,package_detail.package_detail_datetime
	FROM package_detail
         $where";

   $package_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_package_detail
{
   $package_detail = HFetch($package_detail_sth);

   return $package_detail->{'package_detail_id'} ne "";
}


sub select_package_detail
{
   my $pid = shift;
   my $aid = shift;

   my $statement = "SELECT 
   package_detail.package_id,package_detail.account_id,package_detail.package_detail_id,package_detail.package_detail_datetime
	FROM package_detail
                 WHERE package_id = $pid AND
                 account_id = $aid 
		 ";
   my $sth = Execute($statement,$dbh);

   $package_detail = HFetchone($sth);

   return $package_detail->{'package_id'} ne "";
}


sub insert_package_detail
{
   $package_detail->{'package_detail_id'} = $dbh->quote($package_detail->{'package_detail_id'});
   $package_detail->{'package_id'} = $dbh->quote($package_detail->{'package_id'});
   $package_detail->{'account_id'} = $dbh->quote($package_detail->{'account_id'});
   $package_detail->{'package_detail_datetime'} = $dbh->quote($package_detail->{'package_detail_datetime'});

   my $statement = "INSERT INTO package_detail ( 
		package_detail_id,package_id,account_id,package_detail_datetime
		)
	VALUES (
		$package_detail->{'package_detail_id'},$package_detail->{'package_id'},$package_detail->{'account_id'},$package_detail->{'package_detail_datetime'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(package_detail_id) FROM package_detail";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_package_detail
{
    my $setstr = shift;
    my $statement;
    
   $package_detail->{'package_detail_id'} = $dbh->quote($package_detail->{'package_detail_id'});
   $package_detail->{'package_id'} = $dbh->quote($package_detail->{'package_id'});
   $package_detail->{'account_id'} = $dbh->quote($package_detail->{'account_id'});
   $package_detail->{'package_detail_datetime'} = $dbh->quote($package_detail->{'package_detail_datetime'});

    if($setstr)
      {  $statement = "UPDATE package_detail SET $setstr WHERE package_detail_id = $package_detail->{'package_detail_id'}";  }
    else
      {
        $statement = "UPDATE package_detail SET
        package_id = $package_detail->{'package_id'},
        package_detail_id = $package_detail->{'package_detail_id'},
        account_id = $package_detail->{'account_id'},
        package_detail_datetime = $package_detail->{'package_detail_datetime'}
        WHERE package_detail_id = $package_detail->{'package_detail_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_package_detail
{
my $id = shift;

my $statement = "DELETE FROM package_detail
                 WHERE package_detail_id = $id";

Execute($statement,$dbh);

return;
}

1;
