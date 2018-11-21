---
layout: post
title: 'Ruby: File Structure'
date: 2018-07-20 12:30:00
comments: true
tags: [ruby]
share: false
---
Directory Structure:
```
(root dir)
├── a
│   ├── first.rb
│   ├── second.rb
│   └── third.rb
└── a.rb
```
Files contents:
```
# a.rb
require_relative './a/first.rb'
require_relative './a/second.rb'
require_relative './a/third.rb'

module A
end


# a/first.rb
module A
  class First
    # ...
  end
end


# a/second.rb
module A
  class Second
    # ...
  end
end


# a/third.rb
module A
  class Third
    # ...
  end
end
```
[1](https://stackoverflow.com/questions/12035057/breaking-ruby-module-across-several-files)
