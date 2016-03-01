/*
* Polling the player for information
*/

// Update a particular HTML element with a new value
function updateHTML(elmId, value) {
    document.getElementById(elmId).innerHTML = value;
}

// This function is called when an error is thrown by the player
function onPlayerError(errorCode) {
    alert("An error occured of type:" + errorCode);
}

// This function is called when the player changes state
function onPlayerStateChange(newState) {
    updateHTML("playerState", newState);
}

// Display information about the current state of the player
function updatePlayerInfo() {
    // Also check that at least one function exists since when IE unloads the
    // page, it will destroy the SWF before clearing the interval.
    if(ytplayer && ytplayer.getDuration) {
        var videoCurrentPlayTime = ytplayer.getCurrentTime() ; 
        // updateHTML("videoDuration", ytplayer.getDuration() );
        // updateHTML("videoCurrentTime", videoCurrentPlayTime );
        var hint_params = document.getElementById('hint_check_params').value ;

        // log hints after 1 second of watch and don't log after that anymore in this session.
        var hint_video_start_time = document.getElementById('hint_video_start_time').value ;
        var hint_video_check_time = parseInt(hint_video_start_time) + 1 ;
        // updateHTML("videoDuration", hint_video_check_time );
        if (videoCurrentPlayTime > hint_video_check_time && hint_params != '') {
            $.get( "challenge", hint_params ,function(data) {
            });
            document.getElementById('hint_check_params').value = '';
        }
    }
}

// This function is automatically called by the player once it loads
function onYouTubePlayerReady(playerId) {
    ytplayer = document.getElementById("ytPlayer");
    // This causes the updatePlayerInfo function to be called every 250ms to
    // get fresh data from the player
    setInterval(updatePlayerInfo, 250);
    updatePlayerInfo();
    ytplayer.addEventListener("onStateChange", "onPlayerStateChange");
    ytplayer.addEventListener("onError", "onPlayerError");
}


