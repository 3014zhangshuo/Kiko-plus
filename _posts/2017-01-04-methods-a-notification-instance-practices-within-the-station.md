---
layout: post
title: '方法:站内通知notification实例做法'
date: 2017-01-04 16:29
comments: true
categories: 
---
>1.挂上关系

先创建一个notification的model，里面需要notifiable_id，notifiable_type(关系的类型)。在notification的model里面我们要挂上它的多态关系和用户关系。
models/notification.rb
```
belongs_to :notifiable, polymorphic: true
belongs_to :recipient, :class_name => "User"
belongs_to :trigger, :class_name => "User"
```
也需要为notification挂上work的关系。
models/work.rb
`has_many :notifications, as: :notifiable`
也需要为user挂上关系，因为我们需要知道通知那些user。
models/user.rb加入`has_many :notifications`

>2.实作发出notification

在application_controller.rb里面定义发信的动作，这样大家都可以调用这个动作。
```
def send_notification(trigger,recipient,notifiable)
   Notification.create(trigger_id: trigger,recipient_id: recipient,notifiable_id: 
                       notifiable.id,notifiable_type: notifiable.class)
end
```
对应的改写resume的controller，我们要向提交简历的时候雇主会得到一份通知。
```
  def create
    @work = Work.find(params[:work_id])
    @resume = Resume.new(resume_params)
    @resume.work = @work
    @resume.user = current_user  
    if @resume.save
      send_notification(current_user.id,@work.user_id,@work) #对应application需要的参数
      flash[:notice] = "成功提交履历"
      redirect_to work_path(@work)
    else
      render :new
    end
  end
```
>3.让用户可以接收到通知。

我们需要定义一个抓取通知的action，放在application_controller里面方便大家调用。
```
def get_notification
 if current_user.present?
  @notifications = Notification.where(:recipient_id => current_user.id).where(:read_at => nil)
 end
end
```
然后在想操作的对象里面加入`before_action :get_notification`，在执行到相应的controller的时候会先调用这个action
修改navbar让用户可以看见通知，采用下拉菜单的样式。
```
  <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
       <i class="fa fa-bell"></i>&nbsp;通知
          <b class="caret"></b>
    </a>
         <% if @notifications.present? %>
           <% @notifications.each do |notification| %>
               <% if notification.read_at == nil %>
                    <ul class="dropdown-menu">
                    <li>
                      <%= link_to redirect_notification_notification_path(notification) do %>
                        <span>
                           用户<%= notification.trigger.id %>
                           发送了简历
                         </span>
                      <% end %>
                     </li>
                     </ul>
              <% end %>
            <% end %>
        <% end %>
   </li>
```

>4.接受完通知后引导到正确的导向。

创建notifications_controller.rb在里面地址接收到讯息后跳转的位置。
```
def redirect_notification
    @notification = Notification.find_by_id(params[:id])
    if @notification.present? && @notification.notifiable_type == "Work"
      @work = Work.find(@notification.notifiable_id)
      @notification.read_at = DateTime.now
      @notification.save
      redirect_to company_work_path(@work)
    elsif @notification.present? && @notification.notifiable_type == "Resume"
      @work = Work.find(@notification.notifiable_id)
      @notification.read_at = DateTime.now
      @notification.save
      redirect_to "/"
    end
  end
```
`@work = Work.find(@notification.notifiable_id)`notifiable_id在生成notification的时候取的是work的数据，所以这里的notifiable_id=work.id。
`@notification.read_at = DateTime.now`取当前的时间值，确保读取过的通知不会再通知栏里面显示出来。
为动作添加路由
```
resources :notifications do
    member do
      get :redirect_notification
    end
  end
```

参考资料:[1](http://guides.ruby-china.org/association_basics.html)