---
layout: post
title: "读书笔记：Ruby IO encoding"
date: 2020-09-19
tags: [ruby, 读书笔记, 编码]
---

+ IO 编码
  + 内部编码：作为输入/输出对象的文件、控制台等的编码。
  + 外部编码：内部编码指的是Ruby脚本中的编码。

```ruby
p Encoding.default_external # => #<Encoding:UTF-8>
p Encoding.default_internal # => nil

File.open("foo.txt") do |f|
  p f.external_encoding # => #<Encoding:UTF-8>
  p f.internal_encoding # => nil
end
```

IO 编码设定 `IO#set_encoding`

```ruby
$stdin.set_encoding("GBK:UTF-8") # 外部编码名:内部编码名，不能一样
p $stdin.external_encoding # => #<Encoding:GBK>
p $stdin.internal_encoding # => #<Encoding:UTF-8>

File.open("foo.txt", "w:UTF-8")
```
