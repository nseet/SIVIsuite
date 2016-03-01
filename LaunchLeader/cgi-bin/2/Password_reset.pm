sub read_password_reset
{

   $password_reset->{'password_reset_id'} = clean('int', $_query->param('password_reset_id'));
   $password_reset->{'password_reset_username'} = $_query->param('password_reset_username');
   $password_reset->{'password_reset_token'} = $_query->param('password_reset_token');
   $password_reset->{'password_reset_taken'} = clean('int', $_query->param('password_reset_taken'));
   $password_reset->{'password_reset_expire'} = $_query->param('password_reset_expire');

   return;
}

sub select_password_resets
{
   my $where = shift;

   my $statement = "SELECT
password_reset.password_reset_id,password_reset.password_reset_username,password_reset.password_reset_token,password_reset.password_reset_taken,password_reset.password_reset_expire         
	FROM password_reset
         $where";

   $password_reset_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_password_reset
{
   $password_reset = HFetch($password_reset_sth);

   return $password_reset->{'password_reset_id'} ne "";
}

sub select_password_reset
{
   my $id = shift;

   my $statement = "SELECT 
password_reset_id,password_reset_username,password_reset_token,password_reset_taken,password_reset_expire                 
		FROM password_reset
                 WHERE password_reset_id = $id";
   my $sth = Execute($statement,$dbh);

   $password_reset = HFetchone($sth);

   return $password_reset->{'password_reset_id'} ne "";
}

sub insert_password_reset
{
   $password_reset->{'password_reset_username'} = $dbh->quote($password_reset->{'password_reset_username'});
   $password_reset->{'password_reset_token'} = $dbh->quote($password_reset->{'password_reset_token'});

   my $statement = "INSERT INTO password_reset ( 
password_reset_id,password_reset_username,password_reset_token,password_reset_taken,password_reset_expire
	)
	VALUES (
$password_reset->{'password_reset_id'},$password_reset->{'password_reset_username'},$password_reset->{'password_reset_token'},$password_reset->{'password_reset_taken'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(password_reset_id) FROM password_reset";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_password_reset
{
    my $setstr = shift;
    my $statement;

   $password_reset->{'password_reset_username'} = $dbh->quote($password_reset->{'password_reset_username'});
   $password_reset->{'password_reset_token'} = $dbh->quote($password_reset->{'password_reset_token'});

    if($setstr)
      {  $statement = "UPDATE password_reset SET $setstr WHERE password_reset_id = $password_reset->{'password_reset_id'}";  }
    else
      {
        $statement = "UPDATE password_reset SET
		password_reset_id = $password_reset->{'password_reset_id'},
		password_reset_username = $password_reset->{'password_reset_username'},
		password_reset_token = $password_reset->{'password_reset_token'},
		password_reset_taken = $password_reset->{'password_reset_taken'},
		password_reset_expire = NOW()               
		WHERE password_reset_id = $password_reset->{'password_reset_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_password_reset
{
my $id = shift;

my $statement = "DELETE FROM password_reset
                 WHERE password_reset_id = $id";

Execute($statement,$dbh);

return;
}

1;
