---
layout: post
title: 'is_a? & kind_of? & instance_of?'
date: 2017-10-10 21:32
comments: true
tags: [ruby]
comments: true
share: true
---
* `is_a?`和`kind_of?`用法相同，传递一个class，判断对象是否为class的instance或者subclass的instance
* `instance_of?`直接判断是否为class的instance，不包含subclass

```
kind_of? and is_a? are synonymous. instance_of? is different from the other two in that it only returns true if the object is an instance of that exact class, not a subclass.

Example: "hello".is_a? Object and "hello".kind_of? Object return true because "hello" is a String and String is a subclass of Object. However "hello".instance_of? Object returns false.
```

[is_a&kind_of?](https://ref.xaio.jp/ruby/classes/object/kind_of)
[instance_of?](https://stackoverflow.com/questions/3893278/ruby-kind-of-vs-instance-of-vs-is-a)
