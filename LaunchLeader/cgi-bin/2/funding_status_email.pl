#!/usr/bin/perl

use Email::Stuff;
use lib '/lamp/vhosts/application/vlaunchleader/cgi-bin/2';
use Launchleader;
use strict;

my $EMAIL = 'nseet@sivi.com,akamal@sivi.com,zulker@sivi.com';
my $FROM = 'info@launchleader.com';
my $SUBJECT = 'LL Daily Funding Status';
my $mailoutput = `/usr/bin/perl /lamp/vhosts/application/vlaunchleader/cgi-bin/2/funding_status.cgi u=admin\@launchh.com p=.vXne5dtTKEP. stage=2`; 

Email::Stuff->to($EMAIL)
            ->from($FROM)
            ->subject($SUBJECT)
            ->html_body($mailoutput)
            ->send;
