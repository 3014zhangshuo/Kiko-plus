---
layout: post
title: 'JS: window.open not blocked'
date: 2018-12-08 00:24:00
comments: true
tags: [js]
share: false
---
#### Window.open blocked
##### Document ready execute
```coffee
window.open('https://www.example.com')
```
##### Ajax callback
```coffee
$.ajax
  url: 'http://www.example.com'
  method: 'get'
  success: ->
    window.open('http://www.example.com/success')
  error: ->
    window.open('http://www.example.com/error')
```

#### Window.open not blocked
##### Click event
```html
<a id="window-open" href="javascript:;">Click me</a>
```
```coffee
$('#window-open').click ->
  window.open("http://www.example.com")
```
[Playground](https://jsfiddle.net/zhangshuo/wd4b2ypt/6/)
##### Click and ajax
###### Use Click event set blank window
```html
<form action="/fake/post" accept-charset="UTF-8" method="post" remote="true">
  <input type="submit" value="Click" id="window-open-with-ajax">
</form>
```
```coffee
$('#window-open-with-ajax').click ->
  newWindow = window.open()
  frm = $('form')

  frm.submit (e) ->
    e.preventDefault()
    $.ajax
      type: frm.attr('method')
      url: frm.attr('action')
      data: frm.serialize()
      success: ->
        newWindow.location.href = 'http://www.example.com/success'
      error: ->
        newWindow.location.href = 'http://www.example.com/error'
```
[Playground](https://jsfiddle.net/zhangshuo/wd4b2ypt/43/)

#### Reference:
* [window.open打开新窗口被拦截的解决方案](https://segmentfault.com/a/1190000015381923)
