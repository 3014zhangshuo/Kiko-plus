---
layout: post
title: "Ruby: Example for process and thread"
date: 2019-01-27 11:39:22
comments: true
tags: [ruby]
share: false
---
### 串行
```ruby
require 'benchmark'

def fib(n)
  n < 2 ? n : fib(n - 1) + fib(n - 2)
end

def heavy_task
  fib(30)
end

puts Benchmark.measure { 100.times { heavy_task } }

# 9.990000   0.010000  10.000000 ( 10.015460)
```

### 进程并行
```ruby
require 'benchmark'

def fib(n)
  n < 2 ? n : fib(n - 1) + fib(n - 2)
end

def heavy_task
  fib(30)
end

puts Benchmark.measure {
  100.times { fork { heavy_task } }
  Process.waitall
}

# 0.010000   0.040000  18.790000 (  2.426301)
```

### 线程并行
```ruby
require 'benchmark'

def fib(n)
  n < 2 ? n : fib(n - 1) + fib(n - 2)
end

def heavy_task
  fib(30)
end

threads = []

puts Benchmark.measure {
  100.times {
    threads << Thread.new { heavy_task }
  }
  threads.map(&:join)
}

# 9.650000   0.030000   9.680000 (  9.718837)
```

### 绿色线程并行
```ruby
require 'benchmark'
require 'lightio'

LightIO::Monkey.patch_all!

def fib(n)
  n < 2 ? n : fib(n - 1) + fib(n - 2)
end

def heavy_task
  fib(30)
end

threads = []

puts Benchmark.measure {
  100.times {
    threads << Thread.new { heavy_task }
  }
  threads.map(&:join)
}

# 9.680000   0.030000   9.710000 (  9.744313)
```

### 总结
上面例子中线程代码并没有对执行速度有太大的优化，因为存在`Global Interpreter Lock（GIL）`，ruby保证了在多线程的情况下，只有一个线程可以执行Ruby代码，例子为CPU密集型任务，如果是IO密集型任务则`GIL`对线程的影响就没那么大，多线程的处理方式依旧能提供不小的提升。

多进程的处理方式更快，每次`fork`都会把父进程的堆栈空间**完整地**复制一次到子进程内存中，非常吃机器性能。

### Reference:
[Ruby并发与线程](https://afghl.github.io/2016/09/22/ruby-concurrency-and-thread-pool.html)
