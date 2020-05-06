---
layout: post
title: "查看 Grape 路由"
date: 2020-05-06
tags: [ruby]
---

项目中用到的 `Grape` 版本为 `0.15.0` 版本太旧了，如果新版本的话可以把 `API.routes` 改成 `API::Root.routes`。

```ruby
desc "API Routes"
task :routes do
  API.routes.each do |api|
    method = api.request_method.ljust(10)
    path = api.path
    puts "#{method} #{path}"
  end
end
```

*吐槽：用 `Rails` 自带的 `API` 去写不好吗？用 `Grape` 还得学习一套 `DSL` 语言*

---

* https://stackoverflow.com/questions/44656878/how-to-get-routes-by-grape-api
