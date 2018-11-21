---
layout: post
title: 'Ruby: alias alias_method'
date: 2018-08-11 11:28:00
comments: true
tags: [ruby]
share: false
---
### Usage of alias
```
class User

  def full_name
    puts "Johnnie Walker"
  end

  alias name full_name
end

User.new.name #=>Johnnie Walker
```

### Usage of alias_method
```
class User
  def full_name
    puts "Johnnie Walker"
  end

  alias_method :name, :full_name
end
```

### Scoping with alias
```
class User

  def full_name
    puts "Johnnie Walker"
  end

  def self.add_rename
    alias_method :name, :full_name
  end
end

class Developer < User
  def full_name
    puts "Geeky geek"
  end
  add_rename
end

Developer.new.name #=> 'Gekky geek'
```
In the above case method `name` picks the method `full_name` defined in `Developer` class.

```
class User

  def full_name
    puts "Johnnie Walker"
  end

  def self.add_rename
    alias :name :full_name
  end
end

class Developer < User
  def full_name
    puts "Geeky geek"
  end
  add_rename
end

Developer.new.name #=> 'Johnnie Walker'
```

This is because `alias` is a keyword and it is `lexically scoped`. It means it treats `self` as the value of self at the time the source code was read . In contrast `alias_method` treats self as the value determined at the run time.

[1](https://blog.bigbinary.com/2012/01/08/alias-vs-alias-method.html)
