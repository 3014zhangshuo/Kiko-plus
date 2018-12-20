---
layout: post
title: 'PG: Psql Assign DB'
date: 2018-12-18 12:39:22
comments: true
tags: [pg]
share: false
---

### Problem:
Iterm run psql command then throw the `psql: FATAL: database “<user>” does not exist`, Specifying the db for psql command can work `psql dbname`, but i want enter the console that have all db.
### Reason:
The `psql` command will enter default db that is username, want enter all db console you can add `-d postgres` option.

### Reference:
[psql: FATAL: database “<user>” does not exist](https://stackoverflow.com/questions/17633422/psql-fatal-database-user-does-not-exist)
