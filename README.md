# GoSpider-docker

# 一. 介绍

在开发爬虫时，我们要安装好redis，方便做分布式爬虫，装MYSQL，好方便存数据

所以做了这个库，现在是容器化的时代，本人也从事云计算，所以用docker来快速部署环境。

这个库目前部署的环境有`redis`,`mysql`,`golang`。

你先要有一台Linux操作系统的计算机，我建议安装`ubuntu16.04`。

然后安装好`git`，`docker`和`docker-compose`

请参考：


Dokcer安装：[http://www.lenggirl.com/tool/docker-ubuntu-install.html](http://www.lenggirl.com/tool/docker-ubuntu-install.html)

国内的推荐这样安装：[http://www.lenggirl.com/tool/docker-install.html](http://www.lenggirl.com/tool/docker-install.html)

Docker-compose安装：[http://www.lenggirl.com/tool/docker-compose.html](http://www.lenggirl.com/tool/docker-compose.html)


# 二. 使用

请先下载该库


```
git clone https://github.com/hunterhug/GoSpider-docker
```


然后赋予`build.sh`执行权限

```
chomd 777 build.sh
./build
```

启动后即可从外部使用。

mysql外部端口8003，账号密码:root/123456

redis外部端口8002，密码:GoSpider

进入Golang环境请执行

```
docker exec -it GoSpide-golang1.8 /bin/bash
```

或者打开浏览器：127.0.0.1:9999  账号：admin 密码:GoSpider

Golang环境下开发跑程序可使用Mysql和redis本来的端口3306和6379

因为容器挂卷，在内部或外部修改代码，都会同步

如果本机没有安装`mysql`和`redis`客户端，可执行

```
docker exec -it GoSpider-redis redis-cli -a GoSpider
docker exec -it  GoSpide-mysqldb mysql -uroot -p123456
```

# 三. 原理
`build.sh`内容如下：

```
#!/bin/bash
mkdir -p $HOME/mydocker/redis/data
mkdir -p $HOME/mydocker/redis/conf
mkdir -p $HOME/mydocker/mysql/data
mkdir -p $HOME/mydocker/mysql/conf
cp my.cnf $HOME/mydocker/redis/conf
cp redis.conf $HOME/mydocker/mysql/conf
docker-compose up -d

```

原理是先将`mysql`和redis`的配置文件移动到根目录下的某个地方，再挂载进容器，数据库数据会保存在本地，即使容器死掉也可重启不丢。

配置文件中`mysql`连接数已经设置高，`redis`设置了密码:`requirepass GoSpider`


`docker-compose.yaml`内容如下：

```
version: '2'
services:
    redis: 
      image: redis:3.2
      ports: 
        - "8002:6379"
      volumes:
        - $HOME/mydocker/redis/data:/data
        - $HOME/mydocker/redis/conf/redis.conf:/usr/local/etc/redis/redis.conf
    mysqldb: 
      image: mysql
      ports: 
        - "8003:3306"
      environment: 
        - MYSQL_ROOT_PASSWORD=123456
      volumes:
        - $HOME/mydocker/mysql/data:/var/lib/mysql
        - $HOME/mydocker/mysql/conf:/etc/mysql/conf.d
	
    golang1.8:
      build: ./golang1.8
      net: "host"
      links: 
        - redis
        - mysqldb
      volumes:
        - $HOME/mydocker/go:/go
```

可适当改端口



