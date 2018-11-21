---
layout: post
title: 'Ruby: tap method'
date: 2018-11-01 00:24:00
comments: true
tags: [ruby]
share: false
---

#### The Tap Method : Yields self to the block, and then returns self.

According to the achieve of ruby code :
```
def tap
  yield self
  self
end
```

##### Used to debug
```
(1..10).to_a.select {|x| x.even? }.tap {|x| puts "evens: #{x}" }.map {|x| x*x }.tap {|x| puts "squares: #{x}" }
```

##### Reduce temporary variable and concise code
```
user = User.new
user.name = "John"
user

# tap way

User.new.tap { |user| user.name = "John" }
```

```
# superclass method
def self.new_with_session(params, session)
  new(params)
end

# subclass method without tap
def self.new_with_session(params, session)
  user = super
  if data = session["devise.facebook_data"]
    user.email = data["email"]
    user.confirmed_at = Time.now
  end
end

# subclass method use tap
def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"]
      user.email = data["email"]
      user.confirmed_at = Time.now
    end
  end
end
```

#### Reference:
* [Devise](https://github.com/plataformatec/devise)
* [7 Little-Known Ruby Methods To Help You Write Better Code](https://www.rubyguides.com/2017/10/7-powerful-ruby-methods/#Integerdigits_Method_Ruby_24)
* [Rails 技巧之 tap & try](https://ruby-china.org/topics/5348)
