---
layout: post
title: "CGI: Escape & Unescape"
date: 2019-03-20 21:39:22
comments: true
tags: [ruby]
share: false
---
```ruby
require 'cgi'

CGI.escape("http://weixin.qq.com/x/IZZSnsvgAbaeLPRvgeCD")
# => "http%3A%2F%2Fweixin.qq.com%2Fx%2FIZZSnsvgAbaeLPRvgeCD"

CGI.unescape("http%3A%2F%2Fweixin.qq.com%2Fx%2FIZZSnsvgAbaeLPRvgeCD")
# => "http://weixin.qq.com/x/IZZSnsvgAbaeLPRvgeCD"
```
