---
layout: post
title: '记录:devise confirmation/reset password send email and set config sendcloud'
date: 2017-02-06 19:21
comments: true
categories: 
---
我们想用户用真实的邮箱进行创建，这样我们发送的email就不会miss。就可以调用devise隐藏的confirmation功能。
给用户创建有邮箱发送一封确认信，同时生成confirmation_token和sent_confirmation_time。
用户通过点击邮箱给出的链接，生成confirmed_at(time)这里也是一个时间。这样用户验证就完成了。
>首先增加相应的栏位

输入`rails g migration add_confirmable_to_devise`
```
class AddConfirmableToDevise < ActiveRecord::Migration
  # Note: You can't use change, as User.update_all will fail in the down migration

  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # Only if using reconfirmable

    add_index :users, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.

    # To avoid a short time window between running the migration and updating all existing

    # users as confirmed, do the following

    execute("UPDATE users SET confirmed_at = NOW()")
    # All existing user accounts should be able to log in after this.

    # Remind: Rails using SQLite as default. And SQLite has no such function :NOW.

    # Use :date('now') instead of :NOW when using SQLite.

    # => execute("UPDATE users SET confirmed_at = date('now')")

    # Or => User.all.update_all confirmed_at: Time.now

  end

  def down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
    # remove_columns :users, :unconfirmed_email # Only if using reconfirmable

  end
end
```
注意execute("UPDATE users SET confirmed_at = NOW()") 使用SQLite可能会有异常，可以根据注释中的提示把这条指令改为execute("UPDATE users SET confirmed_at = date('now')")。
>让UserModel可以认识confirmation

在user.rb里面加入`devise ..... :confirmable`
`config/initializers/devise.rb`里面加入`config.reconfirmable = true`
修改一些设定`config/initializers/devise.rb`里面加入`config.allow_unconfirmed_access_for = 2.days`
这里规定了用户可以不确认邮箱还可以进行使用的时长，如果去掉这行，新建的用户(没有进行邮箱确认的)将不能登入。
`config/initializers/devise.rb`里面加入`config.confirm_within = 3.days`设定确认邮件的邮箱日期。
修改`config/initializers/devise.rb`里面的`config.mailer_sender = "admin@jianliheike.com"`设置发送的邮箱。

>创建confirmations_controller和复写registrations_controller

```
lass ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new

  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation

  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  protected

    # The path used after resending confirmation instructions.

    def after_resending_confirmation_instructions_path_for(resource_name)
      is_navigational_format? ? new_session_path(resource_name) : '/'
    end

    # The path used after confirmation.

    def after_confirmation_path_for(resource_name, resource)
      if signed_in?(resource_name)
        signed_in_root_path(resource)
      else
        new_session_path(resource_name)
      end
    end

    def translation_scope
      'devise.confirmations'
    end
end
```

```
class RegistrationsController < Devise::RegistrationsController 
  # POST /resource

  def create
    build_resource(sign_up_params)
    if resource.save
      # this block will be used when user is saved in database

      if resource.active_for_authentication?
        # this block will be used when user is active or not required to be confirmed

        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        # this block will be used when user is required to be confirmed

        user_flash_msg if is_navigational_format? #created a custom method to set flash message

        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      # this block is used when validation fails

      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  # set custom flash message for unconfirmed user

  def user_flash_msg
    if resource.inactive_message == :unconfirmed
      #check for inactive_message and pass email variable to devise locals message

      set_flash_message :notice, :"signed_up_but_unconfirmed", email: resource.email
    else
      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
    end
  end
end
```

>在development端测试邮件是否发送

加入`gem 'letter_opener', group: :development`
设置config/environments/development
config.action_mailer.delivery_method = :letter_opener
config.action_mailer.default_url_options = { :host => 'localhost:3000' }

>完成prodcution环境的设置

设置config/environments/production
```
config.action_mailer.default_url_options = { :host => 'sheltered-cove-12064.herokuapp.com'}
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: "smtpcloud.sohu.com",
  port: 25,
  domain: "heroku.com",
  authentication: "login",
  enable_starttls_auto: true,
  user_name: "sendcloud_username",
  password: "sendcloud_key"
  }
```

>其他细节

如果不进行时间的话，采用自定义的方法可以跳过confirmation的验证的,在model user里面加入:
```
 def confirmation_required?
      !confirmed?
 end
 
  def confirmation_required?
      false
 end
```
在user model加入`before_create :skip_confirmation!`也可以达成。
其实这两种方法都是给confirmed_at一个值。
devise的原码
```
def skip_confirmation!
  self.confirmed_at = Time.now.utc
end
```
这样强行跳转并不好，有一点画蛇添足的感觉。我们需要通过确认邮件来产生confirmed_at的值。如果按照以上面的方法。confirmation这个功能其实就是无用的。如果想要不确认也能登入的话，建议设置确认时间。

<hr>

[development](http://mayalin.logdown.com/posts/2016/08/24/804294)
[production](http://ju.outofmemory.cn/entry/155507)