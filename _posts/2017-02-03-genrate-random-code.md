---
layout: post
title: '方法:genrate random code'
date: 2017-02-03 21:46
comments: true
categories: 
---
```
class User
  #use after create for setting the username
  after_create :set_username
  private
    def set_username
       self.username = "user-#{ SecureRandom.hex(10)}"
    end
end
```
```
class User
  #use before update for setting the username
  before_update :set_username
  private
    def set_username
       self.username = "user-#{ SecureRandom.hex(10)}"
    end
end
```
上面两个方法在devise里面是等价的，但是不可以用before_create,因为注册成功会update一下，导致生成的user_name在update时候没有了。
来源[1](http://stackoverflow.com/questions/27197976/create-random-username-for-devise-user)

resumehack用来生成user_code的方法如下model user
```
before_update :create_user_code

private

  def create_user_code
    if self.user_code.blank?
       self.user_code = SecureRandom.hex
       self.save!
    end
  end
```

<hr>
[Simple invitation access code using Rails 4 & Devise](http://headynation.com/simple-invitation-access-code-using-rails-4-devise/)
[How to Add an Invitation Code to Devise and Rails](http://www.rymcmahon.com/articles/8)
[Ruby On Rails User SignUp Email Confirmation Tutorial](https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial)