---
layout: post
title: '记录:js秘籍(editable2)'
date: 2017-03-02 09:31
comments: true
categories: 
---
```
<div>If no background color is set on the Element, or its background color is set to 'transparent', the default end value will be white.</div>
<button class='btn'>Edit</button>
<div>Element shortcut method for tweening the background color. Immediately transitions an Element's background color to a specified highlight color then back to its set background color.</div>
<button class='btn'>Edit</button>
<div>Element shortcut method which immediately transitions any single CSS property of an Element from one value to another.</div>
<button class='btn'>Edit</button> 
```
```
<script type="text/javascript">
function divClicked() {
  var divHtml = $(this).prev('div').html();
  var editableText = $("<textarea />");
  editableText.val(divHtml);
  $(this).prev('div').replaceWith(editableText);
  editableText.focus();
  // setup the blur event for this new textarea
  editableText.blur(editableTextBlurred);
}

function editableTextBlurred() {
  var html = $(this).val();
  var viewableText = $("<div>");
  viewableText.html(html);
  $(this).replaceWith(viewableText);
  // setup the click event for this new div
  viewableText.click(divClicked);
}

$(document).ready(function () {
  $(".btn").click(divClicked);
});
</script>
```
```
<style media="screen">
div {
  margin: 20px 0;
}
textarea {
  width: 100%;
}
</style>
```