---
layout: post
title: "读书笔记：Ruby程序员修炼之道-Enumerable"
date: 2020-09-05
tags: [ruby, 读书笔记, Ruby程序员修炼之道]
---

#### 普通用法

```ruby
class Rainbow
  include Enumerable

  def each
    yield "red"
    yield "orange"
    yield "yellow"
    yield "green"
    yield "blue"
    yield "indigo"
    yield "violet"
  end
end

r = Rainbow.new
r.each do |color|
  puts "Next color: #{color}"
end

y_color = r.find { |color| color.start_with?('y') }
```

#### Range 是浮点数不能迭代

```ruby
r = Range.new(1.0, 10.0)
r.one? { |n| n == 5 } # => TypeError: can't iterate from Float

# 起始点是整数可以迭代
r = Range.new(1, 10.0)
r.one? { |n| n == 5 } # => true

# 浮点数可以用 step 来迭代
r = Range.new(1.0, 10.0)
r.step(0.1) { |f| puts f }
```

这是为什么呢？我理解浮点数的范围是无限的，对它做 `each` 操作是无意义的。
为什么起始点是整数就可以，调用 `each` 的时候是把范围看做整数的集合的。

补充纠正为什么 `float range` 不能 `Range.each`，因为 `Range.each` 依赖 `succ` （例如：`Integer#succ`），而 `Float` 并没有实现这个方法，下面我们用一个花哨的方法让 `float range` 支持迭代：

```ruby
class Float
  alias succ next_float
end

r = Range.new(1.0, 10.0)
r.each { |f| puts f }
```

