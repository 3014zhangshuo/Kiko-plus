---
layout: post
title: '知识点：lambda，block and Proc'
date: 2016-11-14 00:39
comments: true
categories: 
---
>实例

```
# Block Examples

[1,2,3].each { |x| puts x*2 }   # block is in between the curly braces

[1,2,3].each do |x|
  puts x*2                    # block is everything between the do and end
end

# Proc Examples             
p = Proc.new { |x| puts x*2 }
[1,2,3].each(&p)              # The '&' tells ruby to turn the proc into a block 

proc = Proc.new { puts "Hello World" }
proc.call                     # The body of the Proc object gets executed when called

# Lambda Examples            
lam = lambda { |x| puts x*2 }
[1,2,3].each(&lam)

lam = lambda { puts "Hello World" }
lam.call
```
>block

Block是可以暫存一段ruby code的地方，用大括號{}表示 舉例說明

```
def block_test
  puts "test start"
  yield
  puts "test done"
end

block_test{ puts "block working here!" }
# => "test start"
# => "block working here!"
# => "test done"
```
>Proc

Proc就是把block存成实例的方式，呼叫前加上&就可以转回block。
```
p = Proc.new { |x| puts x * 2 }   # 等于 p = proc { |x| puts x * 2 }
[1,2,3].each(&p)
# => 2
# => 4
# => 6
p.class
# => Proc
```
>lambda 

lambda 基本上也是 Proc 的实例，只是它的形态叫做lambda。
```
lam = lambda { |x| puts x * 2 }
[1,2,3].each(&lam)
# => 2
# => 4
# => 6
lam.class
# => Proc
```

>block和proc的区别

1.Procs are objects, blocks are not


>lambda和proc的主要区别

1.lambda会check参数数量，proc不会。
```
# lambda
lam = lambda { |x| puts x }
lam.call(2) #=> 2
lam.call(2,3) #=> ArgumentError: wrong number of arguments (2 for 1)

# proc
proc = Proc.new { |x| puts x }
proc.call(2) #=> 2
proc.call(2,3) #=> 2    proc忽略了其他参数，只传第一个。
```
2.return的处理不同，lambda的return只会跳出lambda，proc的return会跳出整个method。
```
def lambda_test
  lam = lambda { return }
  lam.call
  puts "Haha! after lam call, i survived!"
end
def proc_test
  p = Proc.new { return }
  p.call
  puts "after proc call, i survived!"
end

lambda_test # => "Haha! after lam call, i survived!"
proc_test # => #沒東西，因為在執行到puts前就跳出proc_test這個method了
```

资料
[宝书](https://rocodev.gitbooks.io/rails-102/content/chapter3-ruby/lambda.html)
[英文](http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/)