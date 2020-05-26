---
layout: post
title: "Ruby: 怎么判断一个数组是另一个数组的子集"
date: 2020-05-26
tags: [ruby]
---

*如果没有重复的元素的话，可以用 `Set`*

```ruby
set = [1,2,3,4,5]
subset = [1,2]
```

#### 执行效率高的写法：

```ruby
(subset - (subset & set)).empty?
```

#### 可读性高的写法：

```ruby
subset.all? { |element| set.include?(element) }
```


```ruby
require 'benchmark'

N = 1_000_000

Benchmark.bmbm do |x|
  x.report("fastest")  { N.times { (subset - (subset & set)).empty? } }
  x.report("readable") { N.times { subset.all? { |element| set.include?(element) } } }
end
```