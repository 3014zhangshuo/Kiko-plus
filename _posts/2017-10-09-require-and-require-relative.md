---
layout: post
title: 'require and require_relative in ruby'
date: 2017-10-09 23:03
comments: true
tags: [ruby]
comments: true
share: true
---
* `require`&`require_relative`加载制定文件，如果加载成功则返回true，如果已经加载过则返回 false。
* require 如果文件名解析出来不是一个绝对路径，它将会在 `$LOAD_PATH` 列出的目录中被查找
* require_relative 加载制定名字的库
