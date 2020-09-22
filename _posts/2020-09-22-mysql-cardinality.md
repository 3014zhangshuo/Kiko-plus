---
layout: post
title: "Mysql Index Cardinality"
date: 2020-09-22
tags: [mysql]
---

`mysql cardinality` 是用来进行索引选择的，数值太小，那么优化器会认为，这个索引对语句没有太大帮助，而不使用索引。

`Cardinality` 值非常关键，表示索引中不重复记录数量的预估值，在实际应用中，`Cardinality/n_rows_in_table` 应尽可能地接近 1。如果非常小，那么就需要考虑是否还有必要创建这个索引。既然这个数值十分重要，那么数据库是统计这个信息的呢？

首先要考虑的是在生产环境中，索引的更新操作可能是非常频繁的。如果每次索引在发生操作时就对其进行 `Cardinality` 的统计，那么将会给数据库带来很大的负担。另外需要考虑的是，如果一张表的数据非常大,如一张表有 `50G` 的数据，那么统计次 `Cardinality` 信息所需要的时间可能非常长。这在生产环境下，也是不能接受的。因此，数据库对于 `Cardinality` 的统计都是通过采样(Sample)的方法来完成的。

在 `InnoDB` 存储引擎中, `Cardinality` 统计信息的更新发生在两个操作中: `INSERT` 和 `UPDATE`。根据前面的叙述,不可能在每次发生 `INSERT` 和 `UPDATE` 时就去更新 `Cardinality`信息,这样会增加数据库系统的负荷,同时对于大表的统计,时间上也不允许数据库这样去操作。因此, `InnoDB` 存储引擎内部对更新 `Cardinality` 信息的策略为:
  * 表中 `1/16` 的数据已发生变化
  * `stat_modified_counter > 2000000000`

第一种策略为自从上次统计 `Cardinality` 信息后，表中 `1/16` 的数据已经发生过变化，这时需要更新 `Cardinality` 信息。第二种情况考虑的是，如果对表中某一行数据频繁地进行更新操作，这时表中的数据实际并没有增加，实际发生变化的还是这一行数据，则第一种更新策略就无法适用这这种情况。故在 `InnoDB` 存储引擎内部有一个计数器 `stat_modified_counter`，用来表示发生变化的次数，当 `stat_modified_counter` 大于 `2000000000` 时，则同样需要更新 `Cardinality` 信息。

在 `InnoDB` 存储引擎中, `Cardinality` 默认是通过对 `8` 个叶子节点预估而得的，可以通过参数 `innodb_stats_sample_pages` 用来设置统计 `Cardinality` 时每次采样页的数量，当执行 `SQL` 语句 `ANALYZE TABLE`、 `SHOW TABLE STATUS`、 `SHOW INDEX` 以及访问 `INFORMATION SCHEMA`架构下的表 `TABLES` 和 `STATISTICS` 时会导致 `InnoDB` 存储引擎去重新计算索引的 `Cardinality` 值。

---

* [【MySQL技术内幕】5.5-Cardinality值](https://juejin.im/post/6844904133800296455)
* [关于索引cardinality的知识](https://blog.csdn.net/shi_yi_fei/article/details/51659364)
* [updating-innodb-table-statistics-manually](https://www.percona.com/blog/2017/09/11/updating-innodb-table-statistics-manually/)
