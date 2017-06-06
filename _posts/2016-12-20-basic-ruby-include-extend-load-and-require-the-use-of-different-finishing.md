---
layout: post
title: '知识点:基础 Ruby 中 Include, Extend, Load, Require 的使用区别(整理)'
date: 2016-12-20 13:42
comments: true
categories: 
---
>include 

当你Include一个模块到某个类时, 相当于把模块中定义的方法插入到类中。它允许使用 mixin。它用来 DRY 你的代码, 避免重复。例如, 当你有多个类时, 需要相同的函数时, 可以把函数定义到module中, 进行include。 下例假设模块Log和类TestClass在相同的.rb文件。如果它们存在于多个文件, 则需要使用 load 或 require 导入文件。
```
module Log 
  def class_type
    "This class is of type: #{self.class}"
  end
end

class TestClass 
  include Log 
end

tc = TestClass.new.class_type
puts tc #This class is of type: TestClass
```

>extend

当你使用Extend来替换 Include 的时候, 你会添加模块里的方法为类方法, 而不是实例方法。
（实例变量（Instance Variables）是当你使用它们时，才会被建立的对象。因此，即使是同一个类的实例，也可以有不同的实例变量。）当你在类中使用 Extend 来代替 Include, 如果你实例化 TestClass 并调用 class_type方法时，你将会得到 NoMethodError。再一次强调, 使用 Extend 时方法是类方法。
```
module Log
  def class_type
    "This class is of type: #{self.class}"
  end
end

class TestClass
  extend Log
  # ...
end

tc = TestClass.class_type
puts tc  # This class is of type: TestClass
```
>what‘s a mixin 

A mixin can basically be thought of as a set of code that can be added to one or more classes toadd additional capabilities without using inheritance. In Ruby, a mixin is code wrapped up in a
module that a class can include or extend (more on those terms later). In fact, a single class can have many mixins.

>require 

Require 方法允许你载入一个库并且会阻止你加载多次。当你使用 require 重复加载同一个library时，require方法 将会返回 false。当你要载入的库在不同的文件时才能使用 require 方法。下例将演示 require 的使用方式。

文件 test_library.rb 和 test_require.rb 在同一个目录下。
```
# test_library.rb
puts " load this libary "
```
```
# test_require.rb
puts (require './test_library')
puts (require './test_library')
puts (require './test_library')
# 结果为
#  load this libary 
# true
# false
# false
```
>load

Load 方法基本和 require 方法功能一致，但它不会跟踪要导入的库是否已被加载。因此当重复使用 load 方法时，也会载入多次。大部分情况你都会使用 require 来代替 load。但当你需要每次都要加载时候你才会使用 load, 例如模块的状态会频繁地变化, 你会使用 load 进行加载，获取最新的状态。
```
puts load "./test_library.rb"  #在这里不能省略 .rb, require可以省略
puts load "./test_library.rb" 
puts load "./test_library.rb" 
#结果
# load this libary
#true
# load this libary
#true
# load this libary
#true
```
资料[mixin](https://www.sitepoint.com/ruby-mixins-2/)
   [rubychina](https://ruby-china.org/topics/25706)