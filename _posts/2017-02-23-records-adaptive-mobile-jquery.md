---
layout: post
title: '记录:适配手机的jQuery'
date: 2017-02-23 21:45
comments: true
categories: 
---
因为landing page没有navbar，但首页要做手机适配，手机出现的页面需要有一个button来进行下来选择。解决办法是单独写一个navbar隐藏起来，用jQuery来判断荧幕的大小对相应的element进行操作。
```
$(document).on("turbolinks:load", function() {
	$(window).resize(function() {
			 if($(window).width() <= 414) {
					 $("#faq_hack").addClass("mobile-btn-font");
					 $("#faq_white").addClass("mobile-btn-font");
					 $("#mobile_hack_label").addClass("mobile-label");
					 $("#mobile_white_label").addClass("mobile-label");
			 } else {
					 $("#faq_hack").removeClass("mobile-btn-font");
					 $("#faq_white").removeClass("mobile-btn-font");
					 $("#mobile_hack_label").removeClass("mobile-label");
					 $("#mobile_white_label").removeClass("mobile-label");
			 }
	 }).resize();
});

$(document).on("turbolinks:load", function() {
	$(window).resize(function() {
			 // This will fire each time the window is resized:
			 if($(window).width() <= 414) {
					 // if larger or equal
					 $("#welcome_navbar").removeClass("hide");
					 $("#welcome_navbar").addClass("mobile-navbar-default");
					 $("#welcome_navbar").addClass("navbar-fixed-top");
					 $("#web_nav").addClass("hide");
					 $("#welcome_sign_link").removeClass("btn-lg");
					 $("#welcome_sign_link").addClass("mobile-btn");
					 $("#resume_write_link").removeClass("btn-lg");
					 $("#resume_write_link").addClass("mobile-btn");
			 } else {
					 $("#welcome_navbar").addClass("hide");
					 $("#welcome_navbar").removeClass("mobile-navbar-default");
					 $("#welcome_navbar").removeClass("navbar-fixed-top");
					 $("#web_nav").removeClass("hide");
					 $("#welcome_sign_link").addClass("btn-lg");
					 $("#welcome_sign_link").removeClass("mobile-btn");
					 $("#resume_write_link").addClass("btn-lg");
					 $("#resume_write_link").removeClass("mobile-btn");
			 }
	 }).resize();
});
```
<hr>
```
$(document).ready(function() {
    // This will fire when document is ready:
    $(window).resize(function() {
        // This will fire each time the window is resized:
        if($(window).width() >= 1024) {
            // if larger or equal
            $('.element').show();
        } else {
            // if smaller
            $('.element').hide();
        }
    }).resize(); // This will simulate a resize to trigger the initial run.
});
```
```
$(document).ready(function() {
    if($(window).width() >= 1024) {
        $('a.expand').click();
    }
});
```
[1](http://stackoverflow.com/questions/7405213/jquery-if-statement-based-on-screen-size)