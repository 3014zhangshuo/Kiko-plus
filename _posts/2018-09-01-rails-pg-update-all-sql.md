---
layout: post
title: 'ActiveRecord: execute sql'
date: 2018-09-01 00:24:00
comments: true
tags: [activerecord]
share: false
---

```SQL
UPDATE wechat_official_accounts
SET unionid = users.unionid
FROM users WHERE wechat_official_accounts.user_id = users.id;
```

```SQL
UPDATE wechat_official_accounts
SET unionid = users.unionid
FROM wechat_official_accounts as accounts
INNER JOIN users
ON accounts.user_id = users.id;
```

```ruby
ActiveRecord::Base.connection.execute(sql)
```

#### Reference
* [](https://stackoverflow.com/questions/6005635/error-error-table-name-specified-more-than-once)
* [](https://stackoverflow.com/questions/32113746/table-name-is-specified-more-than-once)
* [](https://semaphoreci.com/blog/2017/06/21/faster-rails-indexing-large-database-tables.html)

```SQL
SELECT users.* FROM users
INNER JOIN cvs ON cvs.user_id = users.id
LEFT OUTER JOIN edus ON edus.cv_id = cvs.id
```
