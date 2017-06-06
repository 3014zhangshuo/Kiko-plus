---
layout: post
title: 'code school testing with spec(3)'
date: 2016-12-16 13:40
comments: true
categories: 
---
####Refactoring into Contexts
old:
```
describe Zombie do
  it { should_not be_genius }
  its(:iq) { should == 0 }
  
  it "should be_genius with high iq" do
    zombie = Zombie.new(iq: 3)
    zombie.should be_genius
  end

  it 'should have a brains_eaten_count of 1 with high iq' do
    zombie = Zombie.new(iq: 3)
    zombie.brains_eaten_count.should == 1
  end
end
```
new:
```
descibe Zombie do 
  it { should_not be_genius }
  its(:iq) { should == 0 }
  
  context "with high iq" do 
    subject { Zombie.new(:iq:3)}
    it { should be_genius }
    its{:brains_eaten_count} {should == 1}
  end
end
```
####SUBJECT WITH LETS (Rather than declaring our zombie directly in the subject block as we're doing here, move it into its own let named zombie and update the subject to reference this new zombie.)
old: 
```
describe Zombie do 
  let(:tweet) { Tweet.new }
  subject { Zombie.new(tweets: [tweet])}
  its(:tweets) { should include(tweet)}
  its(:latest_tweet) {should == tweet}
end
```
new: 
```
describe Zombie do 
  let(:zombie) { Zombie.new(tweets:[tweet])}
  let(:tweet) { Tweet.new }
  subject { zombie }
  its(:tweets) { should include(tweet) }
  it "should have a latest tweet" do 
    zombie.latest_tweet.should == tweet 
  end
end
```
####METHOD AS A SUBJECT(make the two small changes which will allow these two tests to pass)
old:
```
describe Zombie do
  context "with high iq" do
     let(:zombie) { Zombie.new(iq: 3, name: 'Anna') }
     subject { zombie }

     it "should be returned with genius" do
       Zombie.genius.should include(zombie)
     end

     it "should have a genius count of 1" do     
       Zombie.genius.count.should == 1
     end
  end
end
```
new:
```
describe Zombie do
  context "with high iq" do
     let!(:zombie) { Zombie.create(iq: 3, name: 'Anna') }
     subject { zombie }

     it "should be returned with genius" do
       Zombie.genius.should include(zombie)
     end

     it "should have a genius count of 1" do     
       Zombie.genius.count.should == 1
     end
  end
end
```
###refactor this 
before 
```
describe Zombie do 
  it 'has no name' do 
     @zombie = Zombie.create  
     @zombie.name.should be_nil?
  end
  it 'craves brains' do 
    @zombie = Zombie.create 
    @zombie.should be_craving_brains 
  end
  it  'should not be hungry after eating brains' do 
    @zombie = Zombie.create 
    @zombie.hungry.should be_true 
    @zombie.eat(:brains)
    @zombie.hungry.should be_false 
  end
end
```
after 
```
describe Zombie do 
  let(:zombie) {Zombie.create}
  subject { zombie }
  
  its(:name) { should be_nil? }
  
  it {should be_craving_brains}
  
  it  'should not be hungry after eating brains' do 
    expect { zombie.eat(:brains) }.to change 
    {zombie.hungry}.from(true).to(false)
  end
end
```

