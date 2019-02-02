---
layout: post
title: 'Ruby: Constant lookup'
date: 2019-01-22 11:39:22
comments: true
tags: [ruby]
share: false
---

# Ruby Constant lookup
* Each entry in Module.nesting
* Each entry in Module.nesting.first.ancestors
* Each entry in Object.ancestors if
Module.nesting.first is nil or a module.

### Module.nesting

```ruby
module A
  module B; end
  module C
    module D
      B == A::B
    end
  end
end
```
第一次会寻找`A::C::D::B`(不存在)，然后寻找`A::C::B`(不存在)，最终找到`A::B`(存在)。

```ruby
module A
  module C
    module D
      Module.nesting == [A::C::D, A::C, A]
    end
  end
end
```

```ruby
module A
  module B; end
end

module A::C
  B
end
# NameError: uninitialized constant A::C::B
```
这样ruby无法寻找到`A::C::B`，因为不在当前的`Module.nesting`。如果想要寻找到`B`, `Module.nesting`必须包含`A`。

### Ancestors
```ruby
class A
  module B; end
end

class C < A
  B == A::B
end
```
如果在`Module.nesting`中未查找到常量的定义，ruby会沿着继承链来寻找。
```ruby
class A
  def get_c
    C
  end
end

class B < A
  module C
  end
end

B.new.get_c
# => NameError: uninitialized constant A::C
```
```
class C < A
  class D
    puts Module.nesting
  end
end
```

### Reference:
[Autoloading and Reloading Constants](https://guides.rubyonrails.org/autoloading_and_reloading_constants.html)

[Everything you ever wanted to know about constant lookup in Ruby](https://cirw.in/blog/constant-lookup.html)

[Ruby constant lookup: The good, the bad and the ugly](https://makandracards.com/makandra/20633-ruby-constant-lookup-the-good-the-bad-and-the-ugly)

[Rails autoloading — how it works, and when it doesn't](https://urbanautomaton.com/blog/2013/08/27/rails-autoloading-hell/)

[Rails 中的类加载机制](https://ruby-china.org/topics/26034)
