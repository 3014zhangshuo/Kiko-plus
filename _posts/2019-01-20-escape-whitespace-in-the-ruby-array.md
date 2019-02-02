---
layout: post
title: 'Ruby: Escape whitespace in the ruby array by %w'
date: 2019-01-20 11:39:22
comments: true
tags: [ruby]
share: false
---
### Space between words
```ruby
# expect
['a', 'b c']
# by %w
%w[a b c] # => ["a", "b", "c"]
# %w with escape
%w[a b\ c]
```
### Empty space
```ruby
# expect
['a', ' ', 'c']
# by %w
%w[a ] # => ["a"]
# %w with escape
%w[a \  c] # => ["a", " ", "c"]
```

### Reference:
[space-in-the-ruby-array-by-w](https://stackoverflow.com/questions/4064062/space-in-the-ruby-array-by-w)
