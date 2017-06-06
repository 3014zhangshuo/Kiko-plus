---
layout: post
title: 'code school testing with spec(2)'
date: 2016-12-15 22:20
comments: true
categories: 
---
###model spec
```
require "spec_helper"
describe Zombie do 
  it "is invalid without a name" do 
    zombie = Zombie.new 
    zombie.should_not be_valid 
  end
end
```
zombie model 
```
class Zombie < ActiveRecord::Base
  validate :name, presence :ture
end
```

###matchers: match 
```
  describe Zombie do 
    it "has a name that matches 'Ash Clone'" do 
      zombie = Zombie.new(name: "Ash Clone 1")
      zombie.name.should match(/Ash Clone\d/)
    end
  end
 ```
###matchers: include 
  ```
  describe Zombie do
   it 'include tweets' do
     tweet1 = Tweet.new(status: 'Uuuuunhhhhh')
     tweet2 = Tweet.new(status: 'Arrrrgggg')
     zombie = Zombie.new(name: 'Ash', tweets: [tweet1, tweet2])
     zombie.tweets.should include(tweet1)
     zombie.tweets.should include(tweet2)
   end
 end
 ```
###matchers: have 
  ```
  describe Zombie do 
    it 'starts with two weapons' do 
      zombie = Zombie.new(name: 'Ash')
      zombie.weapons.count.should == 2
    end
  end
  ```
  reads mush better 
  ```
 describe Zombie do 
  it 'starts with two weapons' do 
    zombie = zombie.new(name: 'Ash')
    zombie.should have(2).weapons
  end
 end
 ```
 `have(n)` `have_at_least(n)` `have_at_most(n)`
 ###matchers: change 
 ```
 describe Zombie do 
   it 'changes the number of Zombies' do 
     zombie = Zombie.new(name: 'Ash')
     expect { zombie.save }.to change { Zombie.count }.by(1)
   end
 end
 ```
 give these a shot `by(n)``from(n)``to(n)`
 you can chain them `.from(1).to(5)`
 ###raise_error 
 ```
 describe Zombie do 
   it 'raises an error if saved without a name' do 
   zombie = Zombie.new 
   expect { zombie.save! }.to raise_error( 
    ActiveRecord::RecordInvalid
    )
   end
 end
 ```
 these modifiers also work`to` `not_to` `to_not`
 show more detail
`rspec --color --format documentation spec/controllers/courses_controller_spec.rb`