---
layout: post
title: "Ruby: && 和 and 的优先级"
date: 2020-07-01
tags: [ruby]
---

```ruby
def a
  puts 'do method a'
  true
end

def b
  puts 'do method b'
  false
end

def c
  puts 'do method c'
  true
end

def d
  a && b if c
end

# do method c
# do method a
# do method b

def d
  a and b if c
end

# do method c
# do method a
# do method b

def e(*opts)
  puts "-------#{opts.first}"
end

def d
  e a && b if c
end

# do method c
# do method a
# do method b
# -------false

def d
  e a and b if c
end

# do method c
# do method a
# -------true

def d
  e a && return if c
end

# do method c
# do method a

def d
  e a and return if c
end

# do method c
# do method a
# -------true
```
