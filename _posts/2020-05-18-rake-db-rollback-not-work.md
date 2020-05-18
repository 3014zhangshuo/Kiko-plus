---
layout: post
title: "Execute rake db:rollback but nothing happened"
date: 2020-05-18
tags: [rails]
---

今天放生了很诡异的事情，执行多次 `rake db:rollback` 但是什么都没有发生。

使用 `rake db:migrate:status` 查看数据迁移状态，这里有一个 `NO FILE` 的记录，`rails` 找不到版本 `20200514011638` 的迁移文件，所以它什么都不会做，导致这种情况的原因是分支切换。

```
up     20200514011638  ********** NO FILE **********
```

只好在数据库中手动删除掉 `NO FILE` 的记录：

```
DELETE FROM schema_migrations WHERE version = 20200514011638;
```

可是使用 `SELECT * FROM schema_migrations;` 查看所有迁移版本号。

---

* https://makandracards.com/makandra/40171-how-to-fix-rake-db-rollback-does-not-work
