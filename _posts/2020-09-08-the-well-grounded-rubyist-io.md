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

#### File.expand_path

```ruby
p Dir.pwd                 # => "/usr/local"
p File.expand_path("bin") # => "/usr/local/bin"
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

#### Dir

##### flag

* `Dir.glob("info*", File::FNM_CASEFOLD)`，表明需要不区分大小写的名称匹配
* `Dir.glob("info*", File::FNM_DOMATCH)`，匹配结果中包含隐藏的点文件

也可以合并使用 `Dir.glob("info*", File::FNM_DOMATCH | File::FNM_CASEFOLD)`

#### FileUtils

```ruby
require 'fileutils'

FileUtils.cp("baker.rb", "baker.copy.rb")
FileUtils.mkdir("backup")
FileUtils.cp(["ensure.rb", "super.rb"], "backup")
FileUtils.rm("./backup/super.rb")
```

##### DryRun 和 NoWrite

* DryRun 输入系统命令

```ruby
FileUtils::DryRun.rm_rf("backup")
rm -rf backup
# => nil
```

* NoWrite 保证不会意外的删除、重写或移动文件

```ruby
FileUtils::NoWrite.rm("backup/super.rb")
# => nil
File.exist?("backup/super.rb")
# => true
```

#### Pathname

```ruby
require 'pathname'

path = Pathname.new("/Users/zhangshuo/log.txt")
path.basename
# => #<Pathname:log.txt>
path.dirname
# => #<Pathname:/Users/zhangshuo>
path.extname
# => ".txt"
path.ascend do |dir|
  puts "Next level up: #{dir}"
end
# Next level up: /Users/zhangshuo/log.txt
# Next level up: /Users/zhangshuo
# Next level up: /Users
# Next level up: /
# => nil
```
