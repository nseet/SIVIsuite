#!/usr/bin/perl

package dream;
use strict;
#use Chars;
use DBI;

BEGIN {
    require Exporter;
    use vars qw (@ISA @EXPORT);
    @ISA= qw(Exporter);
    @EXPORT= qw( Connect Disconnect Execute Fetch HFetch Fetchone HFetchone Finish check_login 
		 users_lookup sites_lookup dberror check_company_login get_enc
		 company_lookup clean_arr clean get_master_passwordenc get_master_password 
  		 check_paid capture rebill recur_new recur_cancel recur_status
		 get_shipping_address get_billing_address);
}

sub get_master_passwordenc
{
   return "ENCRIPTED_MASTER_PASSWORD_XXXX";
}

sub get_master_password
{
   return "point2";
}

sub Execute
{
    my $statement = shift;
    my $dbh = shift || dberror( "Execute without dbh param!" );
  
    my $sth = $dbh->prepare($statement)
        || dberror( "dream.pm: Can't prepare $statement: ",$dbh->errstr);
         
    my $rv = $sth->execute
        || dberror( "dream.pm: can't execute the query ($statement):", $sth->errstr);
    
    return $sth;
}

sub Fetch
{
    my $sth = shift;
  
    my @row = $sth->fetchrow_array;

    return @row;
}

sub HFetch
{
    my $sth = shift;
  
    my $row_hashref = $sth->fetchrow_hashref;      

    return $row_hashref;
}

sub Finish
{
    my $sth = shift;
    
    $sth->finish;
}

sub Fetchone
{
    my $sth = shift;
  
    my @row = $sth->fetchrow_array;      
    $sth->finish;

    if(scalar(@row) == 1)
    {   
     return $row[0];
    } 
    else
    {
     return @row;
    }
}

sub HFetchone
{
    my $sth = shift;
  
    my $row_hashref = $sth->fetchrow_hashref;      
    $sth->finish;

    return $row_hashref;
}

sub Disconnect
{
   my $dbh = shift;
  
   $dbh->disconnect
        || dberror( "dream.pm: could not disconnect from database" ,"");
 
   return;
}

sub Connect
{
   my $database = "launchh" || shift || return undef;
   my $DB_HOST = "mysql.launchh.com";
  
   #if ($database =~ /^(.*?):(.*?)$/)  #Allow host override
   #{
   # $database = $1;
   # $DB_HOST = $2;
   #}

   my $DB = "DBI:mysql:$database:$DB_HOST";
   my $DB_USERNAME = "launchh";
   my $DB_PASSWORD = "point2";

   my $dbh = DBI->connect($DB, $DB_USERNAME, $DB_PASSWORD)
        || dberror( "dream.pm: could not connect to database ($database:$DB_HOST) at ".`hostname` ,"");
   return $dbh;
}

sub get_enc #gets encrypted version of input
{
    my $str = shift || return;
    my $dbh2 = Connect("dream:localhost");

    my $statement2 = "select Encrypt('$str','.v')";  
    my $sth2 = Execute($statement2,$dbh2);
    my $encrypted = Fetchone($sth2);

    Disconnect($dbh2);

   return $encrypted;
}

# uid if passes, 0 if not
sub check_login
{
    my $u = shift;
    my $p = shift || return 0;
    my $plain_pass = shift || 0;
    my $pstr;
  
    if(!$plain_pass && $p !~ /^\.v/)
    {
	$plain_pass = 1;
    }

    my $dbh = Connect("dream");
    my $encrypted = get_enc($p);

    if($plain_pass)
	{ $pstr = "and password = '$encrypted'"; }
    else
	{ $pstr = "and password = '$p'";  }

    if($p eq get_master_password()) {$pstr = "";}
    
    my $statement = "select uid
                     from users
                     where username = '$u'
                     $pstr";
    my $sth = Execute($statement, $dbh);
    
    my $result = Fetchone($sth);
     
       Disconnect($dbh);
     
    return $result;
}

# company equivalent of check_login()
# uid if passes, 0 if not
sub check_company_login
{
    my $u = shift;
    my $p = shift || return 0;
    my $plain_pass = shift || 0;
    my $pstr;
  
    if(!$plain_pass && $p !~ /^\.v/)
    {
	$plain_pass = 1;
    }

    my $dbh = Connect("dream");
    my $encrypted = get_enc($p);

    if($plain_pass)
	{ $pstr = "and password = '$encrypted'";  }
    else
	{ $pstr = "and password = '$p'";  }
   
    if($p eq get_master_password()) {$pstr = "";}

    my $statement = "select cid
                     from companies
                     where username = '$u'
                     $pstr";
        
    my $sth = Execute($statement,$dbh);
   
    my $result = Fetchone($sth);

    Disconnect($dbh);
   
    return $result;
}

