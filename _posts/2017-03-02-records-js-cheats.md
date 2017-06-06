---
layout: post
title: '记录:js秘籍(editable)'
date: 2017-03-02 09:26
comments: true
categories: 
---
```
<div class="edit">If no background color is set on the Element, or its background color is set to 'transparent', the default end value will be white.</div>
<div class="edit">Element shortcut method for tweening the background color. Immediately transitions an Element's background color to a specified highlight color then back to its set background color.</div>
<div class="edit">Element shortcut method which immediately transitions any single CSS property of an Element from one value to another.</div>
```

```
<script type="text/javascript">
function divClicked() {
  var divHtml = $(this).html();
  var editableText = $("<textarea />");
  editableText.val(divHtml);
  $(this).replaceWith(editableText);
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

$(document).ready(function() {
  $("div.edit").click(divClicked);
});
</script>
```

```
<style media="screen">
div {
  margin: 20px 0 !important;
}

textarea {
  width: 80% !important;
}

</style>
```