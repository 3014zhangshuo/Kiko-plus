---
layout: post
title: 'Rails Use concern namespaces'
date: 2018-06-15 00:00:00
comments: true
tags: [Rails]
share: false
---
```
class Application < Rails::Application
  config.autoload_paths += Dir["#{Rails.root}/app/models/concerns/**/*.rb"]
end
```
[S](http://epigene.github.io/Rails4-Use-concern-namespaces/)
