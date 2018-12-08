---
layout: post
title: 'Metaprogramming Ruby: class_eval and instance_eval'
date: 2018-06-13 09:00:00
comments: true
tags: [Ruby]
share: false
---
> `class_eval` and `instance_eval`. These methods allow you to evaluate arbitrary code in the context of a particular class or object. They're slightly similar to `call`, `apply` and `bind` in JavaScript, in that you are altering the value of `self` (`this` in JavaScript) when you use them. Let's take a look at some examples to demonstrate their usage.

```ruby
class Person
end

Person.class_eval do
  def say_hello
   "Hello!"
  end
end

jimmy = Person.new
jimmy.say_hello # "Hello!"
```

```ruby
class Person
end

Person.class_eval do
  def self.say_hello
   "Hello!"
  end
end

Person.say_hello # "Hello!"
```

```ruby
class Person
end

Person.instance_eval do
  def human? # same self.human?
    true
  end
end

Person.human? # true
```

In these examples `class_eval` creates instance methods and `instance_eval` creates class methods.

 `class_eval` is a method of the Module class, meaning that the receiver will be a module or a class. The block you pass to `class_eval` is evaluated in the context of that class. Defining a method with the standard `def` keyword within a class defines an instance method, and that's exactly what happens here.

 `instance_eval`, on the other hand, is a method of the `Object` class, meaning that the receiver will be an object. The block you pass to `instance_eval` is evaluated in the context of that object. That means that `Person.instance_eval` is evaluated in the context of the `Person` object. Remember that a class name is simply a constant which points to an instance of the class `Class`. Because of this fact, defining a method in the context of `Class` instance referenced by `Person` creates a class method for `Person` class.

[S](https://www.jimmycuadra.com/posts/metaprogramming-ruby-class-eval-and-instance-eval/)
