---
layout: post
title: 'Rails: Pass Arguments To Rake Task'
date: 2018-06-27 17:30:00
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

add environment

```
namespace :thing do
  desc "it does a thing"
  task :work, [:arg1, :arg2, :arg3] => :environment do |task, args|
    ...
  end
end
```

```
namespace :thing do
  desc "it does a thing"
  task :work, [:option, :foo, :bar] do |task, args|
    puts "work", args
  end

  task :another, [:option, :foo, :bar] do |task, args|
    puts "another #{args}"
    Rake::Task["thing:work"].invoke(args[:option], args[:foo], args[:bar])
    # or splat the args
    # Rake::Task["thing:work"].invoke(*args)
  end

end
```

```
rake thing:work[1,2,3]
=> work: {:option=>"1", :foo=>"2", :bar=>"3"}

rake thing:another[1,2,3]
=> another {:option=>"1", :foo=>"2", :bar=>"3"}
=> work: {:option=>"1", :foo=>"2", :bar=>"3"}
```

[S1](https://stackoverflow.com/questions/10523661/pass-hash-as-parameter-to-rake-task)
[S2](https://stackoverflow.com/questions/12055877/how-can-i-pass-an-array-as-an-argument-to-a-rake-task)
[S3](https://stackoverflow.com/questions/825748/how-to-pass-command-line-arguments-to-a-rake-task)
