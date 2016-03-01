
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
   my $pid = shift;


   my $statement = "SELECT 
        package.package_id,package.package_name,package.package_desc,package.package_note,package.package_amount,package.package_type,package.package_status
	FROM package
                 WHERE package_id = $eid AND package_id = $pid";
   my $sth = Execute($statement,$dbh);

   $package = HFetchone($sth);

   return $package->{'package_id'} ne "";
}


sub select_elements
{
   my $where = shift;

element.element_completed_note,element.element_completed_placeholder,
   my $statement = "SELECT 
      element.element_id,element.project_id,element.element_name,element.element_desc,element.element_type,element.element_completed_note,element.element_completed_placeholder,element.element_status,element.element_note,element.element_amount 
   FROM element $where";
   
   $element_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_element
{
   $element = HFetch($element_sth);

   return $element->{'element_id'} ne "";
}


sub select_element
{
   my $id = shift;

   my $statement = "SELECT 
		element.element_id,element.project_id,element.element_name,element.element_desc,element.element_type,element.element_completed_note,element.element_completed_placeholder,element.element_status,element.element_note,element.element_amount
  FROM element
                 WHERE element_id = $id";
   my $sth = Execute($statement,$dbh);

   $element = HFetchone($sth);

   return $element->{'element_id'} ne "";
}


sub insert_element
{
   $element->{'element_id'} = $dbh->quote($element->{'element_id'});
   $element->{'project_id'} = $dbh->quote($element->{'project_id'});
   $element->{'element_name'} = $dbh->quote($element->{'element_name'});
   $element->{'element_desc'} = $dbh->quote($element->{'element_desc'});
   $element->{'element_note'} = $dbh->quote($element->{'element_note'});
   $element->{'element_amount'} = $dbh->quote($element->{'element_amount'});
   $element->{'element_type'} = $dbh->quote($element->{'element_type'});
   $element->{'element_status'} = $dbh->quote($element->{'element_status'});

   my $statement = "INSERT INTO element ( 
		element_id, project_id, element_name, element_desc, element_note, element_amount, element_type, element_status
		)
	VALUES (
		$element->{'element_id'}, $element->{'project_id'}, $element->{'element_name'}, $element->{'element_desc'}, $element->{'element_note'}, $element->{'element_amount'}, $element->{'element_type'}, $element->{'element_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_id) FROM element";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

1;
