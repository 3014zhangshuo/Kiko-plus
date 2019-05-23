---
layout: post
title: 'Ruby: include, extend, load, require的使用方法'
date: 2016-12-20
comments: true
tags: [ruby]
---

### include
可以使用include将方法注入到类中作为其的实例方法，它会提高代码的复用，让代码符合DRY原则

```ruby
module Log
  def class_type
    "This class is of type: #{self.class}"
  end
end

class TestClass
  include Log
end

classtype = TestClass.new.class_type

puts classtype
# => "This class is of type: TestClass"
```

### extend

当使用extend来为类注入模块时, 你会添加模块里的方法为类方法, 而不是实例方法。

```ruby
module Log
  def class_type
    "This class is of type: #{self.class}"
  end
end

class TestClass
  extend Log
end

classtype = TestClass.class_type

puts classtype
# => "This class is of type: TestClass"
```

### require

require方法允许你载入一短代码并且会阻止你再次载入。当你使用require重复加载同一段代码时，require方法将会返回false。

下面代码中的文件`test_library.rb`和`test_require.rb`在同一个目录下。

```ruby
# test_library.rb

puts " load this libary"
```

```ruby
# test_require.rb

3.times do
  puts (require './test_library')
end

# output
# 第一次执行require，运行代码，返回true
# => "load this libary"
# true
# 第二次执行require，已执行过返回false
# => false
# 第三次执行require，已执行过返回false
# => false
```

### lood

load方法的作用跟require的作用都是载入一段代码，但它不会记录代码是否被再如果。因此当重复使用load方法时，代码也会重复载入执行。大部分情况你都会使用require来代替load。但当你需要每次都要加载时候你才会使用load, 例如模块的状态会频繁地变化, 你会使用load进行代码加载，获取最新的状态。

```ruby
puts load "./test_library.rb"  # 在这里不能省略文件后缀.rb, require可以省略
puts load "./test_library.rb"
puts load "./test_library.rb"
# output
# 第一次执行load，运行代码，返回true
# => "load this libary"
# true
# 第二load，运行代码，返回true
# => "load this libary"
# true
# 第二load，运行代码，返回true
# => "load this libary"
# true
```

### 参考：

* [ruby-mixins-2](https://www.sitepoint.com/ruby-mixins-2/)
* [基础 Ruby 中 Include, Extend, Load, Require 的使用区别](https://ruby-china.org/topics/25706)
