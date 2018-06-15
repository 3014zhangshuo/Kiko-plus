---
layout: post
title: 'ActiveRecord::Relation Methods'
date: 2018-06-15 00:00:00
comments: true
tags: [Rails]
share: false
---
### 1. first_or_create / first_or_initialize
`Book.where(:title => 'Tale of Two Cities').first_or_create`

supply a block
```
Book.where(:title => 'Tale of Two Cities').first_or_create do |book|
  book.author = 'Charles Dickens'
  book.published_year = 1859
end
```

### 2. none
`Book.none` => []

### 3. to_sql and explain
```
Library.joins(:book).to_sql
# => SQL query for you database.
Libray.joins(:book).explain
# => Database explain for the query.
```

### 4. scoping
You can “scope” methods on a class to a particular relation. Consider the following example from the Rails documentation:

```
Comment.where(:post_id => 1).scoping do
  Comment.first # SELECT * FROM comments WHERE post_id = 1
end
```
[S](http://www.mitchcrowe.com/10-most-underused-activerecord-relation-methods/)
