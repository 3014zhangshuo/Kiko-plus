---
layout: post
title: "Rails: 如何给 dead job 添加回调"
date: 2021-01-19
tags: [rails sidekiq]
---

先大概了解一下 `sidekiq job` 的生命周期：`Processed`, `Failed`, `Busy`, `Enqueued`, `Retries`, `Scheduled`, `Dead`.

所有重试执行完后，`job` 还是失败的话，状态就会转变成 `dead`，如果我们想在状态转变的时候做一些回调处理，需要下面这么作：

```ruby
class SomeWorker
  include Sidekiq::Worker

  sidekiq_options retry: 6

  sidekiq_retry_in do |count|
    [1.minutes, 30.minutes, 1.hours, 3.hours, 6.hours, 1.days][count]
  end

  sidekiq_retries_exhausted do |job_info|
    # do something when job deading
  end

  def perform(*arg)
  end
end
```

---

* [Job-Lifecycle](https://github.com/mperham/sidekiq/wiki/Job-Lifecycle)
* [Error-Handling](https://github.com/mperham/sidekiq/wiki/Error-Handling)
