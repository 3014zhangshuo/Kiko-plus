---
layout: post
title: "MySQL 基本用法"
date: 2020-04-24
tags: [db]
---

### 进入操作台

```
mysql -u root -p
```

`-u`表示指定用户，`-p`表示使用密码登录，一般默认的密码是`root`。

### 创建数据库

```
CREATE DATABASE my_db;
```

### 选择数据库进入

```
USE my_db;
```

或者可以进入操作台时候选择数据库

```
mysql -u root -p my_db
```

### 显示数据库表

```
SHOW TABLES;
```

### 创建表

```
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);
```

#### 展示表的详细信息

```
DESCRIBE pet;
```

#### 添加数据

```
INSERT INTO pet VALUES ('Puffball', 'Diane', 'hamster', 'f', '1990-03-30', NULL);
```

也可以通过导入文件的方式批量添加数据

```
LOAD DATA LOCAL INFILE '~/pet.text' INTO TABLE pet;
```

#### 删除数据

```
DELETE FROM pet WHERE name = 'Puffball';
```

### 获取表中信息

#### 获取全部数据

```
SELECT * FROM pet;
```

#### 清空表中数据

```
DELETE FROM pet;
```

#### 更新一条数据

```
UPDATE pet SET birth = '2020-04-24' WHERE name = 'Puffball';
```

#### 特定条件筛选

```
SELECT * FROM pet WHERE birth >= '1993-03-24';

SELECT * FROM pet WHERE species = 'dog' AND sex = 'f';

SELECT * FROM pet WHERE species = 'snake' OR species = 'bird';

SELECT * FROM pet WHERE (species = 'cat' AND sex = 'm') OR (species = 'dog' AND sex = 'f');
```

#### 筛选特定列

```
SELECT name, birth FROM pet;

SELECT owner FROM pet;

SELECT DISTINCT owner FROM pet;

SELECT name, species, birth FROM pet WHERE species = 'dog' OR species = 'cat';
```

#### 排序

```
SELECT name, birth FROM pet ORDER BY birth;

SELECT name, birth FROM pet ORDER BY birth DESC;

SELECT name, species, birth FROM pet ORDER BY species, birth DESC;
```

#### 一些运算

```
SELECT name, birth, CURDATE(), TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS age FROM pet;


SELECT name, birth, CURDATE(), TIMESTAMPDIFF(YEAR, birth, CURDATE()) AS age FROM pet ORDER BY age;


SELECT name, birth, death, TIMESTAMPDIFF(YEAR, birth, death) AS age FROM pet WHERE death IS NOT NULL ORDER BY age;
```

#### 一些时间的格式化

```
# YEAR(), MONTH(), DAYOFMONTH()

SELECT name, birth, MONTH(birth) FROM pet;

SELECT name, birth FROM pet WHERE MONTH(birth) = 5;

SELECT name, birth FROM pet WHERE MONTH(birth) = MONTH(DATE_ADD(CURDATE(), INTERVAL 1 MONTH));

# MOD(N, M) returns the remainder of N divided by M;
SELECT name, birth FROM pet WHERE MONTH(birth) = MOD(MONTH(CURDATE()), 12) + 1;
SELECT MOD(1, 12); # => 1

SELECT '2019-04-04' + INTERVAL 1 MONTH;
SELECT '2019-04-31' + INTERVAL 1 DAY;
SHOW WARNINGS:
```

### NULL

```
SELECT 1 IS NULL, 1 IS NOT NULL; # returns 0 1

SELECT 1 = NULL, 1 <> NULL, 1 < NULL, 1 > NULL; # returns all NULL

SELECT 0 IS NULL, 0 IS NOT NULL, '' IS NULL, '' IS NOT NULL; # returns 0 1 0 1
```

### 匹配

```
# beginning with b
SELECT * FROM pet WHERE name LIKE 'b%';

# ending with fy
SELECT * FROM pet WHERE name LIKE '%fy';

# containing a w
SELECT * FROM pet WHERE name LIKE '%w%';

# find names containing exactly five characters
SELECT * FROM pet WHERE name LIKE '_____';

# beginning with b
SELECT * FROM pet WHERE name REGEXP '^b';

# to force case-sensitive
SELECT * FROM pet WHERE name REGEXP BINARY '^b';

# ending with fy
SELECT * FROM pet WHERE name REGEXP 'fy$';

# containing a w
SELECT * FROM pet WHERE name REGEXP 'w';

# find name containing exactly five characters
SELECT * FROM pet WHERE name REGEXP '^.....$';
SELECT * FROM pet WHERE name REGEXP '^.{5}$'
```

### 统计和分组

```
SELECT COUNT(*) FROM pet;

SELECT owner, COUNT(*) FROM pet GROUP BY owner;

SELECT species, COUNT(*) FROM pet GROUP BY species;

SELECT sex, COUNT(*) FROM pet GROUP BY sex;

SELECT species, sex, COUNT(*) FROM pet GROUP BY species, sex;

SELECT species, sex, COUNT(*) FROM pet WHERE species = 'dog' OR species = 'cat' GROUP BY species, sex;

SELECT species, sex, COUNT(*) FROM pet WHERE sex IS NOT NULL GROUP BY species, sex;
```

#### ONLY_FULL_GROUP_BY

```
SET sql_mode = 'ONLY_FULL_GROUP_BY';

SELECT owner, COUNT(*) FROM pet; # => ERROR

SET sql_mode = '';

SELECT owner, COUNT(*) FROM pet;
```

### Join

```
CREATE TABLE event (name VARCHAR(20), date DATE, type VARCHAR(15), remark VARCHAR(255));

LOAD DATA LOCAL INFILE '~/event.txt' INTO TABLE event;

SELECT pet.name, TIMESTAMPDIFF(YEAR, brith, date) AS age, remark FROM pet INNER JOIN event ON pet.name = event.name WHERE event.type = 'litter';

SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species FROM pet AS p1 INNER JOIN pet AS p2 ON p1.species = p2.species AND p1.sex = 'f' AND p1.death IS NULL AND p2.sex = 'm' AND p2.death IS NULL;
```

---

* https://dev.mysql.com/doc/refman/5.7/en/tutorial.html
