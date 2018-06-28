---
layout: post
title: 'Ruby: String to Class And Class to String'
date: 2018-06-25 00:00:00
comments: true
tags: [Ruby]
share: false
---

### Class to String Only Rails Methods

-  ActiveSupport::Inflector
`FooBar.name.underscore.to_sym `

-  ActiveModel::Name
`FooBar.model_name.param_key`

[S](https://stackoverflow.com/questions/5622435/how-do-i-convert-a-ruby-class-name-to-a-underscore-delimited-symbol)

### String to Class
- rails

  ```
  "active_record".camelize                # => "ActiveRecord"
  "active_record".camelize(:lower)        # => "activeRecord"

  "app_user".camelize.constantize
  ```

- prune ruby

  ```
  > class AppUser; end
  => nil
  > AppUser.ancestors
  => [AppUser, Object, Kernel, BasicObject]

  Object.const_get("app_user".camelize)
  ```

[S](https://stackoverflow.com/questions/9524457/converting-string-from-snake-case-to-camelcase-in-ruby/9524521)
