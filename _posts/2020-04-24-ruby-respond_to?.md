---
layout: post
title: "Ruby: respond_to?"
date: 2020-04-24
tags: [ruby]
---

默认的`respond_to?`只检查`public`的方法：

```ruby
class User
  def hi
    puts 'hi'
  end

  private

  def hello
    puts 'hello'
  end
end

user = User.new
user.respond_to?(:hi)    # => true
user.respond_to?(:hello) # => false
```

如果想要检查`protected`和`private`的方法需要这样改：

```ruby
user.respond_to?(:hello, true)
```
