sub get_next_question_id
{
   my $question_id = shift || return;
   my $category_id = shift || return;
#   &select_question($question_id);

   my $statement = "SELECT question_id FROM question WHERE category_id=$category_id AND question_id > $question_id ORDER BY question_id LIMIT 1";
   print STDERR $statement;

   my $sth = &Execute($statement,$dbh);

   return &Fetchone($sth);
}

sub get_point_total
{
   my $account_id = shift || return;

   #xxx needs to be a smarter calculator!
   my $statement = "select sum(question_note) from entry,question,answer where entry_status=$account_id and entry_type=question.question_id and answer.question_id=question.question_id and answer_note like 'Right!%' and (entry_desc = answer_id OR entry_desc =concat(answer_desc, ' ' ,answer_id) OR upper(entry_desc) =upper(concat(answer_desc, ' ' ,answer_id)))";
   my $sth = &Execute($statement,$dbh);
   my $points = &Fetchone($sth);

   $statement = "select sum(reward_points) from account_reward,reward where account_reward.reward_id=reward.reward_id and reward_status=1 and account_reward_status=1 and account_id=$account_id";
   $sth = &Execute($statement,$dbh);
   my $rewards = &Fetchone($sth);

   return int($points - $rewards);
}

sub get_category_point_total
{
   my $category_id = shift || return;
   
   my $statement = "select sum(question_note) from question where category_id = $category_id AND question_status=1";
   my $sth = &Execute($statement,$dbh);
   my $category_total = &Fetchone($sth);

   return int($category_total);
}

sub get_account_category_point_total
{
   my $account_id = shift || return;
   my $category_id = shift || return;

   #xxx needs to be a smarter calculator!
   my $statement = "select sum(question_note) from entry,question,answer where category_id=$category_id and entry_status=$account_id and entry_type=question.question_id and answer.question_id=question.question_id and answer_note like 'Right!%' and (entry_desc = answer_id OR entry_desc =concat(answer_desc, ' ' ,answer_id) OR upper(entry_desc) =upper(concat(answer_desc, ' ' ,answer_id)))";
   my $sth = &Execute($statement,$dbh);
   my $points = &Fetchone($sth);

   return int($points);
}

sub get_entry_count_by_category
{
   my $account_id = shift || return;
   my $category_id = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   
   my $apt_str = '';
   
   if($date_from ne '' && $date_to ne '')
   {
       #$apt_str = " and entry_added >= '$date_from' and entry_ended <= '$date_to'";
       $apt_str = " and DATE(entry_added) >= '$date_from' and DATE(entry_ended) <= '$date_to'";
   }

   my $statement = "select count(entry_id) from entry where entry_type in(select question_id from question where category_id=$category_id) and entry_status=$account_id". $apt_str;
   my $sth = &Execute($statement,$dbh);
   my $entry_count = &Fetchone($sth);

   return int($entry_count);
}

sub get_time_count_by_category
{
   my $account_id = shift || return;
   my $category_id = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   
   my $ttspt_str = '';
   
   if($date_from ne '' && $date_to ne '')
   {
       #$ttspt_str = " and entry_added >= '$date_from' and entry_ended <= '$date_to'";
       $ttspt_str = " and DATE(entry_added) >= '$date_from' and DATE(entry_ended) <= '$date_to'";
   }

   ## The actual one (ignoring answers that took multiple days to answer)
   # my $statement = "SELECT ROUND(SUM(UNIX_TIMESTAMP(entry_ended) - UNIX_TIMESTAMP(entry_added)) / 60) AS total_time FROM entry WHERE DATE(entry_added)=DATE(entry_ended) AND entry_ended IS NOT NULL AND entry_type IN(SELECT question_id FROM question WHERE category_id=$category_id) AND entry_status=$account_id";

   ## ignoring the answeres took more than 2 hours. something must be off.
   my $statement = "SELECT ROUND(SUM(UNIX_TIMESTAMP(entry_ended) - UNIX_TIMESTAMP(entry_added)) / 60) AS total_time FROM entry WHERE DATE(entry_added)=DATE(entry_ended) AND entry_ended IS NOT NULL AND entry_type IN(SELECT question_id FROM question WHERE category_id=$category_id) AND UNIX_TIMESTAMP(entry_ended) - UNIX_TIMESTAMP(entry_added) < 7200 AND entry_status=$account_id".$ttspt_str;

   my $sth = &Execute($statement,$dbh);
   my $entry_count = &Fetchone($sth);

   #print STDERR $statement if($DEBUG);
   return int($entry_count);
}

