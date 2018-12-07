// initialize number of images to process

var pictures = $(".illustrations picture");
var n_pictures = pictures.length, max_scroll = document.body.scrollHeight, per_image = max_scroll/n_pictures;

$(window).scroll(function() {
	var scroll = $(window).scrollTop();
	current_image = Math.max(Math.floor(scroll/per_image), 0);
	pictures.each(function(i) {
		if (i > 0) {
			if ((i) >= (pictures.length - current_image)) {
				$(this).attr("class", "picture hide");
			} else {
				$(this).attr("class", "picture");
			}
		}
	})
})