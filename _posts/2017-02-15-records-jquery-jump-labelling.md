---
layout: post
title: '记录:jquery跳转指定标签'
date: 2017-02-15 10:25
comments: true
categories: 
---
```
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function (){
            $(".click1").click(function (){
                $('html, body').animate({
                    scrollTop: $("#div1").offset().top
                });
            });
        });
    </script>
``` 