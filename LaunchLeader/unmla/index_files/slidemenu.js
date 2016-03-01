// JavaScript Document
// Slide Menu 
jQuery.fn.slidemenu = function(options) {
	this.each(function(){
		// set defaults
		var slidemenu = this;
	
		slidemenu.options = {  // set options
			openall : true,
			closeall : true,
			closealltext : '[ collapse all - ]',
			openalltext : '[ expand all + ]',
			homepage : 'index',
			highlightcurrent : false
		};
		slidemenu.options = jQuery.extend(slidemenu.options,options);	// load options and defualts

		slidemenu.openall = function(obj) {  // function to enable open all menus
	    	jQuery(obj).before("<div class=\"slidemenu_all\"> <a href=\"##\" id=\"expand_" + obj.id + "\">" + slidemenu.options.openalltext + "</a></div>");
			jQuery("#expand_" + obj.id).click(function() { jQuery("#" + obj.id + " > li > a").find("+ ul").slideDown().parent().addClass("openMenu"); return false; });
	  	};

 		slidemenu.closeall = function(obj) {  // function to enable close all menus
			jQuery(obj).after("<div class=\"slidemenu_all\"> <a href=\"##\" id=\"collapse_" + obj.id + "\">" + slidemenu.options.closealltext + "</a></div>");
			jQuery("#collapse_" + obj.id).click(function() {  jQuery("#" + obj.id + " > li > a").find("+ ul").slideUp().parent().removeClass("openMenu"); return false;});
 		};

		// function to highlight current menu
 		slidemenu.highlightcurrent = function(obj, homepage) {  
			// Check the home link against the path and set the navigation accordingly.
			var path = location.pathname;
			var filebreak = path.lastIndexOf('.')
			if (filebreak > 0) {
				var path = path.substring(0, filebreak );
				var extension = path.substring(filebreak);
				}
			
			
			if (path == "/" + homepage + extension || path == "/") {
				// Note that the jQuery selector matches *only* the home link
				var $nav = jQuery('#' + obj.id + ' a[href="' + homepage + '"]');
			
			} else if (path == path + '/') {
				// Note that the jQuery selector matches *only* the home link
				var $nav = jQuery('#' + obj.id + ' a[href="' + path + '"/"]');

			} else {
				var $nav = jQuery('#' + obj.id + ' a[href$="' + path + extension + '"]');
			}

    		// Add the active class to the current path and activate it's subnavigation
			$nav.addClass('active')
	
			if($nav.parent().hasClass("submenu")) {
				$nav.parent().toggleClass("openMenu").find("ul").show();
			} else {
				$nav.parents("ul").show().parent().toggleClass("openMenu")	
			}
							 	
	
			// If the active class has subnavigation, show it
			
 		};

		slidemenu.init = function(obj) {
		        jQuery("#" + obj.id + " > li").not(":has(a.active)").find("ul").hide().parent().removeClass("openMenu");  // close all menus on init
			//jQuery("#" + obj.id + " > li:not(:has(>a.active))").find("ul:not(:has(li a.active))").hide().parent().removeClass("openMenu");  // close all menus on init
			//jQuery("#" + obj.id + " > li").find("ul:not(:has(li a.active))").hide().parent().removeClass("openMenu");  // close all menus on init

			if(slidemenu.options.closeall) { // if option set enable close all sub menus
				slidemenu.closeall(obj);
			}

			if(slidemenu.options.openall) { // if option set enable open all sub menus
				slidemenu.openall(obj);
	
			}
				
			if(slidemenu.options.highlightcurrent) {
				slidemenu.highlightcurrent(obj, slidemenu.options.homepage)
			}
				
	
			jQuery("#" + obj.id + " > li a").click(function() {  // Expand or collapse on click 					 
				if (jQuery(this).parent().children("ul").length >= 1)     {	
					jQuery(this).parent().children("ul").slideToggle();
       	  			jQuery(this).parent().toggleClass("openMenu");
					return false;
        		}	
			});
		};
		slidemenu.init(this);  // init menus
	});
}