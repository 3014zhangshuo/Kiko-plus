---
layout: post
title: "在Ruby使用return来返回值是好的代码风格吗？"
date: 2019-06-28
tags: [ruby, code-style]
---

Ruby有一个特性，如果没有声明return的话，方法执行的最后一行的返回值为整个方法的返回值。像下面的例子，方法及赋值了一个实例变量y又返回的实例变量y的值。

```ruby
def plus_one_to_y(x)
  @y = x + 1
end
```

如果这个方法的确期望返回y的值，那么不熟悉ruby这个特性的就会造成下面的错误。

```ruby
def plus_one_to_y(x)
  @y = x + 1
  puts "In plus_one_to_y"
end
```

方法永远都返回nil，你需要这么修改。

```ruby
def plus_one_to_y(x)
  @y = x + 1
  puts "In plus_one_to_y"
  @y
end
```

明确声明方法的返回值不会对程序的运行有任何的影响，它可以减少不必要的思考，让程序员明确的知道方法的返回值是什么。如果方法真的需要关心它的返回值的时候，那么加上return是一种更为清晰的写法。

```ruby
def plus_one_to_y(x)
  @y = x + 1
  puts "In plus_one_to_y"
  return @y
end
```

### 参考

[Is it good style to explicitly return in Ruby?
](https://stackoverflow.com/questions/1023146/is-it-good-style-to- -return-in-ruby)