sub get_entries_by_category
{
   my $account_id = shift || return;
   my $category_id = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   
   my $bppq_str = '';
   
   if($date_from ne '' && $date_to ne '')
   {
       #$ttspt_str = " and entry_added >= '$date_from' and entry_ended <= '$date_to'";
       $bppq_str = " and DATE(entry_added) >= '$date_from' and DATE(entry_ended) <= '$date_to'";
   }   
   my $statement = "SELECT entry_name, entry_note FROM entry, question WHERE entry_type=question_id AND entry_status=$account_id and entry_note IS NOT NULL AND question.category_id=$category_id".$bppq_str;

   my $sth = &Execute($statement,$dbh);
   #print STDERR $statement if($DEBUG);

   return $sth ; 
}

sub get_entry_time_by_date
{
   my $account_id = shift || return;
   my $date = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   
   my $etbd_str = '';
   
     if($date_from ne '' && $date_to ne '')
    {
       $etbd_str = " and DATE(entry_added) >= '$date_from' and DATE(entry_ended) <= '$date_to'";
    }


    ##(ignoring answers that took multiple days to answer)
    my $statement = "SELECT ROUND((UNIX_TIMESTAMP(max(entry_ended)) - UNIX_TIMESTAMP(min(entry_added)))/60) AS time_diff, DATE(entry_added) FROM entry WHERE entry_status=$account_id AND DATE(entry_added) > '$date' AND DATE(entry_added)=DATE(entry_ended) $etbd_str AND entry_ended IS NOT NULL  group by DATE(entry_added)";


   my $sth = &Execute($statement,$dbh);
   print STDERR $statement if($DEBUG);

   return $sth ;
}

sub get_active_users_by_date
{
   my $company_id = shift || return;
   my $date = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   
   my $etbd_str = '';
   
   if($date_from ne '' && $date_to ne '')
   {
       $etbd_str = " AND DATE(account_accessed) >= '$date_from' and DATE(account_accessed) <= '$date_to'";
   }

    ##(ignoring answers that took multiple days to answer)
   my $statement = "SELECT DATE(account_accessed) as date_accessed , count(DATE(account_accessed)) as usercount FROM `account` WHERE 1=1 $etbd_str AND account_status= $company_id  group by date_accessed";
   my $sth = &Execute($statement,$dbh);
   print STDERR $statement if($DEBUG);
   
   return $sth ;
}

sub get_min_max_date_of_account_creation
{
    my $statement = "SELECT DATE(MIN(account_created)) as date_min, DATE(MAX(account_created)) as date_max FROM `account`";       
    my $sth = &Execute($statement,$dbh);
    return $sth;
}

sub get_no_of_users_by_date
{
   my $company_id = shift || return;
   my $date = shift || return;
   my $date_from = shift || '';
   my $date_to = shift || '';
   my $day_diff = shift || 0;
   my $tallystr = '';
   
   print STDERR ("day_diff:".$day_diff);

   my $etbd_str = '';
   my $to_select = '';

   
   if($day_diff > 60 && $day_diff <=365   ){
        #Monthly
        $tallystr = 'Month';
        $etbd_str = " AND account_created >= '$date_from' and account_created <= '$date_to'";        
        $to_select = "MONTHNAME(account_created)";
   }
   elsif($day_diff  > 7 && $day_diff < 60   ){
        $tallystr = 'Week';
        $etbd_str = " AND account_created >= '$date_from' and account_created <= '$date_to'";        
        $to_select = "WEEKOFYEAR(account_created)";
   }
    elsif($day_diff <=7 && $day_diff ){
        # Daily
        $tallystr = 'Day';
        $etbd_str = " AND account_created >= '$date_from' and account_created <= '$date_to'";        
        $to_select = "DAYNAME(account_created)";
    }
    else{
        #Yearly
        $tallystr = 'Year';
        $etbd_str = " AND YEAR(account_created) >= YEAR('$date_from') and YEAR(account_created) <= YEAR('$date_to')";
        $to_select = "YEAR(account_created)";
    }

    ##(ignoring answers that took multiple days to answer)
   my $statement = "SELECT $to_select AS acct_time, count(account_id) AS usercount FROM `account` WHERE 1=1 $etbd_str AND account_status= $company_id group by acct_time";

   my $sth = &Execute($statement,$dbh);
   print STDERR $statement if($DEBUG);

   return ($sth,$tallystr) ;
}


1;
