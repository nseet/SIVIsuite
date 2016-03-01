sub read_package_detail
{

   $package_detail->{'package_detail_id'} = clean('int', $_query->param('package_detail_id'));
   $package_detail->{'package_id'} = clean('int', $_query->param('package_id'));
   $package_detail->{'account_id'} = clean('int', $_query->param('account_id'));
   $package_detail->{'package_detail_datetime'} = $_query->param('package_detail_datetime');

   return;
}

sub select_package_details
{
   my $where = shift;

   my $statement = "SELECT
package_detail.package_detail_id,package_detail.package_id,package_detail.account_id,package_detail.package_detail_datetime         
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
   my $id = shift;

   my $statement = "SELECT 
package_detail_id,package_id,account_id,package_detail_datetime                 
		FROM package_detail
                 WHERE package_detail_id = $id";
   my $sth = Execute($statement,$dbh);

   $package_detail = HFetchone($sth);

   return $package_detail->{'package_detail_id'} ne "";
}

sub insert_package_detail
{

   my $statement = "INSERT INTO package_detail ( 
package_detail_id,package_id,account_id,package_detail_datetime
	)
	VALUES (
$package_detail->{'package_detail_id'},$package_detail->{'package_id'},$package_detail->{'account_id'},NOW()
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


    if($setstr)
      {  $statement = "UPDATE package_detail SET $setstr WHERE package_detail_id = $package_detail->{'package_detail_id'}";  }
    else
      {
        $statement = "UPDATE package_detail SET
		package_detail_id = $package_detail->{'package_detail_id'},
		package_id = $package_detail->{'package_id'},
		account_id = $package_detail->{'account_id'},
		package_detail_datetime = NOW()               
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
