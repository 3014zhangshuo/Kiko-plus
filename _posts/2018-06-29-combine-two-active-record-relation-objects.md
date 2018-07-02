---
layout: post
title: 'Rails: Combine Two ActiveRecord::Relation Objects'
date: 2018-06-29 14:30:00
comments: true
tags: [rails]
share: false
---
```
first_relation = User.where(:first_name => 'shuo') # ActiveRecord::Relation
last_relation  = User.where(:last_name  => 'zhang') # ActiveRecord::Relation
```

- combine using `AND` (intersection), use `merge`

```
first_relation.merge(last_relation)
```
- combine using `OR` (union), use `or`

```
first_relation.or(last_relation)
```

[S](https://stackoverflow.com/questions/9540801/combine-two-activerecordrelation-objects)
