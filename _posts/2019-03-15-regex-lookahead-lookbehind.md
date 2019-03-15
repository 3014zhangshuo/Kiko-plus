---
layout: post
title: "Regex: Lookahead Assertion And Lookbehind Assertion"
date: 2019-03-11 21:39:22
comments: true
tags: [rails]
share: false
---

### [Positive Lookahead Assertion](https://regexr.com/4a97d) => `(?=pattern)`

Match re in regular word
```ruby
"a regular expression"
/re(?=gular)/
```

### [Negative Lookahead Assertion](https://regexr.com/4a97s) => `(?!pattern)`

Match re not in regular word
```ruby
"a regular expression"
/re(?!gular)/
```

### [Positive Lookbehind Assertion](https://regexr.com/4a985) => `(?<=pattern)`

Match re inside word but not beginning of the word.
```ruby
"regex represents regular expression"
/(?<=\w)re/
```

### [Negative Lookbehind Assertion](https:/regexr.com/4a98k) => `(?<!pattern)`

Match re the beginning of the word but not inside word.
```ruby
"regex represents regular expression"
/(?<!\w)re/
```

### Reference:
[Ruby Regex Doc](https://ruby-doc.org/core-2.4.0/Regexp.html#class-Regexp-label-Anchors)

[正则表达式的先行断言(lookahead)和后行断言(lookbehind)](https://blog.51cto.com/cnn237111/749047)
