// initialize number of images to process

var pictures = $(".illustrations picture");
var n_pictures = pictures.length, max_scroll = document.body.scrollHeight, per_image = max_scroll/n_pictures;

$(window).scroll(function() {
	var scroll = $(window).scrollTop();
	current_image = Math.floor(scroll/per_image);
	pictures.each(function(i) {
		console.log([i+1, pictures.length - current_image]);
		if ((i) >= (pictures.length - current_image)) {
			$(this).attr("class", "picture hide");
		} else {
			$(this).attr("class", "picture");
		}
	})
})