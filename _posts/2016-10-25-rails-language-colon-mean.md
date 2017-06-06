---
layout: post
title: '知识点:rails 语言中冒号的意思？（：）'
date: 2016-10-25 22:19
comments: true
categories: 
---
before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]


：后面的叫Symbol，有点像一种“变量”，symbol有个名字id，但Symbol不需要负值.

A Symbol is the most basic Ruby object you can create. It's just a name and an internal ID. Symbols are useful because a given symbol name refers to the same object throughout a Ruby program. Symbols are more efficient than strings. Two strings with the same contents are two different objects, but for any given name there is only one Symbol object. This can save both time and memory.

更多详细信息请参看如下网址：
http://rubylearning.com/satishtalim/ruby_symbols.html