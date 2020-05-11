---
layout: post
title: "Mysql 查看 table index"
date: 2020-05-11
tags: [mysql]
---

```
SHOW INDEX FROM table_name;
```

* Non_unique: 0 if the index cannot contain duplicates, 1 if it can.
* Seq_in_index: The column sequence number in the index, starting with 1.

---

* https://dev.mysql.com/doc/refman/8.0/en/show-index.html


