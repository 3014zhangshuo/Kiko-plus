---
layout: post
title: "Ruby: Memoization Patterns"
date: 2019-03-08 11:39:22
comments: true
tags: [ruby]
share: false
---
一些方法会进行数据的运算或者是大量查询，通常会把这样的方法返回的值进行缓存，以便再次调用直接读取结果，下面是几种不同的缓存方式。

### Basic memoization
```ruby
def users_with_discounts
  @users_with_discounts ||= User.includes(payment_plan: :discounts).where(paying: true).to_a
end
```

### Multi-line memoization
#### Use Block
```ruby
def main_address
  @main_address ||= begin
    maybe_main_address = home_address if prefers_home_address?
    maybe_main_address = work_address unless maybe_main_address
    maybe_main_address = addresses.first unless maybe_main_address
  end
end
```
#### Use NilCheck
```ruby
def users_with_discounts
  return @users_with_discounts unless @users_with_discounts.nil?

  users = User.includes(payment_plan: :discounts).where(paying: true).to_a
  @users_with_discounts = users.select do |users|
    users.payment_plan.discounts.any? && !users.payment_plan.delayed?
  end
end
```
### What about nil?
But these memoization patterns have a nasty, hidden problem, if calculated result return nil.

Every single time we'd call the method, the instance variable would be `nil`, and we'd perform fetches again.

So, `||=`is probably not the right way to go. Instead, we have to differentiate between `nil` and `undefined`.

The other way I can deal with the presence of nil is by putting it behind a cache. For the purposes of that cache, I’ll be using Ruby’s handy Hash.

```ruby
def users_with_discounts
  return @users_with_discounts if defined? @users_with_discounts
  @users_with_discounts ||= User.includes(payment_plan: :discounts).where(paying: true).to_a
end

def users_with_discounts
  @users_with_discounts ||= {}
  if @users_with_discounts.has_key?(:return_value)
    @users_with_discounts[:return_value]
  else
    @users_with_discounts[:return_value] = computation_that_returns_nil  
  end
end
```

### And what about parameters?
But what if you want to memoize a method that takes parameters, like this one?
```ruby
class City < ActiveRecord::Base
  def self.top_cities(order_by)
    where(top_city: true).order(order_by).to_a
  end
end
```

#### Use Hash.new with a block:
```ruby
Hash.new { |h, key| h[key] = calculated_value }
```
Then, every time you try to access a key in the hash that hasn’t been set, it’ll execute the block.
```ruby
class City < ActiveRecord::Base
  def self.top_cities(order_by)
    @top_cities ||= Hash.new do |h, key|
      h[key] = where(top_city: true).order(key).to_a
    end
    @top_cities[order_by]
  end
end
```

#### Use Hash has_key?
```ruby
def users_with_discounts(scoped_to={})
  @users_with_discounts ||= {}
  return @users_with_discounts[scoped_to] if @users_with_discounts.has_key?(scoped_to)

  @users_with_discounts[scoped_to] = User.includes(payment_plan: :discounts).where(
    paying: true,
    **scoped_to
  ).to_a
end
```

### Reference:
[Memoization GEM](https://github.com/matthewrudy/memoist)

[Memoization in Ruby (made easy)](https://engineering.gusto.com/memoization-in-ruby-made-easy/)

[4 Simple Memoization Patterns in Ruby (And One Gem)](https://www.justinweiss.com/articles/4-simple-memoization-patterns-in-ruby-and-one-gem/)
