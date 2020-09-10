---
layout: post
title: "读书笔记：Ruby程序员修炼之道-文件和I/O操作"
date: 2020-09-08
tags: [ruby, 读书笔记, Ruby程序员修炼之道]
---

+ IO
  + STDIN  -> $stdin
  + STDOUT -> $stdout
  + STDERR -> $stderr

#### File#rewind

把 `File` 对象的内部位置指针移动到文件的开端位置。

```ruby
f = File.new('log.txt', 'w+')
f.puts "hello"
f.gets   # => nil
f.pos    # => 6
f.rewind # => 0
f.pos # => 0
f.gets # => 'hello\n'
```

#### File#seek

```ruby
f = File.new('log.txt', 'w+')
f.puts "hello"
f.seek(2, IO::SEEK_SET) # 指针移动到第二个字节
f.readline
f.seek(2, IO::SEEK_CUR) # 指针相对当前前移二个字节
f.readline
f.seek(-2, IO::SEEK_END) # 指针移动到文件末端前二个字节，必须是负数
f.readline
```

#### 系统级IO方法

`sysseek`，`sysread`，`syswrite` 除非必要外不使用。这些统称为低等级IO，与高等级IO混用会有问题（如：写入先后顺序）。

#### FileTest

```ruby
FileTest.exist?("log.txt")
FileTest.directory?("/log")
FileTest.file?("log.txt")
FileTest.symlink?("log.txt")
FileTest.readable?("log.txt")
FileTest.writable?("log.txt")
FileTest.executable?("log.txt")
FileTest.zero?("log.txt")

FileTest.size("log.txt")
```

还有 `blockdev?`，`chardev?`，`pipe?`，`socket?`

**Kernel#test 方法也可以获取文件信息**

#### File::Stat

```ruby
File::Stat.new("log.txt")
# ctime 创建时间
# mtime 修改时间
# atime 最后访问时间

# 等同于
File.open("log.txt") { |f| f.stat }
```
