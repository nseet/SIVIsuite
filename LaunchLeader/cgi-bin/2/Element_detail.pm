sub read_element_detail
{

   $element_detail->{'element_detail_id'} = clean('int', $_query->param('element_detail_id'));
   $element_detail->{'element_id'} = clean('int', $_query->param('element_id'));
   $element_detail->{'account_id'} = clean('int', $_query->param('account_id'));
   $element_detail->{'element_detail_status'} = clean('int', $_query->param('element_detail_status'));
   $element_detail->{'element_detail_disbursed'} = clean('int', $_query->param('element_detail_disbursed'));
   $element_detail->{'element_detail_datetime'} = $_query->param('element_detail_datetime');

   return;
}

sub select_element_details
{
   my $where = shift;

   my $statement = "SELECT
element_detail.element_detail_id,element_detail.element_id,element_detail.account_id,element_detail.element_detail_status,element_detail.element_detail_disbursed,element_detail.element_detail_datetime         
	FROM element_detail
         $where";

   $element_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_element_detail
{
   $element_detail = HFetch($element_detail_sth);

   return $element_detail->{'element_detail_id'} ne "";
}

sub select_element_detail
{
   my $id = shift;

   my $statement = "SELECT 
element_detail_id,element_id,account_id,element_detail_status,element_detail_disbursed,element_detail_datetime                 
		FROM element_detail
                 WHERE element_detail_id = $id";
   my $sth = Execute($statement,$dbh);

   $element_detail = HFetchone($sth);

   return $element_detail->{'element_detail_id'} ne "";
}

sub insert_element_detail
{

   my $statement = "INSERT INTO element_detail ( 
element_detail_id,element_id,account_id,element_detail_status,element_detail_disbursed,element_detail_datetime
	)
	VALUES (
$element_detail->{'element_detail_id'},$element_detail->{'element_id'},$element_detail->{'account_id'},$element_detail->{'element_detail_status'},$element_detail->{'element_detail_disbursed'},NOW()
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


    if($setstr)
      {  $statement = "UPDATE element_detail SET $setstr WHERE element_detail_id = $element_detail->{'element_detail_id'}";  }
    else
      {
        $statement = "UPDATE element_detail SET
		element_detail_id = $element_detail->{'element_detail_id'},
		element_id = $element_detail->{'element_id'},
		account_id = $element_detail->{'account_id'},
		element_detail_status = $element_detail->{'element_detail_status'},
		element_detail_disbursed = $element_detail->{'element_detail_disbursed'},
		element_detail_datetime = NOW()               
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
