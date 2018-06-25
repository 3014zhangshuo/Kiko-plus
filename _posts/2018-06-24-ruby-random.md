---
layout: post
title: 'Ruby Random'
date: 2018-06-24 00:00:00
comments: true
tags: [Ruby]
share: false
---

## Standard Rand
`rand #=> 0.13002209003779552`

## Rand with limit
`rand 100 #=> 41`
`rand 100..200 #=> 141`

## SecureRandom
```
require 'securerandom'

SecureRandom.random_number #=> 0.232
SecureRandom.random_number 100 #=> 72
SecureRandom.hex #=> "be746d858318812801cfc043cf374ed9"
```

## Sampling
- `[5, 15, 30, 60].shuffle.first #=> 15`
- `[5, 15, 30, 60].sample #=> 15`
- `('a'..'z').to_a.sample #=> "h"`

## Random String
```
def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

puts generate_code(20)
```

[S](https://www.rubyguides.com/2015/03/ruby-random/)
