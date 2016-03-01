sub read_video
{

   $video->{'video_id'} = clean('int', $_query->param('video_id'));
   $video->{'video_name'} = $_query->param('video_name');
   $video->{'video_url'} = $_query->param('video_url');
   $video->{'video_source'} = $_query->param('video_source');
   $video->{'video_start'} = clean('int', $_query->param('video_start'));
   $video->{'video_end'} = clean('int', $_query->param('video_end'));
   $video->{'video_hint_start'} = clean('int', $_query->param('video_hint_start'));
   $video->{'video_hint_end'} = clean('int', $_query->param('video_hint_end'));
   $video->{'video_added'} = $_query->param('video_added');
   $video->{'video_last'} = $_query->param('video_last');
   $video->{'video_status'} = clean('int', $_query->param('video_status'));

   return;
}

sub select_videos
{
   my $where = shift;

   my $statement = "SELECT
video.video_id,video.video_name,video.video_url,video.video_source,video.video_start,video.video_end,video.video_hint_start,video.video_hint_end,video.video_added,video.video_last,video.video_status         
	FROM video
         $where";

   $video_sth = Execute($statement,$dbh);

   print STDERR $statement if($DEBUG);
   return;
}

sub next_video
{
   $video = HFetch($video_sth);

   return $video->{'video_id'} ne "";
}

sub select_video
{
   my $id = shift;

   my $statement = "SELECT 
video_id,video_name,video_url,video_source,video_start,video_end,video_hint_start,video_hint_end,video_added,video_last,video_status                 
		FROM video
                 WHERE video_id = $id";
   my $sth = Execute($statement,$dbh);

   $video = HFetchone($sth);

   return $video->{'video_id'} ne "";
}

sub insert_video
{
   $video->{'video_name'} = $dbh->quote($video->{'video_name'});
   $video->{'video_url'} = $dbh->quote($video->{'video_url'});
   $video->{'video_source'} = $dbh->quote($video->{'video_source'});

   my $statement = "INSERT INTO video ( 
video_id,video_name,video_url,video_source,video_start,video_end,video_hint_start,video_hint_end,video_added,video_last,video_status
	)
	VALUES (
$video->{'video_id'},$video->{'video_name'},$video->{'video_url'},$video->{'video_source'},$video->{'video_start'},$video->{'video_end'},$video->{'video_hint_start'},$video->{'video_hint_end'},NOW(),NOW(),$video->{'video_status'}
	)";
   Execute($statement,$dbh);

   $statement = "SELECT max(video_id) FROM video";
   my $new_id = Fetchone(Execute($statement,$dbh));
   return $new_id;
}

sub update_video
{
    my $setstr = shift;
    my $statement;

   $video->{'video_name'} = $dbh->quote($video->{'video_name'});
   $video->{'video_url'} = $dbh->quote($video->{'video_url'});
   $video->{'video_source'} = $dbh->quote($video->{'video_source'});

    if($setstr)
      {  $statement = "UPDATE video SET $setstr WHERE video_id = $video->{'video_id'}";  }
    else
      {
        $statement = "UPDATE video SET
		video_id = $video->{'video_id'},
		video_name = $video->{'video_name'},
		video_url = $video->{'video_url'},
		video_source = $video->{'video_source'},
		video_start = $video->{'video_start'},
		video_end = $video->{'video_end'},
		video_hint_start = $video->{'video_hint_start'},
		video_hint_end = $video->{'video_hint_end'},
		video_added = NOW(),
		video_last = NOW(),
		video_status = $video->{'video_status'}               
		WHERE video_id = $video->{'video_id'}";
      }

    Execute($statement,$dbh);
    print STDERR "$statement" if($DEBUG);

    return;
}

sub delete_video
{
my $id = shift;

my $statement = "DELETE FROM video
                 WHERE video_id = $id";

Execute($statement,$dbh);

return;
}

1;
