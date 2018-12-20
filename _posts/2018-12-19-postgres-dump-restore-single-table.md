---
layout: post
title: 'PG: Dump And Restore Table'
date: 2018-12-19 11:39:22
comments: true
tags: [pg]
share: false
---

### Dump a single table
```shell
pg_dump -U postgres --table feedbacks -Fc staging_db > feedbacks.sql
```

`-Fc` means the archive format is custom.

If you have below error message, definitely is forget add `-U` options.

```
pg_dump: [archiver (db)] connection to database "staging_db" failed: FATAL: password authentication failed for user "root"`, if you have above error message, definitely is forget add -U options
```
### Restore a single table
```shell
pg_restore -U postgres --dbname test_production  --table=feedbacks feedbacks.sql
```

### Reference:
* [Official docs](https://www.postgresql.org/docs/9.2/app-pgrestore.html)
* [Dumping and restoring a table in Postgres](http://blog.mathandpencil.com/dump-and-restore-table-in-postgres)
* [Restoring a single table from a Postgres database or backup](https://feeding.cloud.geek.nz/posts/restoring-single-table-from-postgres/)
* [Restoring Individual Tables from Postgresql pg_dump, Using pg_restore Options](https://medium.com/@tbeach/restoring-individual-tables-from-postgresql-pg-dump-using-pg-restore-options-ef3ce2b41ab6)
