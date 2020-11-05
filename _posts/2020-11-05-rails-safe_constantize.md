---
layout: post
title: "Rails: safe_constantize"
date: 2020-11-05
tags: [rails, ruby]
---

```ruby
"A".constantize rescue nil

require 'active_support'
include ActiveSupport::Inflector
safe_constantize("A") # => nil, return nil without raise error
```

如果在 `rails` 中可以用 `String#safe_constantize`

```ruby
"A".safe_constantize # => nil
```

```ruby
# File activesupport/lib/active_support/core_ext/string/inflections.rb
def safe_constantize
  ActiveSupport::Inflector.safe_constantize(self)
end
```
