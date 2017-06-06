---
layout: post
title: 'valid rails console'
date: 2016-12-15 16:56
comments: true
categories: 
---
>如何检验值是否合法？可以在用rails console进行测试.

```
class Person < ApplicationRecord
  validates :name, presence: true
end
 
>> p = Person.new
# => #<Person id: nil, name: nil>
>> p.errors.messages
# => {}
 
>> p.valid?
# => false
>> p.errors.messages
# => {name:["can't be blank"]}
 
>> p = Person.create
# => #<Person id: nil, name: nil>
>> p.errors.messages
# => {name:["can't be blank"]}
 
>> p.save
# => false
 
>> p.save!   #用！强制保存，可以显示报错信息，这一点可以用来debug
# => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
 
>> Person.create!
# => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
```