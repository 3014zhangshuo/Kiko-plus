---
layout: post
title: 'Rails: Pass Arguments To Rake Task'
date: 2018-06-27 21:30:00
comments: true
tags: [rails]
share: false
---

### Pass Multiple Arguments

```
namespace :thing do
  desc "it does a thing"
  task :work, [:arg1, :arg2, :arg3] do |task, args|
    p args[:arg1]
    p args[:arg2]
    p args[:arg3]
  end
end
```
