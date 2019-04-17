---
layout: post
title: "Postgres: Change User Password"
date: 2019-04-16 21:39:22
comments: true
tags: [pg postgres]
share: false
---
### 查看角色权限
```sql
postgres-# \du

Role name  |                         Attributes                         | Member of
------------+------------------------------------------------------------+-----------
postgres   | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```
### 更改用户密码
```sql
ALTER USER postgres WITH ENCRYPTED PASSWORD 'password';
```
