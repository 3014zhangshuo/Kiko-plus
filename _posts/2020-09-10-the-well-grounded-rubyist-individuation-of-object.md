---
layout: post
title: "读书笔记：Ruby程序员修炼之道-对象的个性化"
date: 2020-09-10
tags: [ruby, 读书笔记, Ruby程序员修炼之道]
---

#### 单例类和单例方法

Integer, Float, Symbol 不能定义单例方法

```ruby
class << 10; end  # TypeError (can't define singleton)
class << 1.0; end # TypeError (can't define singleton)
class << :a; end  # TypeError (can't define singleton)
```

两种定义单例方法的不同，常量的解析方式不同

```ruby
N = 1
obj = Object.new

class << obj
  N = 2
end

def obj.a_method
  puts N
end

class << obj
  def another_method
    puts N
  end
end

obj.a_method
# => 1
obj.another_method
# => 2
```

##### singleton_class

```ruby
str = "a string"
str.singleton_class.ancestors
# => [#<Class:#<String:0x00007fa6b0331270>>, String, Comparable, Object, Kernel, BasicObject]
```

##### 子类可以继承父类的单例方法

这个方法的查找顺序有关

```ruby
class C
end

def C.a_class_method
  puts "Singleton method defined on C"
end

C.a_class_method
# Singleton method defined on C
# => nil

class D < C
end

D.a_class_method
# Singleton method defined on C
# => nil
```

##### tap 方法

```ruby
"Hello".tap { |string| puts string.upcase }.reverse
# HELLO
# => "olleH"
```
