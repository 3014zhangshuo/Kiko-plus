---
layout: post
title: "读书笔记：Ruby ASCII-8BIT encoding"
date: 2020-09-19
tags: [ruby, 读书笔记, 编码]
---

`ASCII-8BIT` 用于表示二进制数据以及字节串，也称 `BINARY`。

用 `Array#pack` 方法，把IP地址的4个数值转换为4个字节的字节串。

```ruby
str = [127, 0, 0, 1].pack("C4")
p str # => "\x7F\x00\x00\x01"
p str.encoding # => #<Encoding:ASCII-8BIT>
```

C4 表示 4 个 8 位的不带符号的整数。
