---
layout: post
title: 'Rails: Get cookie stored in javascript in rails'
date: 2018-08-17 11:28:00
comments: true
tags: [rails]
share: false
---
### Javascript set the cookie

```js
document.cookie = name + '=' + value + '; path=/'
```

### Rails get the cookie

```ruby
cookies['foo'] = 'bar'
```

#### Reference:
* [Stackoverflow: getting-cookie-stored-in-javascript-in-ruby-on-rails](https://stackoverflow.com/questions/24116887/getting-cookie-stored-in-javascript-in-ruby-on-rails)
