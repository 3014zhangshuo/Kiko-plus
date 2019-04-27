---
layout: post
title: 'OPEN/CLOSED PRINCIPLE'
date: 2019-04-26 11:39:22
comments: true
tags: [编程原则]
share: false
---

>> 类或者方法，对扩展是开放的，对修改是关闭的。
```ruby
class UsageFileParser
  def initialize(client, usage_file)
    @client = client
    @usage_file = usage_file
  end

  def parse
    case @client.usage_file_format
    when :xml
      parse_xml
    when :csv
      parse_csv
    end
  end

  private

  def parse_xml
  end

  def parse_csv
  end
end

# refactor

class UsageFileParser
  def initialize(client, parser)
    @client = client
    @parser = parser
  end

  def parse(usage_file)
    @parser.parse(usage_file)
    @client.last_parse = Time.current
    @client.save
  end
end

class XmlParser
  def parse(usage_file)
  end
end

class CsvParsere
  def parse(usage_file)
  end
end
```

```ruby
class Charger
  def charge
    case phone_type
    when iphone
      use_lightning
    when android_phone
      user_type_c
    end
  end

  private

  def use_lightning
  end

  def use_type_c
  end
end

# refactor

class Changer
  def initialize(phone)
    @phone = phone
  end

  def charge
    @phone.charge
  end
end

class IPhone
  def charge
    use_lightning
  end
end

class AndroidPhone
  def charge
    use_type_c
  end
end
```

### Reference
* [Ruby 面向对象编程之 SOLID](https://ruby-china.org/topics/38441)
* [Back to Basics: SOLID](https://thoughtbot.com/blog/back-to-basics-solid)
* [写了这么多年代码，你真的了解SOLID吗？](https://insights.thoughtworks.cn/do-you-really-know-solid/)
