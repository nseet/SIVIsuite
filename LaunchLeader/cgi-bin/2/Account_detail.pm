sub read_account_detail
{

   $account_detail->{'account_detail_id'} = clean('int', $_query->param('account_detail_id'));
   $account_detail->{'detail_id'} = clean('int', $_query->param('detail_id'));
   $account_detail->{'account_id'} = clean('int', $_query->param('account_id'));
   $account_detail->{'account_detail_name'} = $_query->param('account_detail_name');
   $account_detail->{'account_detail_desc'} = $_query->param('account_detail_desc');
   $account_detail->{'account_detail_note'} = $_query->param('account_detail_note');
   $account_detail->{'account_detail_type'} = clean('int', $_query->param('account_detail_type'));
   $account_detail->{'account_detail_status'} = clean('int', $_query->param('account_detail_status'));

   return;
}

sub select_account_details
{
   my $where = shift;

   my $statement = "SELECT
account_detail.account_detail_id,account_detail.detail_id,account_detail.account_id,account_detail.account_detail_name,account_detail.account_detail_desc,account_detail.account_detail_note,account_detail.account_detail_type,account_detail.account_detail_status         
	FROM account_detail
         $where";

   $account_detail_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_detail
{
   $account_detail = HFetch($account_detail_sth);

   return $account_detail->{'account_detail_id'} ne "";
}

sub select_account_detail
{
   my $id = shift;

   my $statement = "SELECT 
account_detail_id,detail_id,account_id,account_detail_name,account_detail_desc,account_detail_note,account_detail_type,account_detail_status                 
		FROM account_detail
                 WHERE account_detail_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_detail = HFetchone($sth);

   return $account_detail->{'account_detail_id'} ne "";
}

sub insert_account_detail
{
   $account_detail->{'account_detail_name'} = $dbh->quote($account_detail->{'account_detail_name'});
   $account_detail->{'account_detail_desc'} = $dbh->quote($account_detail->{'account_detail_desc'});
   $account_detail->{'account_detail_note'} = $dbh->quote($account_detail->{'account_detail_note'});

   my $statement = "INSERT INTO account_detail ( 
account_detail_id,detail_id,account_id,account_detail_name,account_detail_desc,account_detail_note,account_detail_type,account_detail_status
	)
	VALUES (
$account_detail->{'account_detail_id'},$account_detail->{'detail_id'},$account_detail->{'account_id'},$account_detail->{'account_detail_name'},$account_detail->{'account_detail_desc'},$account_detail->{'account_detail_note'},$account_detail->{'account_detail_type'},$account_detail->{'account_detail_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_detail_id) FROM account_detail";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_detail
{
    my $setstr = shift;
    my $statement;

   $account_detail->{'account_detail_name'} = $dbh->quote($account_detail->{'account_detail_name'});
   $account_detail->{'account_detail_desc'} = $dbh->quote($account_detail->{'account_detail_desc'});
   $account_detail->{'account_detail_note'} = $dbh->quote($account_detail->{'account_detail_note'});

    if($setstr)
      {  $statement = "UPDATE account_detail SET $setstr WHERE account_detail_id = $account_detail->{'account_detail_id'}";  }
    else
      {
        $statement = "UPDATE account_detail SET
		account_detail_id = $account_detail->{'account_detail_id'},
		detail_id = $account_detail->{'detail_id'},
		account_id = $account_detail->{'account_id'},
		account_detail_name = $account_detail->{'account_detail_name'},
		account_detail_desc = $account_detail->{'account_detail_desc'},
		account_detail_note = $account_detail->{'account_detail_note'},
		account_detail_type = $account_detail->{'account_detail_type'},
		account_detail_status = $account_detail->{'account_detail_status'}               
		WHERE account_detail_id = $account_detail->{'account_detail_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_detail
{
my $id = shift;

my $statement = "DELETE FROM account_detail
                 WHERE account_detail_id = $id";

Execute($statement,$dbh);

return;
}

1;
