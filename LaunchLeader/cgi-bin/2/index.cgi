#!/usr/bin/perl

use Launchleader;
use strict;

my $stage = $Launchleader::_query->param('stage') || 0;
my $mode = $Launchleader::_query->param('mode') || "view";

&Launchleader::do_check_login();
&Launchleader::select_account($Launchleader::uid);
&Launchleader::clean_exit if($Launchleader::account->{'account_username'} ne 'admin@launchh.com');

   print $Launchleader::_query->header();
   print &Launchleader::html_header($Launchleader::HFILE);
   print html_stage0();
   print &Launchleader::html_footer($Launchleader::HFILE);

&Launchleader::clean_exit();

sub html_stage0
{
my $account_count = &Launchleader::count_table("account","WHERE account_status > 0");
my $account_vcount = &Launchleader::count_table("account","WHERE account_status > 0 AND account_verified = 1");
my $account_funders_count = &Launchleader::count_table("account_funder","");
my $account_detail_count = &Launchleader::count_table("account_detail","");
my $element_count = &Launchleader::count_table("element","");
my $funding_details_count = &Launchleader::count_table("funding_details","WHERE funding_details_status=1");
my $funding_details_sum = int(&Launchleader::sum_table("funding_details","fund_amount","WHERE funding_details_status=1")/100);
my $funding_milestones_count = &Launchleader::count_table("funding_milestones","");
my $completed_tools_count = &Launchleader::count_table("completed_tools","");
my $stripe_customers_count = &Launchleader::count_table("stripe_customers","");


my $str = << "EOM";
<table><tr>
<td>
<li><a href="https://vip.launchleader.com/cgi-bin/2/accounts.cgi?stage=2&order_by=account_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$account_count Accounts (our users, $account_vcount verified)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/account_funders.cgi?stage=2&order_by=account_funder_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$account_funders_count Account Funders (our funderss)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/account_details.cgi?stage=2&order_by=account_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$account_detail_count Account & Idea Details (our users and project details)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/elements.cgi?stage=2&$Launchleader::HSTR">$element_count Elements (what gets funded)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/funding_detailss.cgi?stage=2&order_by=funding_details_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$funding_details_count Funding Details (who funded what when; \$$funding_details_sum raised)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/funding_milestoness.cgi?stage=2&order_by=funding_milestones_id&order_dir=ASC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$funding_milestones_count Funding Milestones (who has achieved full funding of an element)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/completed_toolss.cgi?stage=2&order_by=completed_tools_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$completed_tools_count Completed Tools (the user entered text about their funded campaigns)</a><br>
<li><a href="https://vip.launchleader.com/cgi-bin/2/stripe_customerss.cgi?stage=2&order_by=customer_id&order_dir=DESC&limit=25&offset=0&$Launchleader::HSTR&WHERE=WHERE%201%3D1%20">$stripe_customers_count Stripe Customers (accounts connected with Stripe)</a><br>
</td>
<td>
<a href="/cgi-bin/2/funding_status.cgi?$Launchleader::HSTR&stage=2" target=_blank>Open Funding Status Console</a><br>
<a href="/admin/dashboard?$Launchleader::HSTR" target=_blank>Open Payments Dashboard</a><br>
<a href="http://mailchimp.com" target=_blank>Open MailChimp List Management</a><br>

</td>
</tr></table>
<iframe width=100% height=800 src="https://vip.launchleader.com/account?$Launchleader::HSTR"></iframe>
EOM
   
return $str;
   
}


