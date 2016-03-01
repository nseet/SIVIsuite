sub read_account_type
{

   $account_type->{'account_type_id'} = clean('int', $_query->param('account_type_id'));
   $account_type->{'account_type_name'} = $_query->param('account_type_name');

   return;
}

sub select_account_types
{
   my $where = shift;

   my $statement = "SELECT
account_type.account_type_id,account_type.account_type_name         
	FROM account_type
         $where";

   $account_type_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_account_type
{
   $account_type = HFetch($account_type_sth);

   return $account_type->{'account_type_id'} ne "";
}

sub select_account_type
{
   my $id = shift;

   my $statement = "SELECT 
account_type_id,account_type_name                 
		FROM account_type
                 WHERE account_type_id = $id";
   my $sth = Execute($statement,$dbh);

   $account_type = HFetchone($sth);

   return $account_type->{'account_type_id'} ne "";
}

sub insert_account_type
{
   $account_type->{'account_type_name'} = $dbh->quote($account_type->{'account_type_name'});

   my $statement = "INSERT INTO account_type ( 
account_type_id,account_type_name
	)
	VALUES (
$account_type->{'account_type_id'},$account_type->{'account_type_name'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(account_type_id) FROM account_type";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_account_type
{
    my $setstr = shift;
    my $statement;

   $account_type->{'account_type_name'} = $dbh->quote($account_type->{'account_type_name'});

    if($setstr)
      {  $statement = "UPDATE account_type SET $setstr WHERE account_type_id = $account_type->{'account_type_id'}";  }
    else
      {
        $statement = "UPDATE account_type SET
		account_type_id = $account_type->{'account_type_id'},
		account_type_name = $account_type->{'account_type_name'}               
		WHERE account_type_id = $account_type->{'account_type_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_account_type
{
my $id = shift;

my $statement = "DELETE FROM account_type
                 WHERE account_type_id = $id";

Execute($statement,$dbh);

return;
}

1;
