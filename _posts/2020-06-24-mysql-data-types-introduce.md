---
layout: post
title: "mysql 中数据类型及其含义"
date: 2020-06-24
tags: [sql]
---

```
tinyint(1) # 从 0 到 255 的整型数据，存储大小为 1 bytes
```

```
int(11) # 从 -2,147,483,648 到 2,147,483,64) 的整型数据，存储大小为 4 bytes
```

```
bigint(20) # 从 -9223372036854775808 到 9223372036854775807 的整型数据，存储大小为 8 bytes
```

`()` 中的数字表示显示的位数，`11` 表示如果值为 `1` 显示的时候是 `00000000001`

```
decimal(11,2) # `11` 是指 整数+小数 的总长度，`2` 是指小数部分的长度，`11 - 2 = 8` 是指整数部分的长度
```

```
varchar(191) # 191 代表能存储的字符数，无论是英文还是中文
```

---

* https://ruby-china.org/topics/24920
* https://blog.csdn.net/ahjxhy2010/article/details/83586762
* https://stackoverflow.com/questions/5634104/what-is-the-size-of-column-of-int11-in-mysql-in-bytes
* https://stackoverflow.com/questions/4151259/whats-the-size-of-an-sql-intn
