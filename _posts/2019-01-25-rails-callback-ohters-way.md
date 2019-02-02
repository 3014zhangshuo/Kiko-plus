---
layout: post
title: 'Rails: Callback's others way'
date: 2019-01-24 11:39:22
comments: true
tags: [rails ruby]
share: false
---

### 去掉不必要的callback，使用service object
> Callbacks ensure that anyone updating or saving a record won't forget to perform an operation that should be performed on #save.

#### 不必要的回调
```ruby
class Company < ApplicationRecord
  after_commit :send_emails_after_onboarding

  private

  def send_emails_after_onboarding
    if just_finished_onboarding?
      EmailSender.send_email_for_company!(self)
    end
  end
end
```
#### 使用Service Object
```ruby
class Company < ApplicationRecord
end

class CompanyOnboarder
  def onboard!(company_params)
    company = Company.new(company_params)
    company.save!
    EmailSender.send_email_for_company!(company)
  end
end
```
把业务逻辑从`Callback`移动到`Service Object`，这样就不需要每次执行到`#save`时都进行是否发信的运算，也减少了`Company`数据储存和`EmailSender`的耦合。

### 使用异步任务执行回调业务逻辑
使用异步任务处理，可以减少请求的处理时间，并易于测试。
```ruby
class Company < ApplicationRecord
  after_commit :create_welcome_notification

  private def create_welcome_notification
    notifications.create(title: 'Welcome!')
  end
end
```

```ruby
class Company < ApplicationRecord
  after_commit :create_welcome_notification

  private def create_welcome_notification
    WelcomeNotificationCreator.perform_async(id)
  end
end

class WelcomeNotificationCreator
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)
    company.notifications.create(title: 'Welcome!')
  end
end
```
### 更多的使用`after_commit`
#### after_save
> Is called after Base.save (regardless of whether it’s a create or update save). Note that this callback is still wrapped in the transaction around save. For example, if you invoke an external indexer at this point it won’t see the changes in the database.
#### after_commit
> This callback is called after a record has been created, updated, or destroyed.

如果使用`after_create`创建异步任务处理回调会发生奇怪的错误，例如`ActiveRecord::RecordNotFound`。因为在`after_create`时，对于外界这个新的记录并不存在，使用`after_commit`可以避免，但要注意`after_commit`中`_change?`方法将失效，可以使用`previous_changes`来代替。
```ruby
class Company < ActiveRecord::Base
  after_create :create_welcome_notification

  private

  def create_welcome_notification
    # The database transaction has not been committed at this point,
    # so there's a chance that the Sidekiq worker will pick up the job
    # before our `Company` has been persisted to the database.
    WelcomeNotificationCreator.perform_async(id)
  end
end
```

```ruby
class Company < ActiveRecord::Base
  after_commit :create_welcome_notification, on: :create

  private

  def create_welcome_notification
    WelcomeNotificationCreator.perform_async(id)
  end
end
```
### 避免在回调中进行逻辑判断运算
```ruby
# Bad
class Company < ApplicationRecord
  after_commit :create_welcome_notification, if: -> { should_welcome? && admirable_company? }

  private

  def create_welcome_notification
    WelcomeNotificationCreator.perform_async(id)
  end
end

# Good
class Company < ApplicationRecord
  after_commit :create_welcome_notification, if: -> { should_welcome? && admirable_company? }

  private

  def create_welcome_notification
    WelcomeNotificationCreator.perform_async(id)
  end
end

# Best
class Company < ApplicationRecord
  after_commit :create_welcome_notification

  private

  def create_welcome_notification
    WelcomeNotificationCreator.perform_async(id)
  end
end

class WelcomeNotificationCreator
  include Sidekiq::Worker

  def perform(company_id)
    @company = Company.find(company_id)

    return unless @company.should_welcome? && @company.admirable_company?

    # We passed our check, do the work.
  end
end
```
### 不要在回调中进行数据验证

### Reference:
[5 Rails Callbacks Best Practices Used at Gusto](https://engineering.gusto.com/the-rails-callbacks-best-practices-used-at-gusto/)
