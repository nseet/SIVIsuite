#!/usr/bin/perl

use LWP::Simple;

### Mail Chimp
### http://<dc>.api.mailchimp.com/1.3/?output=json&method=SOME-METHOD&[other parameters]
#lists(string apikey, array filters, int start, int limit) - Retrieve all of the lists defined for your user account 
#listMembers(string apikey, string id, string status, string since, int start, int limit) - Get all of the list members for a list that are of a particular status. 
#listSubscribe(string apikey, string id, string email_address, array merge_vars, string email_type, bool double_optin, bool update_existing, bool replace_interests, bool send_welcome) - Subscribe the provided email to a list.
#listUnsubscribe(string apikey, string id, string email_address, boolean delete_member, boolean send_goodbye, boolean send_notify) - Unsubscribe the given email address from the list
#listUpdateMember(string apikey, string id, string email_address, array merge_vars, string email_type, boolean replace_interests) - Edit the email address, merge fields, and interest groups for a list member. 

my $MC_API_KEY = "217942f33fd98314b21839fcec978b4c-us5";
my $MC_API_EP = "http://us5.api.mailchimp.com/1.3/?output=json&apikey=$MC_API_KEY&method=";

sub mc_lists
{
   my $request_id = shift;
   my $json = shift;

   my $includes = shift;
   my $id = shift;

   my @MailingList;
   my $mc_lists_content = get $MC_API_EP . "lists";
   #{"total":2,"data":[{"id":"5a40b9b54d","web_id":453285,"name":"Test List 1","date_created":"2011-02-15 23:00:01","email_type_option":false,"use_awesomebar":false,"default_from_name":"Test List 1 From","default_from_email":"support@wishform.com","default_subject":"Default subject for Test List 1","default_language":"en","list_rating":0,"stats":{"member_count":15,"unsubscribe_count":0,"cleaned_count":1,"member_count_since_send":0,"unsubscribe_count_since_send":0,"cleaned_count_since_send":0,"campaign_count":2,"grouping_count":0,"group_count":0,"merge_var_count":2,"avg_sub_rate":null,"avg_unsub_rate":null,"target_sub_rate":null,"open_rate":null,"click_rate":null},"modules":[]},{"id":"68ea514bd6","web_id":453281,"name":"WishForm List","date_created":"2011-02-15 22:58:56","email_type_option":false,"use_awesomebar":false,"default_from_name":"WishForm","default_from_email":"support@wishform.com","default_subject":"","default_language":"en","list_rating":0,"stats":{"member_count":1,"unsubscribe_count":0,"cleaned_count":0,"member_count_since_send":1,"unsubscribe_count_since_send":0,"cleaned_count_since_send":0,"campaign_count":1,"grouping_count":0,"group_count":0,"merge_var_count":2,"avg_sub_rate":null,"avg_unsub_rate":null,"target_sub_rate":null,"open_rate":null,"click_rate":null},"modules":[]}]}

   my $mc_lists_json = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($mc_lists_content);
   #print Data::Dumper->Dumper($mc_lists_json);

   my $n = 0;
   foreach my $mc_list (@{$mc_lists_json->{'data'}})
   {  
      #print $mc_list->{'name'} . "\n"
      next if($id && $mc_list->{'id'} ne $id);  #skip record if list id defined and no match

      if($includes || $id)  #only show subscribers if includes or id specified
      {
	  my @subscribers = &mc_subscribers($json,$mc_list->{'id'},$includes,$id); #use mc_list->{'id'} as id may be null
          next if($includes && !@subscribers);  #skip if included email filters but no matchess
	  $MailingList[$n]->{'addresses'} = \@subscribers; 
      }
      else
      {
         $MailingList[$n]->{'addresses'} = undef;
      }
      $MailingList[$n]->{'id'} = $mc_list->{'id'};
      $MailingList[$n]->{'provider'} = "MailChimp";
      $MailingList[$n]->{'name'} = $mc_list->{'name'};	
      $n++
   }   

#   print Data::Dumper->Dumper(@mc_lists_out);

   my %out;
   $out->{'data'} = \@MailingList;
   $out->{'request_id'} = $request_id;

   return;

}


