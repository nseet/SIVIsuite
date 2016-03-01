$(function() {
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
		return false;
	});
	$('.hide-hint').on('click', function(){
		$(this).parents('.question-wrap').find('.hint-container').stop(true).slideUp(150);
		$(this).hide();
		$(this).parents('.question-wrap').find('.show-hint').show();
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