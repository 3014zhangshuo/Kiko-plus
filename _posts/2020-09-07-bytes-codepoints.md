---
layout: post
title: "计算机字符编码"
date: 2020-09-07
tags: [computer-science, term]
---

计算机最小储存单位是位（bit)，是二进制数，计算机在设计采用了 8位（bit）作为一个字节（byte），一个字节能表示的最大的整数就是255（二进制11111111 = 十进制255）。

人类语言中的符号用十进制的数字来表示，由于计算机是美国人发明的，最早只有127个字符被编码到计算机里，也就是大小写英文字母、数字和一些符号，这个编码表被称为ASCII编码，一个字节（byte）代表一个符号（比如`A`，十进制数是`65`，二进制数是`1000001`不够8位，首位使用0补位）。

随着计算器在非英语国家普及，`ASCII` 编码不够用了，这时候 `Unicode`（用两个字节表示一个字符，如果非常偏僻的字符，就需要4个字节）编码被设计出来（`utf-8` 是 `Unicode` 的一种实现，是一种可变长度编码），在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。

在 ruby 中：
* `codepoints` 返回的是字符 Unicode 编码数字表示（十进制数）（return unicode codepoints）
* `bytes` 返回的是每个 byte 的大小（returns individual bytes, regardless of char size）

```ruby
s = '日本語'
s.bytes # => [230, 151, 165, 230, 156, 172, 232, 170, 158]
s.codepoints # => [26085, 26412, 35486]
s.chars # => ["日", "本", "語"]

s.bytes.pack('c*').force_encoding('UTF-8') == s # c represent 8-bit unsigned (unsigned char)，* represent all remaining array elements will be converted
```

```ruby
"\xe4\xb8\xa5" # => "严"
"\u4e25" # => "严"
```

上面代码中的 `\x` 和 `\u` 分别代表什么：`\u` 表示是 `unicode` 编码，`\x` 表示是 `uft-8` 编码。

---

* [字符串和编码](https://www.liaoxuefeng.com/wiki/1016959663602400/1017075323632896)
* [字符编码笔记：ASCII，Unicode 和 UTF-8](http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html)
* [UTF-8 到底是什么意思？unicode编码简介](https://zhuanlan.zhihu.com/p/137875615)
* [Bytes vs codepoints in ruby](https://stackoverflow.com/questions/40849265/bytes-vs-codepoints-in-ruby)
