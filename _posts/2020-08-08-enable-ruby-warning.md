---
layout: post
title: "Ruby: 开启警告模式"
date: 2020-08-08
tags: [ruby]
---

#### 命令行开启

```
ruby -w0 a.rb // set warning level; 0=silence, 1=medium, 2=verbose (default)
```

#### 在 Rails 中开启

```ruby
# config/application.rb

class Application < Rails::Application
  $VERBOSE = true
end
```

---

* https://stackoverflow.com/questions/5591509/suppress-ruby-warnings-when-running-specs
* https://stackoverflow.com/questions/6129575/how-to-enable-ruby-warnings-in-rails
