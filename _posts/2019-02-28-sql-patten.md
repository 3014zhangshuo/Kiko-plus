```ruby
Company.where('name like :name', name: "%中国").map(&:name) # => 博世中国, 毕马威中国 ...
Company.where('cn like :cn', cn: "中国%").map(&:cn) # => 中国西电集团, 中国天辰工程 ...

Company.where('cn like :cn', cn: "中国")
# acts like the equals operator

Company.where('cn like :cn', cn: "_国_") # => 空中网
# 匹配 前 后 仅有一个字符的
```
