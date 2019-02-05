---
layout: post
title: 'Ruby: the difference between clone and dup'
date: 2019-01-17 11:39:22
comments: true
tags: [ruby]
share: false
---

### `#clone` does two things that `#dup` doesn't:
* copy the singleton class of the copied object
* maintain the frozen status of the copied object

#### Singleton Class
```ruby
a = Object.new
def a.foo
  :foo
end

b = a.dup
p b.foo rescue 'NoMethodError'

c = a.clone
p c.foo
```

#### Frozen Status
```ruby
a = Object.new
a.freeze
p a.frozen? # => true
b = a.dup
p b.frozen? # => false
c = a.clone
p c.frozen? # => true
```

### Array attribute shared between original and copied instances, `#clone` and `#dup` are the same.
```ruby
class Foo
  attr_accessor :bar
  def initialize
    self.bar = [1,2,3]
  end
end

a = Foo.new
b = a.clone
c = a.dup
p a.bar # => [1,2,3]
p a.bar.clear # => []
p b.bar # => []
p c.bar # => []
```

### Deep Copy `Marshal`
```ruby
a = [1,2,3]
b = Marshal.load(Marshal.dump(a))
b << 4
p a # => [1,2,3]
p b # => [1,2,3,4]
```

```

class Document  
    attr_accessor :title, :text  
    attr_reader :timestamp  

    def initialize(title, text)  
        @title, @text = title, text  
        @timestamp = Time.now  
    end  
end
```

### above ruby 2.3.1, dup, clone are not share the same memory reference，they are new object
```
a = [1,2,3]
b = a.dup
c = a.clone

b << 4
c.clear

p a # => [1,2,3]
```

### initialize_copy

```ruby
class Document  
  attr_accessor :title, :text  
  attr_reader :timestamp  

  def initialize(title, text)  
    @title, @text = title, text  
    @timestamp = Time.now  
  end  
end

doc = Document.new("Ruby", "Array")
sleep 2
doc_copy = doc.clone

doc.timestamp == doc_copy.timestamp # => ture
```

```ruby
class Document  
  attr_accessor :title, :text  
  attr_reader :timestamp  

  def initialize(title, text)  
    @title, @text = title, text  
    @timestamp = Time.now  
  end

  def initialize_copy(new_object)
    p other
    @timestamp = Time.now
  end
end

doc = Document.new("Ruby", "Array")
sleep 2
doc_copy = doc.clone

doc.timestamp == doc_copy.timestamp # => false
```

### Reference:

[Ruby: the differences between dup & clone](https://coderwall.com/p/1zflyg/ruby-the-differences-between-dup-clone)
[ruby复制对象的方法(dup 和 clone)](https://blog.csdn.net/CloudCraft/article/details/10348799)
