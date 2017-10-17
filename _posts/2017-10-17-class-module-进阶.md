---
layout: post
title: 'Class Module 进阶'
date: 2017-10-17 23:56:45
comments: true
tags: [ruby]
comments: true
share: true
---

#### Ruby的内部类结构
```
Array.class # => Class
Class.class # => Class
```
#### superclass (父类)
```
Array.superclass # => Object
Object.superclass # => BasicObject
BasicObject.superclass # => nil
```
#### ancestors 继承链
`Array.ancestors # => [Array, Enumberable, Object, kernel]`
* ruby方法查找是自下而上的

```
# class structure, method finding

class User
  def name
    "name form User class"
  end
end

class Admin < USer
end

admin = Admin.new

p admin.name # => "name form User class"

puts Admin.ancestors => [Admin, User, ..., ...]
```
#### Method Overwrite

```
class User
  def name
    "name form User class"
  end
end

class User
  def name
    "Overwrite"
  end
end

user = User.new
puts user.name
```

#### Module本质上也是class(不能实例化的class)

```
Array.ancestors # => [Array, Enumberable, Object, Kernel]
Enumberable.class # => Module
Module.class # => Class
```

```
module Management
  def company_notifies
    "company_notifies from Management"
  end
end

class User
  include Management #可被当做User的父类

  def company_notifies
    puts super #调用父类同名方法
    "company_notifies from User"
  end

end

p User.ancestors # => [User, Management, Object ...]
```

```
module Management
  def company_notifies
    "company_notifies from Management"
  end
end

module Track
  def company_notifies
    "company_notifies from Track"
  end
end

class User
  include Management #可被当做User的父类
  include Track

  def company_notifies
    puts super #调用Track
    "company_notifies from User"
  end

end

p User.ancestors # => [User, Track, Management, Object ...]

```

```
module Management
  def company_notifies
    "company_notifies from Management"
  end
end

module Track
  include Management
  def company_notifies
    puts super #可以调用到Management
    "company_notifies from Track"
  end
end

p Track.ancestors # => [Track, Management]

include Track #模块内部的实例方法是不被直接在外部空间调用的，必须先include到当前的命名空间。
```

```
module Management
  def self.progress
    "progress"
  end

  #you need to include prepend extend
  def company_notifies
    "company_notifies from Management"
  end
end

puts Management.progress

```
#### include vs prepend
* include 把模块注入当前类的继承链后面
* prepend 把模块注入当前类的继承链前面
* extend 注入为类方法

```
module Management
  def company_notifies
    "company_notifies from Management"
  end
end

class User
  include Management
  #prepend Management

  def company_notifies
    "company_notifies from user"
  end
end

puts User.ancestors

```

#### included 方法
* 当模块被include时会被执行，同时会传递当前作用域的self对象

```
module Management
  def self.included base
    puts "Management is being included into #{base}"

    base.include InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def company_notifies
      "company_notifies frome Management"
    end
  end

  module ClassMethods
    def progress
      "progress"
    end
  end

end

class User
  include Management
end

user = User.new
puts User.progress
puts user.company_notifies
```
