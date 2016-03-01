;(function($, window, document, undefined) {
	var $win = $(window);
	var $doc = $(document);

	function initCustomInputs() {
		// This class will be added to active item
		var checkedClass = 'custom-input-checked';
		var disabledClass = 'custom-input-disabled';
		var inputSelector = '.custom-checkbox input, .custom-radio input';
	 
		$(inputSelector)
	 
			// Add classes to all checked checkboxes
			.each(function() {
				var input = this;
				
				$(input)
					.parent() // go up to the input holder element
					.toggleClass(checkedClass, input.checked);
			})
	 
			// Handle the change event
			.on('change', function() {
				var input = this;
	 
				// detect if the input is radio
				if(input.type === 'radio') {
					var name = input.name;
	 
					// find all the radios with that name, in the same document
					$(input.ownerDocument)
						.find('[name=' + name + ']')
						.each(function() {
	 
							var radioInput = this;
	 
							$(radioInput)
								.parent() // go up to the input holder element
								.toggleClass(checkedClass, radioInput.checked);
							
						});
				} else {
	 
					$(input)
						.parent() // go up to the input holder element
						.toggleClass(checkedClass, input.checked);
				};
			})
			.on('disable', function() {
				var input = this;
				
				input.disabled = true;
				
				$(input)
					.parent() // go up to the input holder element
					.addClass(disabledClass);
			})
			.on('enable', function() {
				var input = this;
	 
				input.disabled = false;
	 
				$(input)
					.parent() // go up to the input holder element
					.removeClass(disabledClass);
			});
	}

	function initCustomUpload() {
		var hasSelectedClass = 'file-upload-has-selected';
		var holderSelector = '.file-upload';
		var namesSelector = '.file-upload-names';
		var inputSelector = '.file-upload-input';
		var multipleNamesDivider = ', ';
	 
		$(inputSelector)
			.on('change', function() {
				var input = this;
				var files = input.files;
	 
				// Files property polyfill
				if(!('files' in input)) {
					files = [];
					files.push({
						name: input.value.replace('C:\\fakepath\\', '')
					});
				};
	 
				$(input)
					.closest(holderSelector)
					.toggleClass(hasSelectedClass, input.value !== '')
						.find(namesSelector)
						.val(
							$.map(files, function(file) {
								return file.name;
							})
							.join(multipleNamesDivider)
						);
			});
	}

	function initTabs() {
		// This class will be added to active tab link 
		// and the content container
		var activeTabClass = 'current';
		
		$('.tabs-nav a').on('click', function(event) {
			var $tabLink = $(this);
			var $targetTab = $($tabLink.attr('href'));
	 
			$tabLink
				.parent() // go up to the <li> element
				.add($targetTab)
				.addClass(activeTabClass)
					.siblings()
					.removeClass(activeTabClass);
			
			event.preventDefault();
		});
	}

	$doc.ready(function() {	
		initCustomInputs();

		initCustomUpload();

		initTabs();

		// Open/Close Faq Sidebar Menus
		if($('.widget-nav-group h4').length) {
			if($win.width() < 768) {
				$('.widget-nav-group h4').on('click', function() {
					$(this).next().toggleClass('opened');
				});
			}
		}
		// YouTube
		$('.youtube-player').each(function() {
			var $element = $(this);
			new YouTubePlayer(this);			
		});

		isPlaying = false;
		$('.video-playback a').on('click', function(event){
			event.preventDefault();

			if(!isPlaying) {
				$('.youtube-player').data('player').play();
				isPlaying = true;
				$(this).addClass('active');
			} else {
				$('.youtube-player').data('player').pause();
				isPlaying = false;
				$(this).removeClass('active');
			};
		});

		$('.nav-trigger').on('click', function(event) {
			$('.nav').toggleClass('visible');
			
			event.preventDefault();
		});

		$('.link-top').on('click', function(event) {
			$('html, body').animate({
					scrollTop: 0
				}, 500);

			event.preventDefault();
		});

		// Content Slider Home
		$win.on('load', function() {
			if($win.width() < 640) {
				$('ol.updates').not('#no-slider, #no-slider-idea, #no-slider-profile').carouFredSel({
					auto: false,
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 1,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			} else if($win.width() < 768) {
				$('ol.updates').not('#no-slider, #no-slider-idea, #no-slider-profile').carouFredSel({
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 2,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			} else if($win.width() > 999) {
				$('ol.updates').not('#no-slider, #no-slider-idea, #no-slider-profile').carouFredSel({
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 3,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			}
			

			$('.slider-idea .slides').carouFredSel({
				responsive : true,
				width : '100%',
				height : 'variable',
				items : 1,
				scroll : {
					items : 1,
					duration : 500
				},
				prev : '.slider-prev',
				next : '.slider-next'
			});

			$('.profile-slider .slides').carouFredSel({
				auto: false,
				responsive : true,
				width : '100%',
				height : 'variable',
				items : 1,
				scroll : {
					items : 1,
					duration : 500
				},
				prev : '.slider-prev',
				next : '.slider-next'
			});
		});

		$win.on('resize', function() {		
			if($win.width() < 640) {
				$('ol.updates').not('#no-slider').carouFredSel({
					auto: false,
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 1,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			} else if($win.width() < 768) {
				$('ol.updates').not('#no-slider, #no-slider-idea, #no-slider-profile').carouFredSel({
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 2,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			} else if($win.width() > 999) {
				$('ol.updates').not('#no-slider, #no-slider-idea, #no-slider-profile').carouFredSel({
					responsive : true,
					width : '100%',
					height : 'variable',
					items : 3,
					scroll : {
						items : 1,
						duration : 500
					},
					prev : '.home-slider-prev',
					next : '.home-slider-next'
				});
			}

			// Open/Close Faq Sidebar Menus
			if($('.widget-nav-group h4').length) {
				if($win.width() < 768) {
					$('.widget-nav-group h4').on('click', function() {
						$(this).next().toggleClass('opened');
					});
				}
			}		
		});

		// Custom Select
		if($('.custom-select').length > 0) {
			$('.custom-select').selecter();
		}

		// Colorbox
		if($win.width() < 480) {
			$('.modal-trigger').on('click', function(event) {
				event.preventDefault();

				var $trigger = $(this);
				var _href = $trigger.is('a') ? $trigger.attr('href') : $trigger.data('popup');

				$.colorbox({
					width: '90%',
					href: _href,
					opacity: 0.5,
					onComplete: function() {
						initCustomInputs(),
						$.colorbox.resize();
					}
				});
			});
		} else {
			$('.modal-trigger').on('click', function(event) {
				event.preventDefault();

				var $trigger = $(this);
				var _href = $trigger.is('a') ? $trigger.attr('href') : $trigger.data('popup');

				$.colorbox({
					href: _href,
					opacity: 0.5,
					onComplete: function() {
						initCustomInputs(),
						$.colorbox.resize();
					}
				});
			});
		}
		
		//
		$('#funding-form').on('submit', function(event) {
			window.location = "funding-confirm.html";
			event.preventDefault();
		});

		var $activityTabs = $('.tabs-activity');

		if($activityTabs.length) {
			var $activityTabLinks = $activityTabs.find('.tab-links a');
			var $activityTabEntries = $activityTabs.find('.tab-entry');
			var $activityTabTriggers = $activityTabs.find('.tab-trigger');

			$activityTabLinks
				.on('click', function(e) {
					e.preventDefault();

					var $link = $(this);
					var $parent = $link.parent();

					if(!$parent.hasClass('current')) {
						var $targetTab = $($link.attr('href'));

						$targetTab.addClass('current').siblings('.current').removeClass('current');
						$parent.addClass('current').siblings('.current').removeClass('current');
					}
				});

			$activityTabTriggers
				.on('click', function(e) {
					e.preventDefault();

					var $link = $(this);
					var $tabLink = $activityTabs.find('.tab-links a[href="' + $link.attr('href') + '"]');
					var $parent = $tabLink.parent();

					if(!$parent.hasClass('current')) {
						var $targetTab = $($link.attr('href'));

						$targetTab.addClass('current').siblings('.current').removeClass('current');
						$parent.addClass('current').siblings('.current').removeClass('current');
					}
				});
		}

	});
})(jQuery, window, document);
