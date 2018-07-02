---
layout: post
title: 'Rails: Namespace Models'
date: 2018-06-30 9:30:00
comments: true
tags: [rails]
share: false
---
app/models/daily.rb

```
module Daily
  def self.table_name_prefix
    'daily_'
  end
end
```

app/models/daily/order.rb
```
class Daily::Order < ApplicationRecord
end

module Daily
  class Order
  end
end
```

`Daily::Order.table_name` => `daily_orders`

[S](https://coderwall.com/p/2tnpfa/easily-namespace-your-rails-models)
[S](https://blog.makandra.com/2014/12/organizing-large-rails-projects-with-namespaces/)
