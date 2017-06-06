---
layout: post
title: '方法:两个table已建立关系的话，如何利用一个table从数据库调出另一个table'
date: 2017-01-21 20:26
comments: true
categories: 
---
简历项目在后台想显示已拥有的resume_html的resume数量。不能直接用user.resume_html.count，因为resume_html和user没有建立关系，只能通过user和resume的关系进行搜索`user.resumes`。resume_html和resume的关系如下:
```
class Resume < ApplicationRecord
	has_one :resume_html
end
```
```
class ResumeHtml < ApplicationRecord
	belongs_to :resume
end
```
在admin index尝试这么写`<td><%= link_to(user.resumes.where.not(:resume_html => nil).count, admin_user_resumes_path(user)) %></td>`
报错如下:`SQLite3::SQLException: no such column: resumes.resume_id: SELECT COUNT(*) FROM "resumes" WHERE "resumes"."user_id" = ? AND ("resumes"."resume_id" IS NOT NULL)`
后来尝试这么写`<%= link_to(Resume.where(:user_id => user.id,:resume_html  => nil).count, admin_user_resumes_path(user)) %>`，报错`SQLite3::SQLException: no such column: resumes.resume_id: SELECT COUNT(*) FROM "resumes" WHERE "resumes"."user_id" = ? AND "resumes"."resume_id" IS NULL`。
然后这么写`<% resume = Resume.where(:resume_html => !nil) %>`
        `<%= link_to(resume.where(:user_id => user.id).count, admin_user_resumes_path(user)) %>`
报错`SQLite3::SQLException: no such column: resumes.resume_id: SELECT COUNT(*) FROM "resumes" WHERE "resumes"."resume_id" = 't' AND "resumes"."user_id" = ?`，这里把resume_id当成了true，如果去掉感叹号的话，resume_id就会被人成为false。
后来想到建立关系后可能会有不一样的where query写法，google结果如下:
>范例一

```
class Item < ActiveRecord::Base
has_one :purchase
end

class Purchase < ActiveRecord::Base
belongs_to :item
end
```
```
purchases = Purchase.all
Item.where('id not in (?)', purchases.map(&:item_id))
```
`not_purchased_items = Item.joins("LEFT OUTER JOIN purchases ON purchases.item_id = items.id").where("purchases.id IS null")`
但是好像跟我想的效果没有太大关系.....

>范例二

```
class Class1 < ActiveRecord::Base
  has_one :class2
end

class Class2 < ActiveRecord::Base
  belongs_to :class1
end
```
`Class1.where("class2 is present")`
上面写法报错`SQLite3::SQLException: no such column: resume_html: SELECT COUNT(*) FROM "resumes" WHERE "resumes"."user_id" = ? AND (resume_html is present)`
因为resume没有resume_html这个column。
`Class1.joins(:class2)`

采用范例二的方法

参考资料:[1](http://stackoverflow.com/questions/12515268/finding-nil-has-one-associations-in-where-query),[2](http://stackoverflow.com/questions/18247282/activerecord-where-query-based-on-has-one-association)