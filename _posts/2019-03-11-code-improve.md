---
layout: post
title: "Rails: Method Improve Remove Array Blank Item"
date: 2019-03-11 21:39:22
comments: true
tags: [rails]
share: false
---

### Remove Array Blank Item
```ruby
arr = ["", nil, " ", true, false]

arr.map(&:presence).compact # => [true]

arr.reject(&:blank?) # => [true]
```
*tips: in rails fasle is blank*

### Benchmark result
```ruby
Benchmark.bm do |measurer|
  arr = ["", nil, " ", true, false]

  measurer.report 'map' do
    1000.times { arr.map(&:presence).compact }
  end

  measurer.report 'reject' do
    1000.times { arr.reject(&:blank?) }
  end
end
```

|                  | user   | system | total  | real |
| ------           | ------ | ------ | ------ | ------------------ |
| map then compact | 0.000000 | 0.000000 | 0.000000 | (  0.004118) |
| reject           | 0.010000 | 0.010000 | 0.010000 | (  0.002823) |
