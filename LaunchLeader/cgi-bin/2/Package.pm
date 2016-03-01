sub read_package
{

   $package->{'package_id'} = clean('int', $_query->param('package_id'));
   $package->{'package_name'} = $_query->param('package_name');
   $package->{'package_desc'} = $_query->param('package_desc');
   $package->{'package_note'} = $_query->param('package_note');
   $package->{'package_amount'} = clean('int', $_query->param('package_amount'));
   $package->{'package_type'} = clean('int', $_query->param('package_type'));
   $package->{'package_status'} = clean('int', $_query->param('package_status'));

   return;
}

sub select_packages
{
   my $where = shift;

   my $statement = "SELECT
package.package_id,package.package_name,package.package_desc,package.package_note,package.package_amount,package.package_type,package.package_status         
	FROM package
         $where";

   $package_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_package
{
   $package = HFetch($package_sth);

   return $package->{'package_id'} ne "";
}

sub select_package
{
   my $id = shift;

   my $statement = "SELECT 
package_id,package_name,package_desc,package_note,package_amount,package_type,package_status                 
		FROM package
                 WHERE package_id = $id";
   my $sth = Execute($statement,$dbh);

   $package = HFetchone($sth);

   return $package->{'package_id'} ne "";
}

sub insert_package
{
   $package->{'package_name'} = $dbh->quote($package->{'package_name'});
   $package->{'package_desc'} = $dbh->quote($package->{'package_desc'});
   $package->{'package_note'} = $dbh->quote($package->{'package_note'});

   my $statement = "INSERT INTO package ( 
package_id,package_name,package_desc,package_note,package_amount,package_type,package_status
	)
	VALUES (
$package->{'package_id'},$package->{'package_name'},$package->{'package_desc'},$package->{'package_note'},$package->{'package_amount'},$package->{'package_type'},$package->{'package_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(package_id) FROM package";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_package
{
    my $setstr = shift;
    my $statement;

   $package->{'package_name'} = $dbh->quote($package->{'package_name'});
   $package->{'package_desc'} = $dbh->quote($package->{'package_desc'});
   $package->{'package_note'} = $dbh->quote($package->{'package_note'});

    if($setstr)
      {  $statement = "UPDATE package SET $setstr WHERE package_id = $package->{'package_id'}";  }
    else
      {
        $statement = "UPDATE package SET
		package_id = $package->{'package_id'},
		package_name = $package->{'package_name'},
		package_desc = $package->{'package_desc'},
		package_note = $package->{'package_note'},
		package_amount = $package->{'package_amount'},
		package_type = $package->{'package_type'},
		package_status = $package->{'package_status'}               
		WHERE package_id = $package->{'package_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_package
{
my $id = shift;

my $statement = "DELETE FROM package
                 WHERE package_id = $id";

Execute($statement,$dbh);

return;
}

1;
