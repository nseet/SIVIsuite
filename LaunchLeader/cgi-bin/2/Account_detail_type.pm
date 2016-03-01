sub read_account_detail_type
{

   $account_detail_type->{'account_detail_type_id'} = clean('int', $_query->param('account_detail_type_id'));
   $account_detail_type->{'account_detail_type_name'} = $_query->param('account_detail_type_name');

   return;
}

sub select_account_detail_types
{
   my $where = shift;

   my $statement = "SELECT
account_detail_type.account_detail_type_id,account_detail_type.account_detail_type_name         
	FROM account_detail_type
         $where";

   $account_detail_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_detail_type
{
   $account_detail_type = HFetch($account_detail_type_sth);

   return $account_detail_type->{'account_detail_type_id'} ne "";
}

sub select_account_detail_type
{
   my $id = shift;

   my $statement = "SELECT 
account_detail_type_id,account_detail_type_name                 
		FROM account_detail_type
                 WHERE account_detail_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_detail_type = HFetchone($sth);

   return $account_detail_type->{'account_detail_type_id'} ne "";
}

sub insert_account_detail_type
{
   $account_detail_type->{'account_detail_type_name'} = $dbh->quote($account_detail_type->{'account_detail_type_name'});

   my $statement = "INSERT INTO account_detail_type ( 
account_detail_type_id,account_detail_type_name
	)
	VALUES (
$account_detail_type->{'account_detail_type_id'},$account_detail_type->{'account_detail_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_detail_type_id) FROM account_detail_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_detail_type
{
    my $setstr = shift;
    my $statement;

   $account_detail_type->{'account_detail_type_name'} = $dbh->quote($account_detail_type->{'account_detail_type_name'});

    if($setstr)
      {  $statement = "UPDATE account_detail_type SET $setstr WHERE account_detail_type_id = $account_detail_type->{'account_detail_type_id'}";  }
    else
      {
        $statement = "UPDATE account_detail_type SET
		account_detail_type_id = $account_detail_type->{'account_detail_type_id'},
		account_detail_type_name = $account_detail_type->{'account_detail_type_name'}               
		WHERE account_detail_type_id = $account_detail_type->{'account_detail_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_detail_type
{
my $id = shift;

my $statement = "DELETE FROM account_detail_type
                 WHERE account_detail_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
