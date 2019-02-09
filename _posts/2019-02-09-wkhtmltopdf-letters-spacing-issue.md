---
layout: post
title: "wkhtmltopdf render word letters spacing issue"
date: 2019-02-09 11:39:22
comments: true
tags: [issue rails ruby]
share: false
---
近期网站迁移到新的服务器，导致生成PDF时字体渲染不正确（缺少字体文件），下面记录解决过程：

1. 确定旧服务器渲染文件使用的字体，使用下面命令获得字体名称。
```shell
strings fileName.pdf | grep FontName
```

2. 安装缺失字体包
一共缺失4中英文字体，分别是Arial、Helvetica、Georgia、Times New Roman，可以安装微软的字体包（字体很全）。

  ```shell
  # 尝试安装过这个 fonts-liberation，生成出并不是正确的字体
  # sudo apt-get install fonts-liberation
  # 卸载 sudo apt-get remove fonts-liberation

  sudo apt-get install ttf-mscorefonts-installer
  ```
使用命令`fc-list`查看字体是否安装成功。现在生成PDF时字体渲染正确了，但是出现了新的问题，英文单词字母之前出现了不规则的空隙。

3. 修改`/etc/fonts/conf.d/51-local.conf`配置
```xml
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
  <match target="font">
    <edit mode="assign" name="rgba">
      <const>rgb</const>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="hinting">
      <bool>true</bool>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="hintstyle">
      <const>hintslight</const>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="antialias">
      <bool>true</bool>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="lcdfilter">
      <const>lcddefault</const>
    </edit>
  </match>
</fontconfig>
```

### Reference:
* [Changing font-family just doesn't work](https://github.com/mileszs/wicked_pdf/issues/46)
* [bad kerning for fonts in output PDF](https://github.com/wkhtmltopdf/wkhtmltopdf/issues/45)
* [Text not well formatted : additional spaces appear after some characters](https://github.com/wkhtmltopdf/wkhtmltopdf/issues/2634)
* [WickedPDF Rendering differently locally vs production](https://stackoverflow.com/questions/35415058/wickedpdf-rendering-differently-locally-vs-production)
* [fonts.conf 中文手册](http://www.jinbuguo.com/gui/fonts.conf.html)
* [Linux字体美化实战(Fontconfig配置)](http://www.jinbuguo.com/gui/linux_fontconfig.html)
