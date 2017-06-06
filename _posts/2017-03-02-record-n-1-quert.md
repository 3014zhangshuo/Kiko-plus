---
layout: post
title: '记录:N+1 Query'
date: 2017-03-02 13:47
comments: true
categories: 
---
@resumes = Resume.joins(:order)这是一个捞所有含有order的resume，因为resume也属于user，而在view端也要调用resume.user和resume.order的数据，SQL记录如下:先捞出我这个admin用户，然后根据resume的user_id去捞resume
```
User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? ORDER BY "users"."id" ASC LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Resume Load (0.3ms)  SELECT  "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? ORDER BY "resumes"."id" ASC LIMIT ?  [["user_id", 6], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? ORDER BY "resumes"."id" ASC LIMIT ?  [["user_id", 6], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? ORDER BY "resumes"."id" ASC LIMIT ?  [["user_id", 6], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? ORDER BY "resumes"."id" ASC LIMIT ?  [["user_id", 6], ["LIMIT", 1]]
   (0.0ms)  begin transaction
   (0.1ms)  commit transaction
  CACHE (0.0ms)  SELECT  "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? ORDER BY "resumes"."id" ASC LIMIT ?  [["user_id", 6], ["LIMIT", 1]]
  Resume Load (0.2ms)  SELECT "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? AND "resumes"."token" IS NULL  [["user_id", 6]]
  Resume Load (0.1ms)  SELECT "resumes".* FROM "resumes" WHERE "resumes"."user_id" = ? AND "resumes"."qrcode_image_uid" IS NULL  [["user_id", 6]]
  Rendering admin/resumes/index.html.erb within layouts/admin
  Resume Load (0.5ms)  SELECT  "resumes".* FROM "resumes" INNER JOIN "orders" ON "orders"."resume_id" = "resumes"."id" ORDER BY resume_id DESC LIMIT ? OFFSET ?  [["LIMIT", 12], ["OFFSET", 0]]
  User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Order Load (0.1ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 79], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Order Load (0.1ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 77], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 6], ["LIMIT", 1]]
  Order Load (0.1ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 76], ["LIMIT", 1]]
  User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Order Load (0.1ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 34], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Order Load (0.3ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 23], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Order Load (0.1ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 15], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Order Load (0.2ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 10], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  CACHE (0.0ms)  SELECT  "orders".* FROM "orders" WHERE "orders"."resume_id" = ? LIMIT ?  [["resume_id", 10], ["LIMIT", 1]]
```
http://stackoverflow.com/questions/3230023/ambiguous-column-name
http://blog.nrowegt.com/rails-pg-ambiguous-column-reference/
http://stackoverflow.com/questions/30512604/rails-nested-includes-and-belongs-to-vs-has-one
http://stackoverflow.com/questions/10336378/eager-loading-in-rails-3
https://github.com/flyerhzm/bullet/issues/147
http://stackoverflow.com/questions/23770065/ruby-on-rails-bullet-n1
http://stackoverflow.com/questions/33255420/n1-query-in-user-model
https://www.foraker.com/blog/active-record-includes-query-logic
http://stackoverflow.com/questions/19175084/activerecord-query-through-multiple-joins
http://apidock.com/rails/ActiveRecord/QueryMethods/includes
http://yerb.net/blog/2014/03/13/three-easy-steps-to-using-counter-caches-in-rails/
http://blog.arkency.com/2013/12/rails4-preloading/
http://blog.bigbinary.com/2013/07/01/preload-vs-eager-load-vs-joins-vs-includes.html
http://railscasts.com/episodes/372-bullet?autoplay=true
https://github.com/flyerhzm/bullet