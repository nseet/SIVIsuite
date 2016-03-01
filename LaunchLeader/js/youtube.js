var YouTubePlayer = (function() {
 
    /**
     * YouTube Player Api wrap
     * @param {DOM Object} element video holder element
     * @param {object} settings
     *
     */
    var defaultPlayerOptions = {
        videoId : 'ScMzIvxBSi4',
        width   : 640,
        height  : 390,
        playerVars: {
            autoplay: 0,
            controls: 1
        }
    };
 
    function YouTubePlayer(element, settings) {
       
        this.element = element;
 
        this.settings = settings || {};
 
        this.playerOptions = this.extractYTOptions() || this.settings.playerOptions || defaultPlayerOptions;
 
        this.player = null;
 
        this.pane = null;
 
        this.init();
    };
 
    YouTubePlayer.prototype.init = function() {
        var that = this;
 
        this.addEvents();
 
        this.createPane();
 
        if(YT.loaded) {
            this.initPlayer();
        } else {
            YT.ready(function() {
                that.initPlayer();
            });
        };
    };
 
    YouTubePlayer.prototype.createPane = function() {
        this.pane = document.createElement('div');
 
        this.pane.className = 'youtube-player-pane';
 
        this.element.appendChild(this.pane);
    };
 
    YouTubePlayer.prototype.addEvents = function() {
        this.playerOptions.events = {
            onReady                 : this.settings.onPlayerReady || function() {},
            onPlaybackQualityChange : this.settings.onPlayerPlaybackQualityChange || function() {},
            onStateChange           : this.settings.onPlayerStateChange || function() {},
            onError                 : this.settings.onPlayerError || function() {}
        };
    };
 
    YouTubePlayer.prototype.initPlayer = function() {
        this.player = new YT.Player(this.pane, this.playerOptions);
 
        // make reachable from the element
        this.element.player = this.player;
       
        if('jQuery' in window) {
            jQuery(this.element).data('player', this);
        };
 
    };
 
    YouTubePlayer.prototype.extractYTOptions = function() {
        var options = null;
 
        // var elementData = this.element.dataset;
 
        // if('ytVideoId' in elementData) {
            options = {
                videoId : this.element.getAttribute('data-yt-video-id'),
                width   : this.element.getAttribute('data-yt-width'),
                height  : this.element.getAttribute('data-yt-height'),
                playerVars: {
                    autoplay: this.element.getAttribute('data-yt-autoplay') || 0,
                    controls: this.element.getAttribute('data-yt-controls') || 1
                }
            };
        // };
 
        return options;
    };
 
    YouTubePlayer.prototype.play = function() {
        if('playVideo' in this.player) {
            this.player.playVideo();
        };
    };
 
    YouTubePlayer.prototype.pause = function() {
        if('pauseVideo' in this.player) {
            this.player.pauseVideo();
        };
    };
 
    YouTubePlayer.prototype.stop = function() {
        if('stopVideo' in this.player) {
            this.player.stopVideo();
        };
    };
 
    YouTubePlayer.prototype.destroy = function() {
        if('destroy' in this.player) {
            this.player.destroy();
        };
    };
 
    YouTubePlayer.prototype.mute = function() {
        if('mute' in this.player) {
            this.player.mute();
        };
    };
 
    YouTubePlayer.prototype.unmute = function() {
        if('unMute' in this.player) {
            this.player.unMute();
        };
    };
 
    return YouTubePlayer;
 
})();