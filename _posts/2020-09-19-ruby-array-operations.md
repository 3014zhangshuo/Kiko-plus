---
layout: post
title: "读书笔记：Ruby Array 操作"
date: 2020-09-19
tags: [ruby, 读书笔记, 数组, Array]
---

#### 索引使用

`[n, len]` 表示从 a[n] 开始，获取之后的 len 个元素

```
alpha = %w[a b c d e]
p alpha[2, 3] # => ["c", "d", "e"]
```

从某个元素开始，获取多个元素

* a.at(n)         # 与 a[n] 等价
* a.slice(n)      # 与 a[n] 等价
* a.slice(n..m)   # 与 a[n..m] 等价
* a.slice(n, len) # 与 a[n, len] 等价

#### 元素赋值

```ruby
alpha = %w[a b c d e f]
# 对数组第三个元素到第五个元素赋值
alpha[2, 3] = %w[C D E] # => ["a", "b", "C", "D", "E", "f"]
# 多出来的会接着后面的
alpha[2, 3] = %w[C D E] # => ["a", "b", "C", "D", "E", "F", "f"]

# 指定 [n, 0] 后，就会在索引值为 n 的元素前插入新元素
alpha[2, 0] = %w[X Y]
```

#### 作为集合

* 交集 ary = ary1 & ary2
* 并集 ary = ary1 | ary2
* 集合的差 ary = ary1 - ary2

##### “|” 与 “+” 的不同点

```ruby
num = [1, 2, 3]
even = [2, 4, 6]
p (num + even) # => [1, 2, 3, 2, 4, 6]
p (num | even) # => [1, 2, 3, 4, 6]
```

#### 队列 与 栈

```ruby
# 队列
alpha = %w[a b c d e]
p alpha.push("f") # => ["a", "b", "c", "d", "e", "f"]
p alpha.shift     # => "a"

# 栈
alpha = %w[a b c d e]
p alpha.first  # => 1
p alpha.last   # => 5
```
