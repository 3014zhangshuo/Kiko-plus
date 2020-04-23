---
layout: post
title: 'Ruby: load code'
date: 2019-01-21 11:39:22
tags: [ruby]
---

### $LOAD_PATH

ruby代码加载依靠`$LOAD_PATH`或`$:`，`$LOAD_PATH`是一个`string array`储存对应加载代码的文件目录，启动时会依据`$LOAD_PATH`寻找并加载代码。

### Kernel.load(filename, wrap=false) → true

> Loads and executes the Ruby program in the file filename. If the filename does not resolve to an absolute path, the file is searched for in the library directories listed in $:. If the optional wrap parameter is true, the loaded script will be executed under an anonymous module, protecting the calling program's global namespace. In no circumstance will any local variables in the loaded file be propagated to the loading environment.

`load` 每次都会重新加载整个文件，并重新执行里面代码，加载类或者其他。防止污染顶层作用域，可以传入参数`true`，这样代码会被一个匿名模块包裹并执行。

```ruby
load './example.rb'
load './example.rb', true
```

#### Fake Load Code

```ruby
def fake_load(file)
  eval File.read(file)
  true
end
```

#### Fake Load With Anonymous Module

```ruby
def fake_load(file)
  Module.new.module_eval(File.read(file))
  true
end
```

### Kernel.autoload(module, filename) → nil

> Registers filename to be loaded (using Kernel::require) the first time that module (which may be a String or a symbol) is accessed.

```ruby
autoload :Calendar, './calendar.rb'
```

### Kernel.require

> Loads the given name, returning true if successful and false if the feature is already loaded.

> If the filename does not resolve to an absolute path, it will be searched for in the directories listed in $LOAD_PATH ($:).

> If the filename has the extension “.rb”, it is loaded as a source file; if the extension is “.so”, “.o”, or “.dll”, or the default shared library extension on the current platform, Ruby loads the shared library as a Ruby extension. Otherwise, Ruby tries adding “.rb”, “.so”, and so on to the name until found. If the file named cannot be found, a LoadError will be raised.
For Ruby extensions the filename given may use any shared library extension. For example, on Linux the socket extension is “socket.so” and require 'socket.dll' will load the socket extension.

> The absolute path of the loaded file is added to $LOADED_FEATURES ($"). A file will not be loaded again if its path already appears in $". For example, require 'a'; require './a' will not load a.rb again.

> Any constants or globals within the loaded source file will be available in the calling program's global namespace. However, local variables will not be propagated to the loading environment.

```ruby
require "my-library.rb"
require "db-driver"
```

### Kernel.require_relative(string) → true or false

> Ruby tries to load the library named string relative to the requiring file's path. If the file's path cannot be determined a LoadError is raised. If a file is loaded true is returned and false otherwise.

```ruby
require_relative 'calendar.rb'
```

### Reference:

[Kernel document](https://ruby-doc.org/core-2.6/Kernel.html)

[Ways to load code](https://practicingruby.com/articles/ways-to-load-code)

[Ruby 内核类加载](https://ruby-china.org/topics/26036)

[Rails 中的类加载机制](https://ruby-china.org/topics/26034)
