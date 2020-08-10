---
layout: post
title: "项目拆解之 sidekiq"
date: 2020-08-08
tags: [ruby, sidekiq, rails]
---

#### 前提：

* 两个 rails project: `proj_A`，`proj_B`
* `proj_A` redis connection pool: `proj_A_redis`
* `proj_A` 上有一个 sidekiq worker: `SendMessageWorker`

`SendMessageWorker` 生成一条消息发送给用户，消息内容生成强依赖在 `proj_A` 上的 `models` 中的方法

#### 想要做

把 `proj_A` 上的 sidekiq worker 解耦到 `proj_B`

#### 如何错误地做

把相关的 `models` 方法复制 `proj_B` 上，在 `proj_B` 上创建一个 `SendMessageWorker`，删除 `proj_A` 上的 `SendMessageWorker`，完毕！（这样做相当于没有解耦，反倒增加了引入 BUG 的可能：相同的知识应该只有一处权威的表达）

#### 如何正确地做

* 为 `proj_B` 创建新的 redis pool `proj_B_redis`
* 将发送的消息内容作为参数传入到 `SendMessageWorker`，将 `SendMessageWorker` 的 redis pool 改为 `proj_B_redis`
* `proj_B` 创建 `SendMessageWorker`，去掉 `models` 方法相关的部分，改为从参数中获取
* 保留 `proj_A` 中 `SendMessageWorker`，`perform` 方法留空
* 设置 `proj_A` 的 sidekiq 仅消费 `proj_A_redis` 里面的任务，`proj_B` 的 sidekiq 仅消费 `proj_A_redis` 里面的任务

```ruby
# proj_A

class SendMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, pool: `proj_B_redis`

  def perform(options = {})
  end
end
```

```ruby
# proj_B

class SendMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, pool: `proj_B_redis`

  def perform(options = {})
    # TODO: send message to user
  end
end
```

让 `proj_A` 仅做为任务的生产者，让 `proj_B` 的 sidekiq 去消费任务

其实也可以不保留 `proj_A` 中的 `SendMessageWorker`，直接塞任务到 `proj_B_redis`

```ruby
require 'redis'
require 'json'

class RedisJobPusher
  def self.send_message_worker(user_id, title, message)
    params = [user_id, title, message]
    RedisJobPusher.push_to_queue('SendMessageWorker', params)
  end

  def self.push_to_queue(worker_name, params)
    # using <<  rather than + because it cats instead of newing up string objects
    redisurl = 'redis://' << CONFIG[:redis_server] << ':6379' << '/' << CONFIG[:redis_db_num]

    msg = { 'class' => worker_name, 'args' => params, 'retry' => true }
    redis = Redis.new(:url => redisurl)
    redis.lpush("raisemore_sidekiq:queue:JobWorker", JSON.dump(msg))
  end
end
```

---

* https://draveness.me/sidekiq/
* https://ruby-china.org/topics/31470
* https://ruby-china.org/topics/31642
* https://www.fuwuqizhijia.com/redis/201704/53783.html
* http://jbavari.github.io/blog/2014/06/21/pushing-jobs-to-sidekiq-from-another-server/
