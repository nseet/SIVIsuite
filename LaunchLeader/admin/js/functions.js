$(function() {

	$(document).on('ready', function(){
		
		$(function() {
		    var startDate;
		    var endDate;
		    
		    var selectCurrentWeek = function() {
		        window.setTimeout(function () {
		            $('.weekpicker').find('.ui-datepicker-current-day a').addClass('ui-state-active');
		        }, 1);
		    }
		    
		    $('.section-chart-4 .weekpicker').datepicker( {
		        showOtherMonths: true,
		        selectOtherMonths: true,
		        onSelect: function(dateText, inst) { 
		            var date = $(this).datepicker('getDate');
		            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
		            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
		            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
		            $('#startDate').text($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
		            $('#endDate').text($.datepicker.formatDate( dateFormat, endDate, inst.settings ));
		            
		            selectCurrentWeek();
		            console.log($(this).closest('form').length)
		            // $(this).closest('form').trigger('submit');
		            $('body').removeClass('dp');
		        },
		        beforeShowDay: function(date) {
		        	console.log(startDate, endDate)
		            var cssClass = '';
		            if(date >= startDate && date <= endDate)
		                cssClass = 'ui-datepicker-current-day';
		            return [true, cssClass];
		        },
		        onChangeMonthYear: function(year, month, inst) {
		            selectCurrentWeek();
		        }
		    });

			$('.section-chart-2 .weekpicker').datepicker( {
		        showOtherMonths: true,
		        selectOtherMonths: true,
		        onSelect: function(dateText, inst) { 
		            var date = $(this).datepicker('getDate');
		            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
		            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
		            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
		            $('#startDate1').text($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
		            $('#endDate1').text($.datepicker.formatDate( dateFormat, endDate, inst.settings ));
                document.getElementById('weekStartDate').value = $.datepicker.formatDate( dateFormat, startDate, inst.settings );
                document.getElementById('weekEndDate').value = $.datepicker.formatDate( dateFormat, endDate, inst.settings );
		            
		            selectCurrentWeek();
		            console.log($(this).closest('form').length)
		            $(this).parent().addClass('choose');
		            // $(this).closest('form').trigger('submit');
		            $('body').removeClass('dp');
		        },
		        beforeShowDay: function(date) {
		            var cssClass = '';
		            if(date >= startDate && date <= endDate)
		                cssClass = 'ui-datepicker-current-day';
		            return [true, cssClass];
		        },
		        onChangeMonthYear: function(year, month, inst) {
		            selectCurrentWeek();
		        }
		    });
		    
		    $(document)
		    .on('mousemove', '.dp .ui-datepicker-calendar tr', function(){ 
		    	$(this).find('td a').addClass('ui-state-active'); 
		    })
			.on('mouseleave', '.dp .ui-datepicker-calendar tr', function(){
		    	$(this).find('td a').removeClass('ui-state-active'); 
		    });

		    $('.weekpicker').on('click', function(){
				$('body').addClass('dp');
			});

		});

		$('.section-chart').each(function(){
			var $from = $(this).find('.from');
			var $to = $(this).find('.to');

			$from.datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				onClose: function( selectedDate ) {
					$to.datepicker( "option", "minDate", selectedDate );
				}
			});

			$to.datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				onClose: function( selectedDate ) {
					$from.datepicker( "option", "maxDate", selectedDate );
				}
			});
		});

		// $('.weekpicker').each(function(){
		// 	var $self = $(this),
		// 		form = $(this).closest('form');

		// 	$self.datepicker({
		// 		onSelect: function() {
		// 			form.trigger('submit');
		// 		}
		// 	});
		// })
  	var $win = $(window);

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
        

	});
	$(document).on('focusin', '.field, textarea', function() {
		if(this.title==this.value) {
			this.value = '';
		}
		$(this).parents('.search').addClass('focused');
	}).on('focusout', '.field, textarea', function(){
		if(this.value=='') {
			this.value = this.title;
		}
		$(this).parents('.search').removeClass('focused');
	});

	$(window).on('load', function(){

		$('.expandable').on('click', function(){
			var tab_idx = $(this).parents('li').index();
			if($(this).parents('li').find('.exp-content').is(':hidden') ){
				$('.expandable').removeClass('expanded');
				$(this).addClass('expanded');
				$('.exp-content').stop(true).slideUp(150);
				$('.exp-content:eq("' + tab_idx + '")').stop(true).slideDown(150);
			} else { 
				$('.exp-content').stop(true).slideUp(150);
				$(this).removeClass('expanded');
			}
			return false; 
		});

		$('.logo-holder').each(function(){
			var image_height = $(this).find('img').height();
			$(this).find('img').css({marginTop:-(image_height/2)});
		});

		if( $('.radio').length ){
			$('.radio').radio();
			$('input.radio').css({opacity:0});
		}

		$(document).on('mouseenter', '.profile-info', function(){
			$(this).addClass('active').find('.profile-dd').show();

		}).on('mouseleave', '.profile-info', function(){
			$(this).removeClass('active').find('.profile-dd').hide();
		});

		$(document).on('mouseenter', '.profile-dd li:eq(0)', function(){
			$('.profile-dd').addClass('active');

		}).on('mouseleave', '.profile-dd li:eq(0)', function(){
			$('.profile-dd').removeClass('active');
		});


		$('.scrollable').jScrollPane({
			showArrows: true,
			autoReinitialise: true
		});

		if( $('.custom-select').length ){
			$(".custom-select select").selectBoxIt({
			  	nativeMousedown: true
			});
		}

		$(".slider ul").carouFredSel({
			auto: false,
			items: 5,
			align: "center",
			height: "auto",
			scroll: {
			    items: 1,
			    fx: "scroll",
			    easing: "quadratic"
			},
			prev: ".prev",
			next: ".next"
		});

		$('.popup-open').magnificPopup({
		type: "ajax",
		closeBtnInside: true,
		callbacks: {
			ajaxContentAdded: function(){
					$('.logo-holder').each(function(){
						var image_heightx = $(this).find('img').height();
						$(this).find('img').css({marginTop:-(image_heightx/2)});
				});
			}
		}
	});

		if( $('.load-message').length) {
			$('.popup-open').trigger('click');
		}
	});

	$('.show-hint').on('click', function(){
		$(this).parents('.question-wrap').find('.hint-container').stop(true).slideDown(150);
		$(this).hide();
		$(this).parents('.question-wrap').find('.hide-hint').show();
    // var hint_params = document.getElementById('hint_check_params').value ;
    // $.get( "challenge", hint_params ,function(data) {
    // });

		return false;
	});
	$('.hide-hint').on('click', function(){
		$(this).parents('.question-wrap').find('.hint-container').stop(true).slideUp(150);
		$(this).hide();
		$(this).parents('.question-wrap').find('.show-hint').show();
		return false;
	});
        $('.show-comment').on('click', function(){
                $(this).parents('.question-wrap').find('.comment-container').stop(true).slideDown(150);
                $(this).hide();
                $(this).parents('.question-wrap').find('.hide-comment').show();
                return false;
        });
        $('.hide-comment').on('click', function(){
                $(this).parents('.question-wrap').find('.comment-container').stop(true).slideUp(150);
                $(this).hide();
                $(this).parents('.question-wrap').find('.show-comment').show();
                return false;
        });


	$('.btn-leader-hide').hide();
	$('.btn-leader').on('click', function(){
		if( $(this).hasClass('btn-leader-show') ){
			$(this).hide();
			$(this).parents('.box-points').find('.leaderboard-wrap').stop(true).slideDown(150);
			$('.btn-leader-hide').show();
		} else { 
			$(this).hide();
			$('.btn-leader-show').show();
			$(this).parents('.box-points').find('.leaderboard-wrap').stop(true).slideUp(150);
		}
		return false;
	});
});
