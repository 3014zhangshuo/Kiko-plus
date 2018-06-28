---
layout: post
title: 'Recreating Ruby method - flatten'
date: 2018-06-23 00:00:00
comments: true
tags: [Ruby]
share: false
---

### Ruby Flatten

`array = [1, [2, 3, [4,5]]]` call flatten without argument will return one-dimensional array `array.flatten #=> [1, 2, 3, 4, 5]`, with int argument `array.flatten(1) #=> [1, 2, 3, [4, 5]]`

### Customized Flatten

#### The structure of the method
```
def my_flatten(n = nil)
  n ? multiple_flatten(self, n) : recursion_flatten(self)
end
```
#### Flattening with argument
```
def single_flatten(array)
  results = []
  array.each do |element|
    if element.is_a? Array
      element.each {|value| results << value}
    else
      results << element
    end
  end
  results
end

def multiple_flatten(array, n)
  count = 0
  arr = array
  while count < n do
    arr = single_flatten(arr)
    count += 1
  end
  arr
end
```
#### Flattening an Array by One Dimension
```
def recursion_flatten(array, results=[])
  array.each do |element|
    if element.is_a? Array
      recursion_flatten(element, results)
    else
      results << element
    end
  end
  results
end
```

### Other Thoroughly Flatten Way

```
arr = [1,2,[3,[4,[5]]]]
class Array
  def thoroughly_flatten
    flat = []
    until empty?
      thing = self.pop
      if thing.is_a? Array
        thing.each { |i| self << i }
      else
        flat << thing
      end
    end
    flat.reverse
  end
end

arr.thoroughly_flatten
```

[S1](https://medium.com/@anneeb/recreating-the-flatten-method-for-arrays-in-ruby-fae8040bdbde)
[S2](https://www.rubyguides.com/2017/03/computer-science-in-ruby-stacks/)
