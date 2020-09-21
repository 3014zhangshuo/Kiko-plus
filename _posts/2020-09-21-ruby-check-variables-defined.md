---
layout: post
title: "Ruby 检查变量是否被定义"
date: 2020-09-21
tags: [ruby]
---

`defined?` is a keyword, not a method.

```ruby
# check local variable is defined
apple = 1
defined?(apple) # => "local-variable"
defined?(bacon) # => nil
local_variables.include?(:orange)

# check instance variable is defined
instance_variable_defined?("@food") # => false

# check method is defined
defined?(puts) # => "method"

# check if a class exists
defined?(Object) # => "constant"
defined?(A) # => nil
Object.const_defined?(:String)
Object.const_defined?(:A)
```

---

* [ruby-defined-keyword](https://www.rubyguides.com/2018/10/defined-keyword/)
