---
layout: post
title: 'postgresql'
date: 2016-12-23 22:14
comments: true
categories: 
---
rake db:migrate 
```
G::ConnectionBad: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```
config/database.rb
加入
```
development:
  <<: *default
  database: blog_development
  host: localhost
```
报错
```
PG::ConnectionBad: could not connect to server: Connection refused
	Is the server running on host "localhost" (::1) and accepting
	TCP/IP connections on port 5432?
could not connect to server: Connection refused
	Is the server running on host "localhost" (127.0.0.1) and accepting
	TCP/IP connections on port 5432?
```
输入netstat -an | grep 5432 x no work

ps auxw | grep post
brew services stop postgresql
brew services start postgresql
输入rm /usr/local/var/postgres/postmaster.pid
`ActiveRecord::NoDatabaseError: FATAL:  database "blog_development" does not exist`
输入rake db:create 
   rake db:migrate