* [can-ruby-have-a-range-starting-with-a-float](https://stackoverflow.com/questions/43190251/can-ruby-have-a-range-starting-with-a-float)
* [Range#method-i-each](https://ruby-doc.org/core-2.4.1/Range.html#method-i-each)

#### find 的一种特例

```ruby
[1, 2, 3, 4, 5].find { |i| i > 5 } # => nil
[1, 2, 3, nil, 5].find { |i| i.nil? } # => nil
```

看上面的例子 `find` 满足条件或者不满足条件都可能返回 `nil`，无法判断真实的情形，这时候可以自定义 `failure` 时的返回值

```ruby
failure = lambda { 'Nothing to find' }
over_ten = [1, 2, 3, 4, 5].find(failure) { |i| i > 10 } # => Nothing to find
```

#### grep 方法

`Enumerable#grep` 方法会基于 `case` 的相等性运算符 `===`，从可枚举对象中选择元素。

了解这个知识可以写一些很花哨的代码：

```ruby
miscellany = [75, 'hello', 10...20, 'goodbye']
miscellany.grep(String) # => ['hello', 'goodbye'] 相当于 String === element
miscellany.grep(50..100) # => [75]
```

上面的代码等价于：

```ruby
enumerable.select { |element| expression === element }
```

grep 还可以传递代码块来处理返回值，这样可以省去再用 `map` 链式处理

```ruby
colors = %w{ red orange yellow green blue indigo violet }
colors.grep(/o/) { |color| color.capitalize } # => ["Orange", "Yellow", "Indigo", "Violet"]
colors.grep(/o/).map(&:capitalize) # => ["Orange", "Yellow", "Indigo", "Violet"]
```

#### take 和 drop 方法

```ruby
states = %w{ NJ NY CT MA VT FL }
states.take(2) # => ["NJ", "NY"] 取前两个元素
states.drop(2) # => ["CT", "MA", "VT", "FL"] 取前两个之外的元素

states.take_while { |i| /N/.match(i) } # => ["NJ", "NY"]
states.drop_while { |i| /N/.match(i) } # => ["CT", "MA", "VT", "FL"]
```

#### min 和 max 方法

```ruby
[1, 2, 3, 4, 5].min # => 1
[1, 2, 3, 4, 5].max # => 5
```

最小值和最大值通过 `<=>` 逻辑来判断

```ruby
%w{ Ruby C APL Perl Smalltalk }.min # => "APL"
%w{ Ruby C APL Perl Smalltalk }.min { |a, b| a.size <=> b.size } # => "C"
```

也可以使用 `min_by` 和 `max_by` 方法

```ruby
%w{ Ruby C APL Perl Smalltalk }.min_by(&:size)
%w{ Ruby C APL Perl Smalltalk }.max_by(&:size)
```

还有方便的 `minmax_by` 方法

```ruby
%w{ Ruby C APL Perl Smalltalk }.minmax_by(&:size) # => ["C", "Smalltalk"]
```

在 `hash` 中，`min` 和 `max` 使用 `key` 来决定大小顺序

```ruby
{ 1 => "C", 2 => "B", 3 => "A" }.min # => [1, "C"]
{ 1 => "C", 2 => "B", 3 => "A" }.max # => [3, "A"]
```

如果想用值来排序，要使用 `_by` 这类方法

```ruby
{ 1 => "C", 2 => "B", 3 => "A" }.min_by { |k, v| v } # => [3, "A"]
{ 1 => "C", 2 => "B", 3 => "A" }.max_by { |k, v| v } # => [1, "C"]
```

#### reverse_each 方法

```ruby
[1, 2, 3].reverse_each { |e| puts e }
# 3
# 2
# 1
# => [1, 2, 3]
```

#### each_slice 、each_cons 、 cycle 方法

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each_slice(3) { |slice| p slice }
# [1, 2, 3]
# [4, 5, 6]
# [7, 8, 9]
# [10]
# => nil
```

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each_cons(3) { |cons| p cons }
# [1, 2, 3]
# [2, 3, 4]
# [3, 4, 5]
# [4, 5, 6]
# [5, 6, 7]
# [6, 7, 8]
# [7, 8, 9]
# [8, 9, 10]
# => nil
```

```ruby
a = %w{ a b c }
a.cycle { |x| puts x }  # print, a, b, c, a, b, c,.. forever.
a.cycle(2) { |x| puts x }  # print, a, b, c, a, b, c.
```

#### 字符串的几种枚举方法

```ruby
str = "abcde"
```

##### each_byte

```ruby
str.each_byte { |b| p b }

str.bytes
```

##### each_char

```ruby
str.each_char { |c| p c }

str.chars
```

##### each_codepoint

```ruby
str.each_codepoint { |cp| p cp }

str.codepoints
```

##### each_line

```ruby
str = "This string\nhas three\nlines"
str.each_line { |l| puts "Next line: #{l}" }

str.lines
```

#### 可枚举对象的排序

不一定非要引入 `Comparable`，定义飞船符号 `<=>` 即可：

```ruby
def <=>(other_painting)
  self.price <=> other_painting.price
end
```

```ruby
year_sort = [pa1, pa2, pa3, pa4, pa5].sort do |a, b|
  a.year <=> b.year
end
```

```ruby
year_sort = [pa1, pa2, pa3, pa4, pa5].sort_by(&:year)
```

#### 创建枚举器

```ruby
e = Enumerator.new do |y|
  y << 1
  y << 2
  y << 3
end

e.to_a # => [1, 2, 3]
```

y 是一个传递者（yielder），也可以写成 `y.yield(1)`

枚举器对的代码块中也可以包含其他对象

```ruby
a = [1, 2, 3, 4, 5]
e = Enumerator.new do |y|
  total = 0
  until a.empty?
    total = a.pop
    y << total
  end
end

e.take(2) # => [5, 4]
a # => [1, 2, 3]
e.to_a # => [3, 2, 1]
a # => []
```

#### enum_for 和 to_enum

```ruby
str = "xyz"

enum = str.enum_for(:each_byte) # 或者是 str.to_enum(:each_byte)
enum.each { |b| puts b }
# => 120
# => 121
# => 122
```

```ruby
names = %w{ David Black Yukihiro Matsumoto }
e = names.enum_for(:inject, "Names: ")
e.each { |string, name| string << "#{name}..." }
# => "Names: David...Black...Yukihiro...Matsumoto..."
```

这里有一个副作用 `string` 指向的是同一个对象，再次调用是在其后面追加值。

**hash 调用 Enumerable#select**

```ruby
h = { cat: 'feline', dog: 'canine', cow: 'bovine' }
h.select { |k, v| k =~ /c/ }

# 将枚举器与 select 方法挂钩，可以返回一个和 select 方法运行效果一样的 each 方法

e = h.enum_for(:select)
e.each { |k, v| k =~ /c/ }

# 枚举器不挂钩 hash 的 select 方法，而是 each 方法

e = h.to_enum # 默认是 each

# 调用 each 方法返回值是一样的，因为枚举器也是调用 hash each 方法
h.each {} == e.each {}

e.select { |k, v| k =~ /c/ }
# => [["cat", "feline"], ["cow", "bovine"]]
```

上面为什么返回的数组而不是散列呢？关键点在于上个例子中调用 `select` 实际上是调用枚举器的 `select` 方法，而不是散列的。枚举器的 `select` 方法是直接构建在自己的 `each` 方法上的。事实上，枚举器的 `select` 方法是 `Enumerable#select`，它返回的是一个数组。

#### 枚举器的细粒度迭代

```ruby
names = %w{ David Yukihiro }
e = names.to_enum
e.next
```

#### 使用枚举器添加可枚举性

```ruby
module Music
  class Scale
    NOTES = %w{ c c# d d# e f f# g a a# b }
    def play
      NOTES.each { |note| yield(note) }
    end
  end
end

scale = Music::Scale.new
scale.map { |note| note.upcase } # raise NoMethodError

enum = scale.enum_for(:play)
p enum.map { |note| note.upcase }
# => ["C", "C#", "D", "D#", "E", "F", "F#", "G", "A", "A#", "B"]
p enum.select { |note| note.include?('f') }
# => ["f", "f#"]
```

#### 延迟枚举器

```ruby
def fb_calc(i)
  case 0
  when i % 35
    "FizzBuzz"
  when i % 3
    "Fizz"
  when i % 5
    "Buzz"
  else
    i.to_s
  end
end

def fb(n)
  (1..Float::INFINITY).lazy.map { |i| fb_calc(i) }.first(n)
end
```
