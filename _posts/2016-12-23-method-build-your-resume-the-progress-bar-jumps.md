---
layout: post
title: '方法:生成简历的进度条跳转方法'
date: 2016-12-23 17:21
comments: true
categories: 
---
>首先讲一下生成简历方法。

我们的简历生成是分页模式的，点击新建简历自动生成一份新的简历，里面包含resume的id和创建者的id。然后跳转到填写详细步骤的页面，总有7部分，每一部分都是抓取之前的id去update相应id的resume。最后一步生成html版的resume（可以再进行编辑)后可以下载pdf版的简历。

>对应controller的code

```
# 点击new生成简历跳转page1
  def new
    @resume = Resume.new
    @resume.user = current_user
    @resume.save!
    redirect_to page1_user_resume_path(@resume)
  end

  # 拆分页面
  def page1
    @resume = Resume.find(params[:id])
    @resume.user = current_user
    @resume.save!
  end

  def page1_commit
    @resume = Resume.find(params[:id])
    @resume.update(resume_params)
    # 重定向到下一页
    redirect_to page2_user_resume_path(@resume)

  end

  def page2
    @resume = Resume.find(params[:id])
  end

  def page2_commit
    @resume = Resume.find(params[:id])
    @resume.update(resume_params)

    if params[:commit] == "保存并进入下一步" //判断当前页面的跳转页面
      redirect_to page3_user_resume_path(@resume)
    else
      redirect_to page2_user_resume_path(@resume)
    end
  end
  
  ........
  
def finish
    @resume = Resume.find(params[:id])
  end

```

>routes.rb里面的路由设定

```
     member do
        get :page1
        post :page1_commit
        ......
        get :finish
     end
```

>想要完成跳转的页面

html写法无法跳转页面
```
<div class="container">
<div class="form-bootstrapWizard">
	 <ul class="bootstrapWizard form-wizard">
			<% if current_page?(page1_user_resumes_path(@resumes)) %><li class="active"><% else %><li><% end %>
			<a href=" " data-toggle=" " class=" "> <span class="step">1</span> <span class="title">一句话</span> </a>
			 </li>

......
			<% if current_page?(user_resume_preview_path(@resume)) %><li class="active"><% else %><li><% end %>
			<a href=" " data-toggle=" "> <span class="step">8</span> <span class="title">生成简历</span> </a>
			 </li>
	 </ul>
	 <div class="clearfix"></div><br><br>
</div>
</div>
```
改为ruby写法，路径改为link_to 
```
<div class="container">
<div class="form-bootstrapWizard">
	 <ul class="bootstrapWizard form-wizard">

		 <% if current_page?(page1_user_resume_path(@resume)) %><li class="active"><% else %><li><% end %>
			 <% if !@resume.nil? %>
			 <%= link_to page1_user_resume_path(@resume) do  %>
			 <%= content_tag :span, "1", :class => "step" %><%= content_tag :span, "一句话", :class => "title" %>
			<% end %>
			<% end %>
		 </li>
.........
			 <% if current_page?(user_resume_preview_path(@resume)) %><li class="active"><% else %><li><% end %>
         <%= link_to user_resume_preview_path(@resume) do  %>
         <%= content_tag :span, "8", :class => "step" %><%= content_tag :span, "生成简历", :class => "title" %>
        <% end %>
			 </li>
	 </ul>
	 <div class="clearfix"></div><br><br>
</div>
</div>

```
注意两点：1.可以用content_tag的方法来写html的标签`<span class="step">8</span>`
                                            `<%= content_tag :span, "8", :class => "step" %>`
        2.用判断的方法显示时候有该步骤的跳转图片。
