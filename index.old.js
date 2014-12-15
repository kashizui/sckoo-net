(function() {

	var TRUE_WIDTH = 1003;
	var WHITE_WIDTH = 94;
	var BLACK_WIDTH = 37;
	var KEY_X_OFFSETS = {
		"c1":  4,
		"c#1": 73,
		"d1":  104,
		"d#1": 171,
		"e1":  204,
		"f1":  304,
		"f#1": 371,
		"g1":  404,
		"g#1": 471,
		"a1":  504,
		"a#1": 571,
		"b1":  604,
		"c2":  704,
		"c#2": 773,
		"d2":  804,
		"d#2": 871,
		"e2":  904
	};


	$.fn.textWidth = function(){
	    var self = $(this),
	        children = self.children(),
	        calculator = $('<span style="display: inline-block;">'),
	        width;

	    children.wrap(calculator);
	    width = children.parent().width(); // parent = the calculator wrapper
	    children.unwrap();
	    return width;
	};



	$(document).ready(function() {
		var $piano = $("#piano");
		var $overlay = $("#canvas");
		var $links = $("#links");
		var size = {width: $piano.width(), height: $piano.height()};
		var scale = size.width / TRUE_WIDTH;

		// Scale widths and offsets
		WHITE_WIDTH *= scale;
		BLACK_WIDTH *= scale;
		for (var key in KEY_X_OFFSETS) {
			KEY_X_OFFSETS[key] *= scale;
		}

		var reset = function() {
			var newOffset = {
				top: ($(window).height() - size.height) / 2,
				left: ($(window).width() - size.width) / 2
			};
			$piano.offset(newOffset);
			$overlay.offset(newOffset);
			$links.offset(newOffset);
		};

		$(window).resize(reset);

		/* create links in preparation */
		// TODO

		/* Execute now */
		reset();
		$piano.fadeIn("slow", function() {
			/* when fade in complete */
			$overlay.show()
			$links.fadeIn("slow");
		});

	});


})();