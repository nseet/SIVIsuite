sub read_param
{

   $param->{'param_id'} = clean('int', $_query->param('param_id'));
   $param->{'param_name'} = $_query->param('param_name');
   $param->{'param_value'} = $_query->param('param_value');
   $param->{'param_desc'} = $_query->param('param_desc');

   return;
}

sub select_params
{
   my $where = shift;

   my $statement = "SELECT
param.param_id,param.param_name,param.param_value,param.param_desc         
	FROM param
         $where";

   $param_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_param
{
   $param = HFetch($param_sth);

   return $param->{'param_id'} ne "";
}

sub select_param
{
   my $id = shift;

   my $statement = "SELECT 
param_id,param_name,param_value,param_desc                 
		FROM param
                 WHERE param_id = $id";
   my $sth = Execute($statement,$dbh);

   $param = HFetchone($sth);

   return $param->{'param_id'} ne "";
}

sub insert_param
{
   $param->{'param_name'} = $dbh->quote($param->{'param_name'});
   $param->{'param_value'} = $dbh->quote($param->{'param_value'});
   $param->{'param_desc'} = $dbh->quote($param->{'param_desc'});

   my $statement = "INSERT INTO param ( 
param_id,param_name,param_value,param_desc
	)
	VALUES (
$param->{'param_id'},$param->{'param_name'},$param->{'param_value'},$param->{'param_desc'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(param_id) FROM param";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_param
{
    my $setstr = shift;
    my $statement;

   $param->{'param_name'} = $dbh->quote($param->{'param_name'});
   $param->{'param_value'} = $dbh->quote($param->{'param_value'});
   $param->{'param_desc'} = $dbh->quote($param->{'param_desc'});

    if($setstr)
      {  $statement = "UPDATE param SET $setstr WHERE param_id = $param->{'param_id'}";  }
    else
      {
        $statement = "UPDATE param SET
		param_id = $param->{'param_id'},
		param_name = $param->{'param_name'},
		param_value = $param->{'param_value'},
		param_desc = $param->{'param_desc'}               
		WHERE param_id = $param->{'param_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_param
{
my $id = shift;

my $statement = "DELETE FROM param
                 WHERE param_id = $id";

Execute($statement,$dbh);

return;
}

1;
