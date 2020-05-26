---
layout: post
title: "Ruby: Array+reduce vs map+compact"
date: 2020-05-26
tags: [ruby]
---

使用 `map` 生成数组会产生 `nil` 的问题，这里我期望的是一个 `[]`

```ruby
[1,2,3,4,5].map { |e| e if e > 6 } # => [nil, nil, nil, nil, nil]
```

就需要在调用 `compact`

```ruby
[1,2,3,4,5].map { |e| e if e > 6 }.compact # => []
```

这里使用 `Array` + `reduce`（或者是 `inject`、`each_with_object`）可以代替 `map` + `compact`

```ruby
Array([1,2,3,4,5].reduce([]) { |result, e| result << e if e > 6 }) # => []
```

那种更好呢，上 `benchmark`

```ruby
require 'benchmark'

N = 1_000_000

Benchmark.bmbm do |x|
  x.report("Array+reduce")  { N.times { Array([1,2,3,4,5].reduce([]) { |result, e| result << e if e > 6 }) } }
  x.report("map+compact")   { N.times { [1,2,3,4,5].map { |e| e if e > 6 }.compact } }
end
```

*结果：`map+compact` 胜出*