sub mc_subscribers
{
   my $request_id = shift;
   my $json = shift;
   my $mc_list_id = shift;
   my $includes = shift;
   my $id = shift;

   my @subscribers;
   my $mc_list_members_content = get $MC_API_EP . "listMembers&id=$mc_list_id";   
   #print $mc_list_members_content;exit;
   #{"total":15,"data":[{"email":"nik@upwish.com","timestamp":"2011-02-15 23:04:24"},{"email":"nik@wishery.com","timestamp":"2011-02-15 23:04:24"},{"email":"Josh@wishserver.com","timestamp":"2011-02-15 23:09:37"},{"email":"Josh@wishform.com","timestamp":"2011-02-15 23:09:37"},{"email":"Josh@upwish.com","timestamp":"2011-02-15 23:09:37"},{"email":"David@wishserver.com","timestamp":"2011-02-15 23:09:37"},{"email":"David@wishform.com","timestamp":"2011-02-15 23:09:37"},{"email":"David@upwish.com","timestamp":"2011-02-15 23:09:37"},{"email":"David@wishery.com","timestamp":"2011-02-15 23:09:37"},{"email":"Cooper@wishserver.com","timestamp":"2011-02-15 23:09:37"},{"email":"Cooper@wishform.com","timestamp":"2011-02-15 23:09:37"},{"email":"Cooper@upwish.com","timestamp":"2011-02-15 23:09:37"},{"email":"Cooper@wishery.com","timestamp":"2011-02-15 23:09:37"},{"email"[ps22810]$ vi lists 2011-02-15 23:09:37"},{"email":"nik@wishform.com","timestamp":"2011-02-15 23:09:37"}]}

   my $mc_list_members_json = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($mc_list_members_content);
   #print Data::Dumper->Dumper($mc_list_members_json); exit;

   my $n = 0;
   foreach my $mc_list_member (@{$mc_list_members_json->{'data'}})
   {
#      print STDERR $mc_list_member->{'email'} . "\n";
      if($includes && $includes !~ /$mc_list_member->{'emails'}/is)  #skip if includes and no match
      {
         next;
      } 
      elsif($includes && $includes =~ /$mc_list_member->{'email'}/is)
      {
         $subscribers[$n]->{'emailAddress'} = $mc_list_member->{'email'};
         $n++;
      }
      elsif(!$includes)
      {
         $subscribers[$n]->{'emailAddress'} = $mc_list_member->{'email'};
         $n++;
      }
   }

   return if(!$n);  #so we don't have any empty arrays returned
   return (\@subscribers);
}


sub mc_subscribe
{
   my $request_id = shift;
   my $json = shift;
   my $lists_str = shift;        #a required, comma-separated list of list IDs to which the addresses should be added.
   my $subscribers_str = shift;  #    * Serialize using pipes, e.g. david@wishery.com|David Albrecht,nik@wishery.com|Nicholas Seet
 
   my @lists = split(/,/,$lists_str);
   my @subscribers = split(/,/,$subscribers_str);

   my @successes;
   my @failures;
   foreach my $list_id (@lists)
   {
      foreach my $subscriber (@subscribers)
      {
	 if($subscriber =~ /\|/)
	 {
	    @parts = split(/\|/,$subscriber);
	    $subscriber = $parts[0];
	 }
         #print STDERR "$list_id, $subscriber\n";        

   	 my $mc_result = get $MC_API_EP . "listSubscribe&id=$list_id&email_address=$subscriber&double_optin=false";
   	 print STDERR $mc_result;
#	{"error":"Invalid MailChimp List ID: 1","code":200}
# or    {"error":"Invalid Email Address: n","code":502}	
# or    {"error":"nik@wishserver.com is already subscribed to list Test List 1","code":214}
# or    true

	   if($mc_result eq "true")
	   {
		push(@successes,$subscriber);	
	   }
	   else
	   {
		push(@failures,$subscriber);
	   } 
	}
   }
 
   my %ListChangeResult;
   $ListChangeResult->{'successes'} = \@successes;
   $ListChangeResult->{'failures'} = \@failures || undef;
 
   my %out;
   $out->{'data'} = $ListChangeResult;
   $out->{'request_id'} = $request_id;

   return;
}

sub mc_subscribe_all  #add user address to all lists
{
   my $request_id = shift;
   my $json = shift;
   my $subscribers_str= shift;

   my @subscribers = split(/,/,$subscriber_str);

   my @MailingList;
   my $mc_lists_content = get $MC_API_EP . "lists";

   my $mc_lists_json = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($mc_lists_content);
   #print Data::Dumper->Dumper($mc_lists_json);

   my $n = 0;
   foreach my $mc_list (@{$mc_lists_json->{'data'}})
   {
      &mc_subscribe($json,$mc_list->{'id'},$subscribers_str);
   }

   my %ListChangeResult;
   $ListChangeResult->{'successes'} = $subscribers_str ;
   $ListChangeResult->{'failures'} = undef;
   
   my %out; 
   $out->{'data'} = $ListChangeResult;
   $out->{'request_id'} = $request_id;

   return;
}


