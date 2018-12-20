---
layout: post
title: 'PG: Drop DB Failed'
date: 2018-12-18 11:39:22
comments: true
tags: [pg]
share: false
---

### Error
```
ERROR:  database "staging_db" is being accessed by other users
DETAIL:  There is 1 other session using the database.
```
### Solution

#### Prevent future connections
```SQL
REVOKE CONNECT ON DATABASE thedb FROM public;
```
#### Terminate all connections
```SQL
SELECT pid, pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = current_database() AND pid <> pg_backend_pid();
```

```SQL
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'dbname';
```

### Reference:
[Postgresql-unable-to-drop-database-because-of-some-auto-connections-to-db](https://stackoverflow.com/questions/17449420/postgresql-unable-to-drop-database-because-of-some-auto-connections-to-db)
