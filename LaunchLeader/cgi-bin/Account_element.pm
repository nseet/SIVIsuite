
sub read_account_element
{

   $account_element->{'account_id'} = clean('int', $_query->param('account_id'));
   $account_element->{'element_id'} = clean('int', $_query->param('element_id'));
   $account_element->{'account_element_name'} = $_query->param('account_element_name');
   $account_element->{'account_element_desc'} = $_query->param('account_element_desc');
   $account_element->{'account_element_note'} = $_query->param('account_element_note');
   $account_element->{'account_element_date'} = $_query->param('account_element_date');
   $account_element->{'account_element_type'} = $_query->param('account_element_type');
   $account_element->{'account_element_status'} = $_query->param('account_element_status');
   
   return;
}

sub select_account_elements
{
   my $where = shift;

   my $statement = "SELECT 
   account_element.element_id,account_element.account_id,account_element.account_element_name,account_element.account_element_desc,account_element.account_element_note,account_element.account_element_date,account_element.account_element_type,account_element.account_element_status
	FROM account_element
         $where";

   $account_element_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_element
{
   $account_element = HFetch($account_element_sth);

   return $account_element->{'element_id'} ne "";
}

sub select_account_element
{
   my $eid = shift;
   my $aid = shift;

   my $statement = "SELECT 
account_element.element_id,account_element.account_id,account_element.account_element_name,account_element.account_element_desc,account_element.account_element_note,account_element.account_element_date,account_element.account_element_type,account_element.account_element_status
	FROM account_element
                 WHERE element_id = $eid AND account_id = $aid";
   my $sth = Execute($statement,$dbh);

   $account_element = HFetchone($sth);

   return $account_element->{'element_id'} ne "";
}


sub insert_account_element
{
   $account_element->{'element_id'} = $dbh->quote($account_element->{'element_id'});
   $account_element->{'account_id'} = $dbh->quote($account_element->{'account_id'});
   $account_element->{'account_element_name'} = $dbh->quote($account_element->{'account_element_name'});
   $account_element->{'account_element_desc'} = $dbh->quote($account_element->{'account_element_desc'});
   $account_element->{'account_element_note'} = $dbh->quote($account_element->{'account_element_note'});
   $account_element->{'account_element_date'} = $dbh->quote($account_element->{'account_element_date'});
   $account_element->{'account_element_type'} = $dbh->quote($account_element->{'account_element_type'});
   $account_element->{'account_element_status'} = $dbh->quote($account_element->{'account_element_status'});

   my $statement = "INSERT INTO account_element ( 
		account_id,element_id,account_element_name,account_element_desc,account_element_note,account_element_date,account_element_type,account_element_status
	)
	VALUES (
		$account_element->{'account_id'},$account_element->{'element_id'},$account_element->{'account_element_name'},$account_element->{'account_element_desc'},$account_element->{'account_element_note'},$account_element->{'account_element_date'},$account_element->{'account_element_type'},$account_element->{'account_element_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(element_id) FROM element";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_element
{
    my $setstr = shift;
    my $statement;
    

   $account_element->{'account_element_name'} = $dbh->quote($account_element->{'account_element_name'});
   $account_element->{'account_element_desc'} = $dbh->quote($account_element->{'account_element_desc'});
   $account_element->{'account_element_note'} = $dbh->quote($account_element->{'account_element_note'});
   $account_element->{'account_element_date'} = $dbh->quote($account_element->{'account_element_date'});
   $account_element->{'account_element_type'} = $dbh->quote($account_element->{'account_element_type'});
   $account_element->{'account_element_status'} = $dbh->quote($account_element->{'account_element_status'});

    if($setstr)
      {  $statement = "UPDATE account_element SET $setstr WHERE element_id = $account_element->{'element_id'} AND account_id = $account_element->{'account_id'} ";  }
    else
      {
        $statement = "UPDATE account_element SET
        element_id = $account_element->{'element_id'},
        account_id = $account_element->{'account_id'},
        account_element_name = $account_element->{'account_element_name'},
        account_element_desc = $account_element->{'account_element_desc'},
        account_element_note = $account_element->{'account_element_note'},
        account_element_date = $account_element->{'account_element_date'},
        account_element_type = $account_element->{'account_element_type'},
        account_element_status = $account_element->{'account_element_status'}
        WHERE element_id = $account_element->{'element_id'} AND account_id = $account_element->{'account_id'} ";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_element
{
my $eid = shift;
my $aid = shift;

my $statement = "DELETE FROM account_element
                 WHERE
                    element_id = $eid AND account_id = $aid";

Execute($statement,$dbh);

return;
}

1;
