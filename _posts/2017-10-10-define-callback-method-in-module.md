---
layout: post
title: 'Define callback method in a module'
date: 2017-10-10 23:35
comments: true
tags: [ruby]
comments: true
share: true
---
###### 为了确定简历的更新时间，在相关的所属model里面加入callbakc method来同步更新简历的updated_at。相同的方法不要重复自身，可以使用rails concern的功能来添加。(Rails belong_to中touch: true就可解决)

- only ruby

```
module MyModule
  def self.included(base)
    base.class_eval do
      before_save :do_something
    end
  end

  def do_something
    #do whatever
  end
end
```

- rails concern

```
module MyModule
  extend ActiveSupport::Concern

  included do
    before_save :do_something
  end

  def do_something
    #do whatever
  end
end
```

[原文](https://stackoverflow.com/questions/7444522/is-it-possible-to-define-a-before-save-callback-in-a-module)
