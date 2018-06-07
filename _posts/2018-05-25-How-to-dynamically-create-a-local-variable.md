---
layout: post
title: 'How to dynamically create a local variable?'
date: 2018-04-25 11:05:37
comments: true
tags: [Ruby]
comments: true
share: true
---
> Ruby it is true that you can't create local variables in current content,
> but you can set variables in some particular binding you have a handle of.

Example:
```
handle = binding
handle.local_variable_set 'hello', "hi, it's work"
handle.eval 'hello'
```

```
module M
  #  calls to binding give you a new binding each time
  def self.clean_binding
    binding
  end

  def self.binding_from_hash(**vars)
    b = self.clean_binding
    vars.each do |k, v|
      b.local_variable_set k.to_sym, v
    end
    return b
  end
end
my_nice_binding = M.binding_from_hash(a: 5, **other_opts)
```
[转自于](https://code.i-harness.com/en/q/11b183b)
