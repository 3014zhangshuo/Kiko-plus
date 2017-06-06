---
layout: post
title: '方法:cancancan demo的一些细节'
date: 2017-01-03 17:16
comments: true
categories: 
---
current_user的方法，之前做项目都是用devise这个gem，以为current_user是rails内建的一种方法。其实不然，具体代码如下:
```
def current_user
  User.new(session[:id])
end
```
current_user和购物车(current_cart)的原理都是相同的，都是进门的时候给你一个门卡`session[:id]`，用它来判断你是不是当前用户。

cancancan是通过这个方法来实例化当前用户的
```
def current_ability
  @current_ability ||= Ability.new(current_user)
end
```
`alias_method :current_user, :my_own_current_user`

通过定义这个动作来限定用户的权限
```
def initialize(user)
  user ||= User.new

  if user.role?(:admin)
    can :manage, :all
  elsif user.role?(:moderator)
    can :create, Project
    can :read, Project
  elsif user.role?(:user)
    can :read, Project
  end
end
```
那manage、read....都对应的什么action呢(manage代表你能做所有的事情)
```
alias_action :index, :show, :to => :read
alias_action :new, :to => :create
alias_action :edit, :to => :update
alias_action :update, :destroy, :to => :modify
```
cacancan还帮你写了这个方法`load_and_authorize_resource`，它能做:
- First, the authorize! method calls because authorize_resource does this job for us.
- Second, removed the index, new, and edit actions completely, because they are handled by load_resource.
- Third, removed the @example = Example.find(params[:id]) line from the update and destroy actions as well as the @example = Example.new(project_params) from create, because once again load_resource takes care of this for us.


参考:[1](https://www.sitepoint.com/cancancan-rails-authorization-dance/)[2](https://github.com/CanCanCommunity/cancancan/wiki/Changing-Defaults)[3](https://github.com/CanCanCommunity/cancancan/wiki/Ensure-Authorization)[4](https://github.com/CanCanCommunity/cancancan/wiki/Checking-Abilities)