---
layout: post
title: '记录:FAQ紧贴页边随页面移动(未完成)'
date: 2017-02-23 22:02
comments: true
categories: 
---
```
(function($) {
	var element = $('#faq'),
			originalY = element.offset().top;

	// Space between element and top of screen (when scrolling)
	var topMargin = 500;

	// Should probably be set in CSS; but here just for emphasis
	element.css('position', 'relative');

	$(window).on('scroll', function(event) {
			var scrollTop = $(window).scrollTop();

			element.stop(false, false).animate({
					top: scrollTop < originalY
									? 0
									: scrollTop - originalY + topMargin
			}, 200);
	});
})(jQuery);
```
```
<div id="faq"><%= link_to("FAQ", "#") %></div>
```