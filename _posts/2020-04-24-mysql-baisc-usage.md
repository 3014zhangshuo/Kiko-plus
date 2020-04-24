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
```
