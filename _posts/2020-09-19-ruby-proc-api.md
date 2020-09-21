---
layout: post
title: "读书笔记：Ruby Proc 中一些不常用的API"
date: 2020-09-19
tags: [ruby, 读书笔记, 代码块, Proc]
---

#### prc.arity

```ruby
prc0 = Proc.new { nil }
prc1 = Proc.new { |a| a }
prc2 = Proc.new { |a, b| a + b }
prc3 = Proc.new { |a, b, c| a + b + c }
prcn = Proc.new { |*args| args }

p prc0.arity # => 0
p prc1.arity # => 1
p prc2.arity # => 2
p prc3.arity # => 3
p prcn.artiy # => -1
```

#### prc.parameters

+ :opt 可省略的变量
+ :req 必须的变量
+ :rest 以 *args 形式表示的变量
+ :key 关键字参数形式的变量
+ :keyrest 以 **args 形式便是的变量
+ :block 代码块

```ruby
prc0 = Proc.new { nil }
prc1 = Proc.new { |a| a }
prc2 = lambda { |a, b| [a, b] }
prc3 = lambda { |a, b=1, *c| [a, b, c] }
prc4 = lambda { |a, &block| [a, block] }
prc5 = lambda { |a: 1, **b| [a, b] }

p prc0.parameters # => []
p prc1.parameters # => [[:opt, :a]]
p prc2.parameters # => [[:req, :a], [:req, :b]]
p prc3.parameters # => [[:req, :a], [:opt, :b], [:rest, :c]]
p prc4.parameters # => [[:req, :a], [:block, :block]]
p prc5.parameters # => [[:key, :a], [:keyrest, :b]]
```

#### prc.source_location

返回定制prc的程序代码位置，返回值为 [代码文件名，行编号]

```ruby
prc = proc { nil }
prc.source_location # => ["(irb)", 63]
```
