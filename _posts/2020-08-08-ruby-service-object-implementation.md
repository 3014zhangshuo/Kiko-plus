---
layout: post
title: "Rails: ServiceObject"
date: 2020-08-08
tags: [ruby, rails]
---


#### Bass Class

```ruby
# app/services/application_service.rb
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
```

#### Implementation

```ruby
# app/services/tweet_creator.rb
class TweetCreator < ApplicationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
    client.update(@message)
  end
end
```

#### Usage

```ruby
class TweetController < ApplicationController
  def create
    TweetCreator.call(params[:message])
  end
end
```

#### When Should I Not Use a Service Object?

1. Does your code handle routing, params or do other controller-y things?

  If so, don’t use a service object—your code belongs in the controller.

2. Are you trying to share your code in different controllers?

  In this case, don’t use a service object—use a concern.

3. Is your code like a model that doesn’t need persistence?

  If so, don’t use a service object. Use a non-ActiveRecord model instead.

4. Is your code a specific business action? (e.g., “Take out the trash,” “Generate a PDF using this text,” or “Calculate the customs duty using these complicated rules”)

  In this case, use a service object. That code probably doesn’t logically fit in either your controller or your model.

#### Rules for Writing Good Service Objects

1. Only One Public Method per Service Object
2. Name Service Objects Like Dumb Roles at a Company
3. Don’t Create Generic Objects to Perform Multiple Actions (Single responsibility principle)
4. Handle Exceptions Inside the Service Object

---

* https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
* https://stackoverflow.com/questions/16159021/rails-service-objects-vs-lib-classes/16175446#16175446
