class Preson 
    @@bar = "123"
	def initialize(name)
		@name = name 
	end


	def foo 
		return @name 
	end

	def self.bar 
		@@bar 
		@name # not same 
	end

	def name=(name)
		@name = name
	end



	attr_accessor :name 
   

   def name 
   	@name 
   end

   def name=(val)
   	@name = val 
   end

   module myutil 
   	def self.foobar
   		puts "foobar"
   	end
   end

   module Mixin 

   def foo
   	puts "foo"
   end

   module ClassMethods 
	def bar 
		puts "bar"
	end
end
end

class A 
	include Mixin 
end

A.new.foo # => "foo"
# include 会变成 instance_method 
# extend 会变成 class_method


class MyClass 
	include Mixin 
	extend Mixin::ClassMethods
end

rails concern 

# like modal 
# comment modal 
# 用同一个功能
# 放在module里面 共同调用

module Foo 

	extend ActionSupport::Concern

	included do 
		belongs_to :user
	end

	class_methods do
	  def self.xxx
  	   # work
      end
	end

  def self.xxx
  	#not work
  end

  def foo
  end

  def bar 
  end

end 


module xxx
	def foo 
		puts "xx"
	end
end

xxx.foo # module class 类似但是不能 new实例化


module X 
	class A 
	end

	module Z 
		A
	end

	class Array
		def  ::Array #父类

	end

end

z a = A


def const_missing(name)
	puts: "Missing #{name}"  
end

# duck typing 即使不同类，只要介面一致就可以

class Duck 
  def quack 
  	puts ""
  end
end

class Mallard 
	def quack
		puts ""
	end
end

birds = [Duck.new, Mallard.new, Object.new]

birds.each do |duck|
	duck.quack if duck.respond_to? :quack #呼叫是否有这个方法
end

java interface
swift protocal

# method 对象的方法	

# function 全域的方法

# puts 方法 定义在 kernel module













