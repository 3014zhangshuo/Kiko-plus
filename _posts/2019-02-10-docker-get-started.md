---
layout: post
title: "Docker: get started"
date: 2019-02-10 11:39:22
comments: true
tags: [docker]
share: false
---
```shell
# 镜像列表 更多用法 docker image ls --help
docker image ls
# 容器列表
docker container ls
# 构建镜像, 镜像名, 目录
docker build example-image .
# 链接本地镜像到远端仓库, 如果使用docker官方仓库registry_url可省略
docker tag example-image registry_url/username/repository_name:tag
# 发布镜像到远端仓库, 不加tag默认为latest
docker push registry_url/username/repository_name:tag
# 拉取镜像, 不加tag默认为latest
docker pull registry_url/username/repository_name:tag
# 运行镜像, -d 为挂起状态不输出log --rm 为容器终止时删除该容器
docker run -d -t -i -—rm -e TOKEN="$TOKEN" username/repository_name:latest
# 查看容器log, -f持续输出
docker container logs containerID/containerName
# 启动一个状态为stopped的容器
docker container start containerID/containerName
```

### Reference:
[第一次构建、运行、发布、获取docker镜像](https://blog.csdn.net/qq_34680763/article/details/79711567)
