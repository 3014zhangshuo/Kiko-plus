---
layout: post
title: "Rails migrate 不要使用 index: true"
date: 2020-05-22
tags: [rails]
---

### 添加数据库 index 的几种方法：

```
create_table :users do |t|
  t.integer :group_id, index: true
end
```

```
add_column :users, :name, index: true
```

```
add_index :users, :name
```

> 其实这里只有第三种是可以确保能添加上 `index` 的，第一种在低版本的 AR （4.0.13） 下没有这个写法。

> 而 `add_column` 根本没有 `index: true` 这种写法，这是某一个版本 `rails` 的文档上写错了。

#### 但是有两个特例，这两种添加 `index` 的方式是奏效的：

```
create_table :users do |t|
  t.references :group, index: true
end

add_reference :users, :group, index: true
```

##### 源码分别是：

```
#lib/active_record/connection_adapters/abstract/schema_definitions.rb

def references(*args)
  options = args.extract_options!
  polymorphic = options.delete(:polymorphic)
  index_options = options.delete(:index)
  args.each do |col|
    column("#{col}_id", :integer, options)
    column("#{col}_type", :string, polymorphic.is_a?(Hash) ? polymorphic : options) if polymorphic
    index(polymorphic ? %w(id type).map { |t| "#{col}_#{t}" } : "#{col}_id", index_options.is_a?(Hash) ? index_options : {}) if index_options
  end
end
```

*alias belongs_to*

```
#lib/active_record/connection_adapters/abstract/schema_statements.rb

def add_reference(table_name, ref_name, options = {})
  polymorphic = options.delete(:polymorphic)
  index_options = options.delete(:index)
  add_column(table_name, "#{ref_name}_id", :integer, options)
  add_column(table_name, "#{ref_name}_type", :string, polymorphic.is_a?(Hash) ? polymorphic : options) if polymorphic
  add_index(table_name, polymorphic ? %w[id type].map{ |t| "#{ref_name}_#{t}" } : "#{ref_name}_id", index_options.is_a?(Hash) ? index_options : nil) if index_options
end
```
*alias add_belongs_to*

#### ActiveRecord 4.2.11.1 以上的版本（包含），`t.string index: true` 是可以成功创建 index

##### 源码如下：

```
#lib/active_record/connection_adapters/abstract/schema_definitions.rb

def column(name, type, options = {})
  name = name.to_s
  type = type.to_sym
  options = options.dup

  if @columns_hash[name] && @columns_hash[name].primary_key?
    raise ArgumentError, "you can't redefine the primary key column '#{name}'. To define a custom primary key, pass { id: false } to create_table."
  end

  index_options = options.delete(:index)
  index(name, index_options.is_a?(Hash) ? index_options : {}) if index_options
  @columns_hash[name] = new_column_definition(name, type, options)
  self
end
```

> **这些方法都获取 options 中的 index，并调用方法创建了 index**

#### 看看 `add_column` 的源码是怎么处理的

*ActiveRecord version：5.2.0*

```ruby
#lib/active_record/connection_adapters/abstract/schema_definitions.rb

def add_column(name, type, options)
  name = name.to_s
  type = type.to_sym
  @adds << AddColumnDefinition.new(@td.new_column_definition(name, type, options))
end

def new_column_definition(name, type, **options) # :nodoc:
  if integer_like_primary_key?(type, options)
    type = integer_like_primary_key_type(type, options)
  end
  type = aliased_types(type.to_s, type)
  options[:primary_key] ||= type == :primary_key
  options[:null] = false if options[:primary_key]
  create_column_definition(name, type, options)
end

def create_column_definition(name, type, options)
  ColumnDefinition.new(name, type, options)
end

ColumnDefinition = Struct.new(:name, :type, :options, :sql_type) do # :nodoc:
  def primary_key?
    options[:primary_key]
  end

  [:limit, :precision, :scale, :default, :null, :collation, :comment].each do |option_name|
    module_eval <<-CODE, __FILE__, __LINE__ + 1
      def #{option_name}
        options[:#{option_name}]
      end

      def #{option_name}=(value)
        options[:#{option_name}] = value
      end
    CODE
  end
end
```

> 支持的 `options` 类型只有 `[:limit, :precision, :scale, :default, :null, :collation, :comment]`

### 总结

> 除去其他的写法，给自己定了风格，今后会遵循使用下面的方式来添加数据库 `index`。

```
create_table :users do |t|
  t.string :name

  t.index :name
end

#或者是

add_index :users, :name
```

---

* https://makandracards.com/makandra/32353-psa-index-true-in-rails-migrations-does-not-work-as-you-d-expect