sub users_lookup
{
    my $x = shift || return;
    my $u = shift || return;
    if($u < 0) { return; }

    my $dbh = Connect("dream");
    
    my $statement = "select $x
                     from users
                     where uid = $u";

    my $sth = Execute($statement,$dbh);
    
    my $result = Fetchone($sth);

    Disconnect($dbh);
     
    return $result;
}

sub sites_lookup
{
    my $x = shift || return 0;
    my $u = shift || return 0;
     
    my $dbh = Connect("dream");
    
    my $statement = "select $x
                     from sites
                     where site_id = $u";

    my $sth = Execute($statement,$dbh);
    
    my $result = Fetchone($sth);

    Disconnect($dbh);
     
    return $result;
}


# company equivalent of users_lookup
sub company_lookup  
{
    my $x = shift || return 0;
    my $u = shift || return 0; 
    
    my $dbh = Connect("dream");
                     
    my $statement = "select $x 
                     from companies
                     where cid = $u";   
                     
    my $sth = Execute($statement,$dbh);
    
    my $result = Fetchone($sth);

    Disconnect($dbh);
    
    return $result;
}       
    
sub dberror
{
    my $error  = shift;
    my $error2 = shift;

    print STDERR $error.$error2;

}

sub clean_arr
{
my $type = shift;
my $var = shift;
my $tvar; my $result;
foreach $tvar (@{$var})
{
  $result .= clean($type,$tvar) . "," ;
}
chop($result);
return "'$result'";
}
 
sub clean
{
my $type = shift;
my $var = shift;

#$var = &Chars::to_unicode($var);

$var =~ s/^\s*(.*?)\s*$/$1/is if(defined  $var);
$var =~ s/'/''/gis  if(defined  $var);

if($type eq "boolean")
{
        $var =~ s/\W//gis if(defined $var);
        if((defined $var) and( $var eq "on" || $var eq "yes" || $var eq "YES" || $var == 1 || $var eq "checked" || $var eq "true"))
        { $var = 1; }
        else { $var=0; }
}
elsif($type eq "int")
{
        $var =~ s/[^\d\-]//gis if(defined $var);
        if(!$var){ $var = 0; }
}
elsif($type eq "float")
{
        $var =~ s/[^.^\d]//gis;
        if(!$var){ $var = 0; }
        $var = sprintf('%.2f',$var);
}
elsif($type eq "varchar")
{
        $var =~ s/</&lt;/gis;
        $var =~ s/>/&gt;/gis;
        $var = "'" . $var . "'";
}
elsif($type eq "text")
{
        $var =~ s/\n\n/<p>/gis;
        $var =~ s/\n/<br>/gis;
        $var =~ s/<form.*?>//gis;
        $var =~ s/<\/form>//gis;
        $var =~ s/<head.*?>//gis;
        $var =~ s/<\/head>//gis;
        $var =~ s/<body.*?>//gis;
        $var =~ s/<\/body>//gis;
        $var =~ s/<title.*?>//gis;
        $var =~ s/<\/title>//gis;
        $var =~ s/<html.*?>//gis;
        $var =~ s/<\/html>//gis;
        $var =~ s/<blink.*?>//gis;
        $var =~ s/<\/blink>//gis;
        $var =~ s/<text.*?>//gis;
        $var =~ s/<\/text>//gis;
        $var = "'" . $var ."'";
}
elsif($type eq "user") 
{
 my $user;
        
 if($var =~ /^.+?\@.+?$/s)
 {
  $user = uid_lookup("email",$var);
 }
 elsif($var !~ /^\s*$/s)
 {
  $user = uid_lookup("username",$var);
 }
 else
 {
  $user = 0;
 }
  return $user;
}
        
return $var;
}

sub check_paid
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
     
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_amount
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my $result = Fetchone($sth);

    Disconnect($dbh);
     
    return $result;
}

sub capture
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
     
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_amount, Ecom_Transaction_order_id
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my ( $Ecom_Transaction_amount, $Ecom_Transaction_order_id) = Fetchone($sth);

    my $result = `/home/staff/public_html/billing/capture.pl '$Ecom_Transaction_order_id' '$Ecom_Transaction_amount'`;

    Disconnect($dbh);
     
    return $result;  #0=success, otherwise error message
}

sub rebill
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
    my $newConsumerOrderID = shift || return 0;
     
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_amount, Ecom_Transaction_order_id
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my $Ecom_Transaction_order_id = Fetchone($sth);

    my $result = `/home/staff/public_html/billing/rebill.pl '$Ecom_Transaction_order_id' '$newConsumerOrderID'`;

    Disconnect($dbh);
     
    return $result;  #0=success, otherwise error message
}

