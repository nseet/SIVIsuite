// js file


//*************************
//load emergency alert at top of page if one exists

$(document).ready(function(){
    $.get('/alert.html', function(data) {
    if (data.length > 30){
        $("body").prepend('<div id="alert" class="alert alert-error">' + data + '</div>');
        }
    });
});




//*************************
// load google analytics 

  var _gaq = _gaq || [];
  _gaq.push(
    ['unm._setAccount', 'UA-3403606-2'],
    ['unm._setDomainName', '.unm.edu'],
    ['unm._trackPageview']
    );

 var _gaq = _gaq || [];
            _gaq.push(
                 ['_setAccount', 'UA-39236669-1'],
                 ['_setDomainName', '.unm.edu'],
                 ['_trackPageview']
             );


  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();




//*************************
// equal height 
$.fn.equalHeights = function() {
        $(this).css({'height': 'auto'});
        var currentTallest = 0;
        $(this).each(function(i){
            if ($(this).outerHeight() > currentTallest) { currentTallest = $(this).outerHeight(); }
        });
        $(this).css({'height': currentTallest}); 
    return this;
};
 
$(window).resize(function() {
    $('.callout a').equalHeights();
    $('.top5news').equalHeights();
    $('.eqheight').equalHeights();
    if($(window).width() < 767){
        $('.flex-caption').equalHeights();
    }
});

$(window).load(function() {
    $('.callout a').equalHeights();
    $('.top5news').equalHeights();
    $('.eqheight').equalHeights();
    if($(window).width() < 767){
        $('.flex-caption').equalHeights();
    }
});