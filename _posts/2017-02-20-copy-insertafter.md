---
layout: post
title: '记录:复制HTML到下一个div'
date: 2017-02-20 10:32
comments: true
categories: 
---
[1](http://stackoverflow.com/questions/8707756/jquery-clone-div-and-append-it-after-specific-div)
```
$('#copy-text').click(function (event) {
   $("#white_html3").clone().insertAfter("div.copy-text:last"); 
});
```