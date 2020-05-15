---
layout: post
title: "Ruby ** 操作符展开 hash，hash key 必须是 symbol"
date: 2020-05-14
tags: [ruby]
---

```
def foo(a, *b, **c)
  [a, b, c]
end

foo(1, [1], { 'a' => 1 }) # => [1, [[1], {"a"=>1}], {}]
foo(1, [1], { a:  1 })    # => [1, [[1]], {:a=>1}]

{ **{ a: 1 } }            # => {:a=>1}
{ **{ 'a' => 1 } }        # => TypeError (hash key "a" is not a Symbol)
```

为什么会出现这种情况？

看 Matz 的回答：

```
Double splat war introduced to pass a hash given from keyword arguments.
Keyword arguments hash is fundamentally a hash with symbol keys.
```

但这里就会让人很疑惑。Ruby 2.7 以上的版本修复了这个问题，`symbol key` 和 `string key` 的行为是一样的了。

```
def foo(a, *b, **c)
  [a, b, c]
end

foo(1, [1], **{ 'a' => 1 }) # => [1, [[1]], {:a=>1}]
foo(1, [1], **{ a:  1 })    # => [1, [[1]], {:a=>1}]

{ **{ a: 1 } }            # => {:a=>1}
{ **{ 'a' => 1 } }        # => {:a=>1}
```

但这里要注意最后的 `keyword arguments` 要使用 `**` 展开，如果没有展开的话行为是跟未修复的时候一样，ruby 会给你一个警告 `Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call`

`Symbol` 本质上是 `immutable string`，为了性能的原因引入 `Symbol` 却带来了疑惑，据说 Ruby3 默认 `String` 也是 `immutable` 的了，那是不是可以移除 `Symbol` 来解决这些疑惑，有多少 bug 是由于是 `hash[:name]` 还是 `hash['name']` 引起的，这有些违背了 Ruby 友好的特性。

近期越来越发现 ruby 很多的特性其实都是来弥补一些语言上问题。比如参数类型隐形的转换，那其实在有类型检查的语言上根本不用思考这些问题，相比来说用 ruby 要写出健壮的程序要思考的更多，这也是 ruby 强表达力带来的代价。

---

* https://bugs.ruby-lang.org/issues/10119
* https://bugs.ruby-lang.org/issues/7792
