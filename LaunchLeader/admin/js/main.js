(function($){

	var $doc = $(document),
		$win = $(window);

	$doc.ready(function(){

		var $checks = $('input[type="checkbox"]'),
			$activateBtn = $('.btn-js-popup'),
			$activateCheckbox = $('.js-activate');

		//checkbox
		$checks.iCheck();

		// radios
		$doc.on('cbox_complete', function(){

			var $radios = $('.popup input[type="radio"]');

			$radios.iCheck();
/*			$radios.on('ifChecked', function(){

				$.colorbox({
					href: $(this).closest('.popup').data('next-step'),
					open: true
				});

			});
*/
		});

		//blink fields
		$doc.on('focusin', 'input[title], textarea', function(){

			if (this.value == this.title) {
				this.value = '';
			};

		}).on('focusout', 'input[title], textarea', function(){

			if (!this.value) {
				this.value = this.title;
			};

		});

/*
		// colorbox
		$activateBtn.on('click', function(e){

			if (!$activateBtn.hasClass('btn-disabled')) {
				$.colorbox({
					href: $activateBtn.attr('href'),
					open: true
				});
			}

			e.preventDefault();

		});
*/
		// popups
		$activateBtn.toggleClass('btn-disabled', !$activateCheckbox.is(':checked'));

		$activateCheckbox.on('ifToggled', function() {
			$activateBtn.toggleClass('btn-disabled', !this.checked);
		});

		$doc.on('click', '.js-next-step', function(e){

			loadPopup($(this).attr('href'));

			e.preventDefault();
		});

		$doc.on('submit', '.form-email', function(e){

			loadPopup('popups/get_started.html');

			e.preventDefault();
		});
/*
		//close colorbox
		$doc.on('click', '.js-close', function(e){

			$.colorbox.close();

			e.preventDefault();
		});
*/
	});
/*
	function loadPopup(href){
		$.colorbox({
			href: href,
			open: true
		});
	}
*/
})(jQuery);
