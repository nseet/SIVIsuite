sub read_account_element
{

   $account_element->{'account_element_id'} = clean('int', $_query->param('account_element_id'));
   $account_element->{'account_id'} = clean('int', $_query->param('account_id'));
   $account_element->{'element_id'} = clean('int', $_query->param('element_id'));
   $account_element->{'account_element_name'} = $_query->param('account_element_name');
   $account_element->{'account_element_desc'} = $_query->param('account_element_desc');
   $account_element->{'account_element_note'} = $_query->param('account_element_note');
   $account_element->{'account_element_date'} = $_query->param('account_element_date');
   $account_element->{'account_element_type'} = clean('int', $_query->param('account_element_type'));
   $account_element->{'account_element_status'} = clean('int', $_query->param('account_element_status'));

   return;
}

sub select_account_elements
{
   my $where = shift;

   my $statement = "SELECT
account_element.account_element_id,account_element.account_id,account_element.element_id,account_element.account_element_name,account_element.account_element_desc,account_element.account_element_note,account_element.account_element_date,account_element.account_element_type,account_element.account_element_status         
	FROM account_element
         $where";

   $account_element_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_element
{
   $account_element = HFetch($account_element_sth);

   return $account_element->{'account_element_id'} ne "";
}

sub select_account_element
{
   my $id = shift;

   my $statement = "SELECT 
account_element_id,account_id,element_id,account_element_name,account_element_desc,account_element_note,account_element_date,account_element_type,account_element_status                 
		FROM account_element
                 WHERE account_element_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_element = HFetchone($sth);

   return $account_element->{'account_element_id'} ne "";
}

sub insert_account_element
{
   $account_element->{'account_element_name'} = $dbh->quote($account_element->{'account_element_name'});
   $account_element->{'account_element_desc'} = $dbh->quote($account_element->{'account_element_desc'});
   $account_element->{'account_element_note'} = $dbh->quote($account_element->{'account_element_note'});

   my $statement = "INSERT INTO account_element ( 
account_element_id,account_id,element_id,account_element_name,account_element_desc,account_element_note,account_element_date,account_element_type,account_element_status
	)
	VALUES (
$account_element->{'account_element_id'},$account_element->{'account_id'},$account_element->{'element_id'},$account_element->{'account_element_name'},$account_element->{'account_element_desc'},$account_element->{'account_element_note'},NOW(),$account_element->{'account_element_type'},$account_element->{'account_element_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_element_id) FROM account_element";
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

    if($setstr)
      {  $statement = "UPDATE account_element SET $setstr WHERE account_element_id = $account_element->{'account_element_id'}";  }
    else
      {
        $statement = "UPDATE account_element SET
		account_element_id = $account_element->{'account_element_id'},
		account_id = $account_element->{'account_id'},
		element_id = $account_element->{'element_id'},
		account_element_name = $account_element->{'account_element_name'},
		account_element_desc = $account_element->{'account_element_desc'},
		account_element_note = $account_element->{'account_element_note'},
		account_element_date = NOW(),
		account_element_type = $account_element->{'account_element_type'},
		account_element_status = $account_element->{'account_element_status'}               
		WHERE account_element_id = $account_element->{'account_element_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_element
{
my $id = shift;

my $statement = "DELETE FROM account_element
                 WHERE account_element_id = $id";

Execute($statement,$dbh);

return;
}

1;