sub mc_unsubscribe
{
   my $request_id = shift;
   my $lists_str = shift;        #a required, comma-separated list of list IDs to which the addresses should be added.
   my $subscribers_str = shift;  #    * Serialize using pipes, e.g. david@wishery.com|David Albrecht,nik@wishery.com|Nicholas Seet

   my @lists = split(/,/,$lists_str);
   my @subscribers = split(/,/,$subscribers_str);

   my @successes;
   my @failures;
   foreach my $list_id (@lists)
   {
      foreach my $subscriber (@subscribers)
      {
         if($subscriber =~ /\|/)
         {
            @parts = split(/\|/,$subscriber);
            $subscriber = $parts[0];
         }
         #print STDERR "$list_id, $subscriber\n";

         my $mc_result = get $MC_API_EP . "listUnsubscribe&id=$list_id&email_address=$subscriber&send_goodbye=true&send_notify=true";
        #print STDERR $mc_result;
#       {"error":"Invalid MailChimp List ID: 1","code":200}
# or    {"error":"Invalid Email Address: n","code":502}
# or    {"error":"ping@pong.com is not subscribed to list Test List 1","code":215}
# or    true

           if($mc_result eq "true")
           {
                push(@successes,$subscriber);
           }
           else
           {
                push(@failures,$subscriber);
           }
        }
   }

   my %ListChangeResult;
   $ListChangeResult->{'successes'} = \@successes;
   $ListChangeResult->{'failures'} = \@failures || undef;

#print Data::Dumper->Dumper($ListChangeResult);

   my %out;
   $out->{'data'} = $ListChangeResult;
   $out->{'request_id'} = $request_id;

   return;
}


sub mc_unsubscribe_all  #remove user from all lists
{   
   my $request_id = shift;
   my $json = shift;
   my $subscribers_str= shift;

   my @subscribers = split(/,/,$subscriber_str);

   my @MailingList;
   my $mc_lists_content = get $MC_API_EP . "lists";

   my $mc_lists_json = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($mc_lists_content);
   #print Data::Dumper->Dumper($mc_lists_json);

   my $n = 0;
   foreach my $mc_list (@{$mc_lists_json->{'data'}})
   {
      &mc_unsubscribe($request_id,$json,$mc_list->{'id'},$subscribers_str);
   }

   my %ListChangeResult;
   $ListChangeResult->{'successes'} = $subscribers_str;
   $ListChangeResult->{'failures'} = undef;

   my %out;
   $out->{'data'} = $ListChangeResult;
   $out->{'request_id'} = $request_id;

   return;
}

### not being used yet
sub mc_update
{
   my $request_id = shift;
   my $json = shift;
   my $lists_str = shift;        #a required, comma-separated list of list IDs to which the addresses should be added.
   my $old_str = shift;  
   my $new_str = shift;

   my @lists = split(/,/,$lists_str);

   my $result = "false";
   my $r = &mc_unsubscribe($request_id,$json,$lists_str,$old_str);
   if($r =~ /\"failures\"\:\[\]/is)  #user present in list
   {
      $r .= &mc_subscribe($request_id,$json,$lists_str,$new_str);
   }
   $result = "true" if($r =~ /\"failures\"\:\[\]/is);   #no failures

   my %ActionResult;
   $ActionResult->{'result'} = $result;

   my %out;
   $out->{'data'} = $ActionResult;
   $out->{'request_id'} = $request_id;

   return;
}


### not using MC's listUpdateMember, should
sub mc_update_all  #update user address from all lists
{   
   my $request_id = shift;
   my $json = shift;
   my $old_str = shift;
   my $new_str = shift;

   my $mc_lists_content = get $MC_API_EP . "lists";

   my $mc_lists_json = $json->allow_nonref->utf8->relaxed->escape_slash->loose->allow_singlequote->allow_barekey->decode($mc_lists_content);
   #print Data::Dumper->Dumper($mc_lists_json);

   my $r;
   my $result = "false";
   foreach my $mc_list (@{$mc_lists_json->{'data'}})
   {
      $r = &mc_unsubscribe($request_id,$json,$mc_list->{'id'},$old_str);
      if($r =~ /\"failures\"\:\[\]/is)  #user present in list
      {
         $r = &mc_subscribe($request_id,$json,$mc_list->{'id'},$new_str);
      }
      $result = "true" if($r =~ /\"failures\"\:\[\]/is);   #no failures
   }

   my %ActionResult;
   $ActionResult->{'result'} = $result;

   my %out;
   $out->{'data'} = $ActionResult;
   $out->{'request_id'} = $request_id;

   return;

}


1;
