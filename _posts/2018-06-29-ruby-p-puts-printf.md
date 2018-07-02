---
layout: post
title: 'Ruby: p puts printf'
date: 2018-06-29 12:30:00
comments: true
tags: [ruby]
share: false
---
```
class T
   def initialize(i)
      @i = i
   end
   def to_s
      @i.to_s
   end
end

t = T.new 42

# means t.to_s, always start new line
puts t
=> 42
=> nil

# means t.inspect, always start new line
p t
=> #<T:0x007fe96b0b70f0 @i=42>
=> nil

# means t.to_s, not append a new line
print t
=> 42 => nil
```

[S](https://stackoverflow.com/questions/1255324/p-vs-puts-in-ruby/1255362)
[S](https://www.garethrees.co.uk/2013/05/04/p-vs-puts-vs-print-in-ruby/)
