---
layout: post
title: '知识点：nil? blank? empty? present?'
date: 2016-11-28 01:05
comments: true
categories: 
---
>.nil?

- It is Ruby method
- It can be used on any object and is true if the object is nil.
- "Only the object nil responds true to nil?" - RailsAPI
```
nil.nil? = true
anthing_else.nil? = false
a = nil
a.nil? = true
“”.nil = false
```

>.empty?

- It is Ruby method
- can be used on strings, arrays and hashes and returns true if:
String length == 0
Array length == 0
Hash length == 0
- Running .empty? on something that is nil will throw a NoMethodError
```
"".empty = true
" ".empty? = false
```

>.blank?

- It is Rails method
- operate on any object as well as work like .empty? on strings, arrays and hashes.

```
nil.blank? = true 
[].blank? = true 
{}.blank? = true 
"".blank? = true 
5.blank? == false
```
- It also evaluates true on strings which are non-empty but contain only whitespace:

`"  ".blank? == true`
`"  ".empty? == false`

Quick tip: `!obj.blank?` == `obj.present?`
```
def present? 
 !blank?
end
```