---
layout: post
title: '知识点:ActiveRecord'
date: 2016-12-27 14:31
comments: true
categories: 
---
>Active Record(对象关系映射):

把程序中的对象和关系型数据库中的数据表连接起来。使用ORM，程序中对象的属性和对象之间的关系可以通过一种简单的方法从数据库获取。
>Active Record 中的“多约定少配置”原则:


使用其他编程语言或框架开发程序时，可能必须要编写很多配置代码。大多数的 ORM 框架都是这样。但是，如果遵循 Rails 的约定，创建 Active Record 模型时不用做多少配置（有时甚至完全不用配置）。Rails 的理念是，如果大多数情况下都要使用相同的方式配置程序，那么就应该把这定为默认的方法。所以，只有常规的方法无法满足要求时，才要额外的配置。
- 命名约定:Rails 把模型的类名转换成复数，然后查找对应的数据表。例如，模型类名为 Book，数据表就是 books。
         如果类名由多个单词组成，应该按照 Ruby 的约定，使用驼峰式命名法。例如，模型类名为BookClub，数据表就是
         book_clubs
- 模式约定：外键，使用singularized_table_name_id形式命名，例如item_id，order_id。创建模型关联后，
          ActiveRecord会查找这个字段；
          主键，默认情况下，Active Record 使用整数字段id作为表的主键。
          
ActiveRecord对象可以使用Hash创建，在块中创建，或者创建后手动设置属性。new方法会实例化一个对象，create方法实例化一个对象，并将其存入数据库。
create的方法:`user = User.create(name: "David", occupation: "Code Artist")`
new的方法:
```
user = User.new
user.name = "David"
user.occupation = "Code Artist"
这里必须调用user.save才会被存到数据库
```
create和new本质上都是下面这些代码:
```
user = User.new do |u|
  u.name = "David"
  u.occupation = "Code Artist"
end
```

>ActiveRecord数据库迁移

可以把每个迁移看做数据库的一个修订版本。数据库中一开始什么也没有，各个迁移会添加或删除数据表、字段或记录。ActiveRecord 知道如何按照时间线更新数据库(schema最上面有关于时间的版本号)，不管数据库现在的模式如何，都能更新到最新结构。同时，Active Record 还会更新db/schema.rb 文件，匹配最新的数据库结构。
` t.references :category # 等同於 t.integer :category_id`

>Active Record查询

获取单个对象的方法:利用主键(id)的方式、first、last、take、find_by、first！、last！、take！、find_by（末尾加入！会抛出 ActiveRecord::RecordNotFound 异常）
获取多个对象的方法:使用多个主键(.find([1, 10]))
                Model.take(limit) 方法获取 limit 个记录，不考虑任何顺序  Client.take(2)
                Model.first(limit) 方法获取按主键排序的前 limit 个记录   Client.first(2)
                Model.last(limit) 方法获取按主键降序排列的前 limit 个记录

          