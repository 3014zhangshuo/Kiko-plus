---
layout: post
title: 'Ruby: Dynamic Add Method'
date: 2018-07-19 12:30:00
comments: true
tags: [ruby]
share: false
---
### Add class instance singleton_method
```
class MyClass
end

a = MyClass.new

MyClass.class_eval %{
  def hi
    p 'hi from class_eval'
  end
}

MyClass.send(:define_method, :hi2) { p 'hi from send define_method' }

a.hi   #=> "hi from class_eval"
a.hi2  #=>  "hi from send define_method"

a.methods.grep /^hi+/            #=> [:hi, :hi2]

MyClass.instance_methods (false) #=> [:hi, :hi2]
```

### Add class singleton_method

```
class MyClass
end

MyClass.class_eval %{
  def self.hi
    p 'hi from class_eval'
  end
}

MyClass.instance_eval %{
  def hi2
    p 'hi from instance_eval'
  end
}

MyClass.singleton_class.send(:define_method, :hi3) { p 'hi from singleton_class end define_method' }

class << MyClass
  def hi4
    p "hi from reopen Myclass singleton_class"
  end
end

MyClass.hi
MyClass.hi2
MyClass.hi3
MyClass.hi4

MyClass.methods(false)                           #=> [:hi, :hi2, :hi3, :hi4]
MyClass.singleton_methods(false)                 #=> [:hi, :hi2, :hi3, :hi4]
MyClass.singleton_class.instance_methods(false)  #=> [:hi, :hi2, :hi3, :hi4]
```

### Add method to singleton_class

```
class << MyClass # rarely used
  def self.hello
    p "i'm in 'MyClass.singleton_classs.methods'"
  end
end
MyClass.singleton_class.hello
MyClass.singleton_class.methods(false)
```

### Summary

- my_object is my_object.singleton_class instance
- my_object.methods = my_object.singleton_class.instance_methods
- my_object.methods = my_object.instance_methods + my_object.singleton_methods
- my_object.singleton_methods = my_object.singleton_class.instance_methods(false)
-


[eigenclass-1](https://ruby-china.org/topics/10479)
[eigenclass-2](https://ruby-china.org/topics/10483)
[metaclass](http://web.archive.org/web/20090615044849/http://whytheluckystiff.net/articles/seeingMetaclassesClearly.html)
