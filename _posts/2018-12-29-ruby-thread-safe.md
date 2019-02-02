---
layout: post
title: 'Ruby: thread safe'
date: 2018-12-29 11:39:22
comments: true
tags: [ruby]
share: false
---

```ruby
require 'net/http'
pages = %w[www.baidu.com www.google.com]
threads = []

pages.each do |page|
  threads << Thread.new(page) do |url|
    http = Net::HTTP.new(url, 80)
    puts "Fetching: #{url}"
    response = http.get('/', nil)
    puts "Got #{url}: #{response.message}"
  end
end

threads.each { |t| t.join }
```

```ruby
class Chaser
  attr_reader :count

  def initialize(name)
    @name = name
    @count = 0
  end

  def chase(other)
    while @count < 5
      while @count - other.count > 1
        Thread.pass
      end
      @count += 1
      print "#{@name}: #{@count}\n"
    end
  end
end

c1 = Chaser.new("A")
c2 = Chaser.new("B")

threads = [
  Thread.new { Thread.stop; c1.chase(c2) },
  Thread.new { Thread.stop; c2.chase(c1) }
]

start_index = rand(2)
threads[start_index].run
threads[1-start_index].run
threads.each { |t| t.join }
```

### Reference:
[线程和进程](http://blog.51cto.com/hanviseas/1199519)
[How Do I Know Whether My Rails App Is Thread-safe or Not?](https://bearmetal.eu/theden/how-do-i-know-whether-my-rails-app-is-thread-safe-or-not/)
