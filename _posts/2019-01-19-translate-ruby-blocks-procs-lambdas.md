---
layout: post
title: 'Translate: Ruby blocks procs lambdas'
date: 2019-01-19 11:39:22
comments: true
tags: [translate ruby]
share: false
---

## 最终指南：Blocks, Procs & Lambdas
### 什么是ruby的代码块
> 代码块是可以传入方法的一段匿名（anonymous）函数，被包含在`do...end`语句中或者是`{}`之间，它们可以像方法一样传入参数，参数可以被定义在`|...|`之间，如果你之前使用过`each`方法，那么你已经使用过代码块了。

#### 例子：
```ruby
# 单行代码块
[1, 2, 3].each { |num| puts num }
                 ^^^^^ ^^^^^^^^
                 参数   执行内容
```
```ruby
# 多行代码块
[1, 2, 3].each do |num|
  puts num
end
```
**代码块让ruby更加灵活和有趣，它允许你储存一段代码以供稍后使用**
