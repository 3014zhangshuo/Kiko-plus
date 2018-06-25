---
layout: post
title: 'Ruby Sorting'
date: 2018-06-25 00:00:00
comments: true
tags: [Ruby]
share: false
---

## Basic Sorting
```
numbers = [5,3,2,1]
numbers.sort # => [1,2,3,5]
```
Notice that `sort` method return new array, if you want modifies the current array use `sort!`.

## Customized Sorting
```
strings = %w[foo test blog a]
strings.sort_by(&:length) # => ["a", "foo", "test", "blog"]
```
It is also possible to do this using the regular sort method with a block.
```
strings = %w[foo test blog a]
strings.sort { |a, b| a.length <=> b.length }
```

## Reverse Sort
```
strings = %w(foo test blog a)
strings.sort_by { |str| -str.length } # => ["blog", "test", "foo", "a"]
```

## Alphanumeric Sorting
```
music = %w(21.mp3 10.mp3 5.mp3 40.mp3)
music.sort_by { |s| s.scan(/\d+/).first.to_i } # => ["5.mp3", "10.mp3", "21.mp3", "40.mp3"]
```

## Sorting Hashes
```
hash = {coconut: 200, orange: 50, bacon: 100}

hash.sort_by(&:last) # => [[:orange, 50], [:bacon, 100], [:coconut, 200]]
```
Notice that return array, keep the hash yout can do this `hash.sort_by(&:last).to_h`

## Own Sorting Method
```
def quick_sort(list)
  qsort_helper(list).flatten
end

def qsort_helper(list)
  return [] if list.empty?

  number        = list.sample
  lower, higher = list.partition { |n| n < number }

  higher.delete_at(higher.index(number))

  [qsort_helper(lower), number, qsort_helper(higher)]
end

p quick_sort [3, 7, 2, 1, 8, 12]

# [1, 2, 3, 7, 8, 12]
```
[S](http://www.rubyguides.com/2017/07/ruby-sort/)
