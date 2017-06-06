---
layout: post
title: '记录:mySQL和PG数据库的bug'
date: 2017-02-22 21:21
comments: true
categories: 
---
今天写了一个按ID搜索Order的功能，本地测好好的，删除数据也没有问题。但是上传到服务器就爆照了。
`PG::UndefinedFunction: ERROR:  operator does not exist: integer ~~ unknown
LINE 1: SELECT  "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1`
google到解法是需要把id装化成text来进行搜索。
```
  def self.search(search)
    where("id LIKE ?", "%#{search}%")
  end
```
```
  def self.search(search)
    where("cast(id as text)  LIKE ?", "%#{search}%")
  end
```
```
PG::UndefinedFunction: ERROR: operator does not exist: integer ~~ unknown
LINE 1: SELECT "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1...
^
HINT: No operator matches the given name and argument type(s). You might need to add explicit type casts.

+ 18 non-project frames
19
File "/home/apps/ResumeHack/releases/20170222130951/app/views/admin/users/index.html.erb" line 17 in _app_views_admin_users_index_html_erb__1789657452791902902_63319200
+ 106 non-project frames
ActiveRecord::StatementInvalid: PG::UndefinedFunction: ERROR: operator does not exist: integer ~~ unknown
LINE 1: SELECT "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1...
^
HINT: No operator matches the given name and argument type(s). You might need to add explicit type casts.
: SELECT "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1 OFFSET $2
+ 18 non-project frames
19
File "/home/apps/ResumeHack/releases/20170222130951/app/views/admin/users/index.html.erb" line 17 in _app_views_admin_users_index_html_erb__1789657452791902902_63319200
+ 106 non-project frames
ActionView::Template::Error: PG::UndefinedFunction: ERROR: operator does not exist: integer ~~ unknown
LINE 1: SELECT "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1...
^
HINT: No operator matches the given name and argument type(s). You might need to add explicit type casts.
: SELECT "users".* FROM "users" WHERE (id LIKE '%%') LIMIT $1 OFFSET $2
+ 18 non-project frames
19
File "/home/apps/ResumeHack/releases/20170222130951/app/views/admin/users/index.html.erb" line 17 in _app_views_admin_users_index_html_erb__1789657452791902902_63319200
+ 106 non-project frames

```
[1](http://stackoverflow.com/questions/26873955/actionviewtemplateerror-pgundefinedfunction-error-operator-does-not-exi)