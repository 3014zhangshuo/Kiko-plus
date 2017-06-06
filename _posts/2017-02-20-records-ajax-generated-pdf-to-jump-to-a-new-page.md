---
layout: post
title: '记录:ajax生成pdf跳转新的页面'
date: 2017-02-20 22:17
comments: true
categories: 
---
```
success: function(result) {
    var link = "<%= user_resume_preview_path(@resume,format: :pdf) %>"; 给定新的链接
    window.open(link, '_blank'); 打开新的链接
}
```