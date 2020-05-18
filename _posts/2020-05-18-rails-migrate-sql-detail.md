---
layout: post
title: "查看 migrate 具体执行的 SQL"
date: 2020-05-18
tags: [rails sql]
---

```
require './db/migrate/20160102210050_create_items'

ActiveRecord::Base.connection.transaction do
  CreateItems.new.migrate :up
  raise ActiveRecord::Rollback
end
```

或者是 `rails c --sandbox`

```
CreateItems.new.migrate :up
```

---

* https://stackoverflow.com/questions/15852872/show-sql-generated-by-pending-migrations-in-rails-without-updating-the-database