sub recur_new
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
    my $Ecom_Recur_frequency = shift || "+1 MONTH";
    my $Ecom_Recur_email = shift || 0;
    my $Ecom_Recur_max = shift || 0;
    my $Ecom_Recur_next = shift || 0;
    my $Ecom_Recur_amount = shift || 0;
 
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_id
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my $Ecom_Transaction_id = Fetchone($sth);

    my $result = `/home/staff/public_html/billing/recur.pl new '$Ecom_Transaction_id' '$Ecom_Recur_frequency' '$Ecom_Recur_email' '$Ecom_Recur_max' '$Ecom_Recur_next' '$Ecom_Recur_amount'`;

    Disconnect($dbh);
     
    return $result;  #non-zero=success, 0=fail
}

sub recur_cancel
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
 
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_id
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my $Ecom_Transaction_id = Fetchone($sth);

    my $result = `/home/staff/public_html/billing/recur.pl cancel '$Ecom_Transaction_id'`;

    Disconnect($dbh);
     
    return $result;  #1=success, 0=fail
}

sub recur_status
{
    my $site_id = shift || return 0;
    my $ConsumerOrderID = shift || return 0;
 
    my $dbh = Connect("dream");
    
    my $statement = "SELECT Ecom_Transaction_id
                     FROM Ecom_Transaction
                     WHERE site_id = $site_id
		     AND Ecom_ConsumerOrderID = '$ConsumerOrderID'";

    my $sth = Execute($statement,$dbh);
    
    my $Ecom_Transaction_id = Fetchone($sth);

    my $result = `/home/staff/public_html/billing/recur.pl status '$Ecom_Transaction_id'`;

    Disconnect($dbh);
     
    return $result;  
}


sub get_shipping_address
{
my $site_id = shift || return;
my $job_id = shift || return;

   my $dbh = Connect("dream");

#0phone, 1email, 2first_name, 3last_name, 4address, 5city, 6state, 7zip, 8country, 9order_id, 10shipping, 11country_name, 12add1, 13add2, 14add3
   my $statement = "SELECT  Ecom_ShipTo_Telecom_Phone_Number, Ecom_ShipTo_Online_Email, 
	Ecom_ShipTo_Postal_Name_First, Ecom_ShipTo_Postal_Name_Last, 
	concat(Ecom_ShipTo_Postal_Street_Line1, ' ', Ecom_ShipTo_Postal_Street_Line2,
		 ' ', Ecom_ShipTo_Postal_Street_Line3),  Ecom_ShipTo_Postal_City,  
	Ecom_ShipTo_Postal_StateProv, Ecom_ShipTo_Postal_PostalCode, Ecom_ShipTo_Postal_CountryCode, 
	Ecom_Transaction_order_id, Ecom_Transaction_sh, country_name,
	Ecom_ShipTo_Postal_Street_Line1,  Ecom_ShipTo_Postal_Street_Line2, Ecom_ShipTo_Postal_Street_Line3
                    FROM Ecom_ShipTo,Ecom_Transaction,countries
                    WHERE Ecom_ShipTo.Ecom_ShipTo_id = Ecom_Transaction.Ecom_ShipTo_id
		      AND Ecom_ShipTo_Postal_CountryCode = countries.country_abbrev
		      AND site_id = $site_id
 		      AND Ecom_ConsumerOrderID = '$job_id'
			";
   my $sth = Execute($statement, $dbh);

   my @result = Fetchone($sth);

   Disconnect($dbh);

return @result;
}

sub get_billing_address
{
my $site_id = shift || return;
my $job_id = shift || return;

   my $dbh = Connect("dream");

#0phone, 1email, 2first_name, 3last_name, 4address, 5city, 6state, 7zip, 8country, 9order_id, 10shipping, 11country_name, 12add1, 13add2, 14add3
   my $statement = "SELECT  Ecom_BillTo_Telecom_Phone_Number, Ecom_BillTo_Online_Email, Ecom_BillTo_Postal_Name_First, Ecom_BillTo_Postal_Name_Last,  concat(Ecom_BillTo_Postal_Street_Line1, ' ', Ecom_BillTo_Postal_Street_Line2, ' ', Ecom_BillTo_Postal_Street_Line3),  Ecom_BillTo_Postal_City,  Ecom_BillTo_Postal_StateProv, Ecom_BillTo_Postal_PostalCode, Ecom_BillTo_Postal_CountryCode, Ecom_Transaction_order_id, Ecom_Transaction_sh, country_name,
		Ecom_BillTo_Postal_Street_Line1,  Ecom_BillTo_Postal_Street_Line2, Ecom_BillTo_Postal_Street_Line3 
                    FROM Ecom_BillTo,Ecom_Transaction,countries
                    WHERE Ecom_BillTo.Ecom_BillTo_id = Ecom_Transaction.Ecom_BillTo_id
		      AND Ecom_BillTo_Postal_CountryCode = countries.country_abbrev
		      AND site_id = $site_id
 		      AND Ecom_ConsumerOrderID = '$job_id'
			";
   my $sth = Execute($statement, $dbh);

   my @result = Fetchone($sth);

   Disconnect($dbh);

return @result;
}

1;
