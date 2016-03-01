sub read_email_disburse
{

   $email_disburse->{'email_disburse_id'} = clean('int', $_query->param('email_disburse_id'));
   $email_disburse->{'email_type'} = $_query->param('email_type');
   $email_disburse->{'email_disburse_ref'} = clean('int', $_query->param('email_disburse_ref'));
   $email_disburse->{'email_disburse_status'} = clean('int', $_query->param('email_disburse_status'));
   $email_disburse->{'email_disburse_datetime'} = $_query->param('email_disburse_datetime');

   return;
}

sub select_email_disburses
{
   my $where = shift;

   my $statement = "SELECT
email_disburse.email_disburse_id,email_disburse.email_type,email_disburse.email_disburse_ref,email_disburse.email_disburse_status,email_disburse.email_disburse_datetime         
	FROM email_disburse
         $where";

   $email_disburse_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_email_disburse
{
   $email_disburse = HFetch($email_disburse_sth);

   return $email_disburse->{'email_disburse_id'} ne "";
}

sub select_email_disburse
{
   my $id = shift;

   my $statement = "SELECT 
email_disburse_id,email_type,email_disburse_ref,email_disburse_status,email_disburse_datetime                 
		FROM email_disburse
                 WHERE email_disburse_id = $id";
   my $sth = Execute($statement,$dbh);

   $email_disburse = HFetchone($sth);

   return $email_disburse->{'email_disburse_id'} ne "";
}

sub insert_email_disburse
{
   $email_disburse->{'email_type'} = $dbh->quote($email_disburse->{'email_type'});

   my $statement = "INSERT INTO email_disburse ( 
email_disburse_id,email_type,email_disburse_ref,email_disburse_status,email_disburse_datetime
	)
	VALUES (
$email_disburse->{'email_disburse_id'},$email_disburse->{'email_type'},$email_disburse->{'email_disburse_ref'},$email_disburse->{'email_disburse_status'},NOW()
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(email_disburse_id) FROM email_disburse";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_email_disburse
{
    my $setstr = shift;
    my $statement;

   $email_disburse->{'email_type'} = $dbh->quote($email_disburse->{'email_type'});

    if($setstr)
      {  $statement = "UPDATE email_disburse SET $setstr WHERE email_disburse_id = $email_disburse->{'email_disburse_id'}";  }
    else
      {
        $statement = "UPDATE email_disburse SET
		email_disburse_id = $email_disburse->{'email_disburse_id'},
		email_type = $email_disburse->{'email_type'},
		email_disburse_ref = $email_disburse->{'email_disburse_ref'},
		email_disburse_status = $email_disburse->{'email_disburse_status'},
		email_disburse_datetime = NOW()               
		WHERE email_disburse_id = $email_disburse->{'email_disburse_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_email_disburse
{
my $id = shift;

my $statement = "DELETE FROM email_disburse
                 WHERE email_disburse_id = $id";

Execute($statement,$dbh);

return;
}

1;
