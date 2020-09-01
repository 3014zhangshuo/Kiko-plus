---
layout: post
title: "Rails: arel 基本用法"
date: 2020-09-01
tags: [rails, arel, activerecord]
---

#### Equality

##### Greater than

```ruby
Post.where(Post.arel_table[:published_at].gt(Time.current))
Post.where(Post.arel_table[:published_at].gteq(Time.current))
```

##### Less than or Less than or equal

```ruby
Post.where(Post.arel_table[:published_at]).lt(Time.current))
Post.where(Post.arel_table[:published_at]).lteq(Time.current))
```

##### Not equal

```ruby
Post.where(Post.arel_table[:title].not_eq('Master'))
```

#### Matching / (I)LIKE

```ruby
Post.where(Post.arel_table[:title].matches('%Master%'))
```

#### Ordering

```ruby
Post.order(Post.arel_table[:published_at].desc)
```

### OR queries

```ruby
Post.order(Post.arel_table[:title].eq('Master').or(Post.arel_table[:title].eq('Slave')))
```

### AND queries

```ruby
Post.order(Post.arel_table[:title].eq('Master').or(Post.arel_table[:published_at].gteq(Time.current)))
```
---

* [advanced-arel-cheat-sheet](https://www.calebwoods.com/2015/08/11/advanced-arel-cheat-sheet/)
* [the-mimimum-arel-every-rails-developer-should-know](https://jacopretorius.net/2016/09/the-mimimum-arel-every-rails-developer-should-know.html)
* [the-definitive-guide-to-arel-the-sql-manager-for-ruby](https://jpospisil.com/2014/06/16/the-definitive-guide-to-arel-the-sql-manager-for-ruby.html)
* [advanced-arel-when-activerecord-just-isnt-enough](https://www.slideshare.net/camerondutro/advanced-arel-when-activerecord-just-isnt-enough)
