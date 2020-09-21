---
layout: post
title: "Ruby 边缘知识"
date: 2020-09-19
tags: [ruby]
---

#### 行的开头用 `=begin` 和 `=end` 括起来的部分也是注释

```ruby
=begin
  This is comment
  with multiple lines
=end
```

#### 变量前加上 `*`，表示 Ruby 会将未分配的值封装为数组赋值给该变量，也可以用在多重赋值上

```ruby
a, b, *c = 1, 2, 3, 4, 5

p c # => [3, 4, 5]
```

* 获取嵌套数组的元素

```ruby
ary = [1, [2, 3], 4]
a, b, c = ary

p a # => 1
p b # => [2, 3]
p c # => 4
```

```ruby
ary = [1, [2, 3], 4]
a, (b1, b2), c = ary

p a  # => 1
p b1 # => 2
p b2 # => 3
p c  # => 4
```

#### 对象的同一性

```
str1 = '1'
str2 = '1'

# detect value is equal
str1 == str2    # => true
str1.eql?(str2) # => true

# detect they are same object
str1.equal?(str2) # => false

# special case
1.0 == 1    # => true
1.0.eql?(1) # => false, use for more cautious programming
```

#### 循环控制关键字

+ break
+ next
+ redo

#### 基本类继承关系

+ BasicObject
  + Object
    + Array
    + String
    + Hash
    + Regexp
    + IO
      + File
      + StringIO
    + Dir
    + Numeric
      + Integer
        + Fixnum
        + Bignum
      + Float
      + Complex
      + Rational
    + Exception
    + Time

#### undef 删除方法

```ruby
def hi
  puts "hi"
end

undef hi
undef :hi # => NameError (undefined method `hi' for class `Object')
```

#### 赋值运算符

* `&&=`
* `||=`
* `^=`
* `&=`
* `|=`
* `<<=`
* `>>=`
* `+=`
* `-=`
* `*=`
* `/=`
* `%=`
* `**=`

#### 重新定义一元运算符

```ruby
class Point
  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x, @y = x, y
  end

  def inspect
    "(#{x}, #{y})"
  end

  def +@
    dup
  end

  def -@
    self.class.new(-x,-y)
  end

  def ~@
    self.class.new(y, x)
  end
end

point = Point.new(3, 6)
p +point # => (3, 6)
p -point # => (-3, -6)
p ~point # => (6, 3)
```

#### 重新定义下标方法

```ruby
class Point
  attr_writer :x, :y

  def [](index)
    case index
    when 0 then x
    when 1 then y
    else
      raise ArgumentError, "out of range `#{index}'"
    end
  end

  def []=(index, val)
    case index
    when 0
      self.x = val
    when 1
      self.y = val
    else
      raise ArgumentError, "out of range `#{index}'"
    end
  end
end

point = Point.new(3, 6)

p point[0] # => 3
point[0] = 1
p point[0] # => 1
```

#### 异常类和语法补充

```ruby
class Foo
  # something defined
rescue => ex
  # Exception handler
ensure
  # something must execute
end
```

+ Exception
  + SystemExit
  + NoMemoryError
  + SignalException
  + ScriptError
    + LoadError
    + SyntaxError
    + NotImplementedError
  + StandardError
    + RuntimeError
    + SecurityError
    + NameError
      + NoMethodError
    + IOError
      + EOFError
    + SystemCallError
      + Errno::EPERM
      + Errno::ENONET

#### 位运算 **

```ruby
def pb(i)
  # 使用 printf 的 %b 格式
  # 将证书的末尾 8 位用 2 进制表示
  printf("%08b\n", i & 0b11111111)
end

b = 0b11110000
pb(b)              # => 11110000
pb(~b)             # => 00001111 按位取饭
pb(b & 0b00010001) # => 00001000 按位与
pb(b | 0b00010001) # => 11110000 按位或
pb(b ^ 0b00010001) # => 11100001 按位异或
pb(b >> 3)         # => 00011110 位右移
pb(b << 3)         # => 10000000 位左移
```

#### 计数

* `n.times { |i| ... }`
* `from.upto(to) { |i| ... }`
* `from.downto(to) { |i| ... }`
* `from.step(to, step) { ... }` step不传就是from处理结果

#### Here Document

```ruby
print(<<"EOB")
1
2
EOB
```

#### Encoding.compatible?(str1, str2)

检查两个字符串的兼容性，兼容性是指两个字符串是否可以连接。可兼容则返回字符串连接后的编码，不可兼容则返回nil。

#### IO tty? 方法

通常标准输入、标准输出、标准错误输出都是与控制台关联的。但是将命令的输出重定向到文件，或者使用管道（pipe）将结果传递给其他程序时则与控制台没有关系。

```ruby
# tty.rb
if $stdin.tty?
  print "Stdin is a TTY.\n"
else
  print "Stdin is not a TTY.\n"
end
```

```shell
ruby tty.rb # => Stdin is a TTY.

echo | ruby tty.rb     # => Stdin is not a TTY.
ruby tty.rb < data.txt # => Stdin is not a TTY.
```

#### IO binmode

新的 IO 对象默认是文本模式，使用 binmode 方法可将其变更为二进制模式

```ruby
File.open("foo.txt", "w") do |io|
  io.binmode
  io.write "Hello, world.\n"
end
```

#### IO 缓冲

在向控制台输出的两种方式（标准输出与标注错误输出）中，标准错误输出完全不采用缓冲处理。

```ruby
# test_buffering.rb

$stdout.print "out1 "
$stderr.print "err1 "
$stdout.print "out2 "
$stdout.print "out3 "
$stderr.print "err2\n"
$stdout.print "out4\n"

ruby test_buffering.rb
err1 err2
out1 out2 out3 out4
```

`io.flush` 强制输出缓冲，或者通过 `io.sync = true`，程序写入缓冲时 `flush` 方法就会被自动调用。
