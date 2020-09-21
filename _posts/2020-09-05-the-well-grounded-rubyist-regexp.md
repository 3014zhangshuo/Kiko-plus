---
layout: post
title: "读书笔记：Ruby程序员修炼之道-正则表达式和基于正则表达式的字符串操作"
date: 2020-09-05
tags: [ruby, 读书笔记, Ruby程序员修炼之道]
---

#### 转义符的使用与含义

当需要匹配与这些字符相同的字符时，就必须使用反斜杠 `\` 进行转义。例如：

```ruby
/\?/
```

反斜杠的含义是 “不要降下一个字符作为特殊字符，而是使用它本身”。

#### 捕获组（capture group）的匹配顺序

```ruby
/(a)((b)c)/.match("abc")
# => #<MatchData "abc" 1:"abc" 2:"a" 3:"bc" 4:"c">
```

从左边开始计数的成对圆括号之间匹配的结果。

#### 具名捕获

```ruby
re = /(?<first>\w+)\s+((?<middle>\w\.)\s+)?(?<last>\w+)/
m = re.match("David A. Blank")
# => #<MatchData "David A. Blank" first:"David" middle:"A." last:"Blank">

m[:first] # => "David"
```

#### pre_match, post_match, begin, end

* pre_match  当前匹配结果的上一个字符
* post_match 当前匹配结果的下一个字符
* begin(1)   第一个捕获结果开始的第一个字符
* end(1)     第一个捕获结果开始的最后一个字符

#### 量词

* 零个或者一个 `/Mrs?/`，`Mr` 或者 `Mrs`
* 零个或者多个 `/Mrs*/`，`Mr` 、`Mrs`、`Mrssss`、`Mrssssssss`
* 一个或者多个 `/Mrs+/`，`Mrs`、`Mrssss`、`Mrssssssss`

##### 贪婪和非贪婪的量词

零个或者多个（*），一个或者多个（+）两个量词具有贪婪性，表明它们会尽可能多地匹配字符：

```ruby
string = "abc!def!ghi!"
match = /.+!/.match(string)
match[0]
# => "abc!def!ghi!"
```

修改成非贪婪

```ruby
string = "abc!def!ghi!"
match = /.+?!/.match(string)
match[0]
# => "abc!"
```

给出一个或者多个通配符，但仅仅和第一个感叹号位置的字符数量一样多，感叹号也被包含其中。

##### 最短匹配

* `*?` 0次以上的重复中最短的部分
* `+?` 1次以上的重复中最短的部分

#### 错误的分组

```ruby
/([A-Z]){5}/.match("David BLACK")
# => #<MatchData "BLACK" 1:"K">

/([A-Z]{5})/.match("David BLACK")
# => #<MatchData "BLACK" 1:"BLACK">
```

#### 锚点

`^`，`$`，`\A`，`\z`，`\Z`

* `\Z`，会匹配字符的结束但不包括可能存在的、紧随的换行符。在不确定字符串是否有一个换行符在结束位置（也许最后一行是从文本文件中读取而来），`\Z`就非常有用。

#### 修饰符

* `x` 忽视正则中的空格，可以写多行正则，方便写注释

#### 字符串和正则表达式相互转换

```ruby
str = "a.c"
re = /#{str}/
re.match("abc")
# => #<MatchData "abc">

re = /#{Regexp.escape(str)}/ # irb 输出了双反斜杠，因为它输出的是双引号的字符串。
re.match("abc")
# => nil
re.match("a.c")
# => => #<MatchData "a.c">
```

#### String#scan

```ruby
str = "Leopold Auer was the teacher of Jascha Heifetz."
violinists = str.scan(/([A-Z]\w+)\s+([A-Z]\w+)/)
# => [["Leopold", "Auer"], ["Jascha", "Heifetz"]]

str.scan(/([A-Z]\w+)\s+([A-Z]\w+)/) do |fname, lname|
  puts "#{lname}'s first name was #{fname}."
end
```

**还有一个 `StringScanner` 的标准库**

#### String#split

可以提供第二个参数，参数会限制返回元素的数量

```ruby
"a,b,c,d,e".split(/,/, 3)
# => ["a", "b", "c,d,e"]
```

#### String sub/sub! 和 gsub/gsub!

可以用代码块替换掉第二个参数

```ruby
"capitalize the first vowel".sub(/[aeiou]/) { |s| s.upcase }
# => "cApitalize the first vowel"

"capitalize the first vowel".gsub(/[aeiou]/) { |s| s.upcase }
# => "cApItAlIzE thE fIrst vOwEl"
```

#### 在替换字符串中使用分组捕获

```ruby
"aDvid".sub(/([a-z])([A-Z])/, '\2\1')
# => "David"

"double every word".gsub(/\b(\w+)/, '\1 \1')
# => "double double every every word word"
```

#### 正则表达是中都是字符串

grep 的选择会以 case 相等性运算符 (===) 为基础。因此，当指定一个正则表达式作为参数时，它将不会选择除字符串以外的任何对象，因此这样做会得到一个空数组：

```ruby
[1,2,3].grep(/1/)
# => []
```

因为数组中没有任何字符串元素可以匹配正则表达式 `/1/`，即没有任何元素可以满足 `/1/ === element` 的结果为真。

#### 捕获组例子

```ruby
/(.)(\d\d)+(.)/ =~ "123456"
p $1 # => "1"
p $2 # => "45"
p $3 # => "6"
```

#### $` and $& and $'

```ruby
/C./ =~ "ABCDEF"
$` # => "AB" 匹配部分前的字符串
$& # => "CD" 匹配部分的字符串
$' # => "EF" 匹配部分后的字符串
```

#### Q&A

Q. `$1` 这种是全局变量吗？

A. 不是，只是形似全局变量的局部变量，该歧义继承于 `Perl` 语言，看下面的例子
```ruby
def test_capture_group_variable_type
  str = "a"
  if str =~ /(a)/
    puts $1 # => a
  end
  puts $1 # => a
end

$1 # => nil
```
