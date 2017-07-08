# GoSpider-docker

# һ. ����

�ڿ�������ʱ������Ҫ��װ��redis���������ֲ�ʽ���棬װMYSQL���÷��������

������������⣬��������������ʱ��������Ҳ�����Ƽ��㣬������docker�����ٲ��𻷾���

�����Ŀǰ����Ļ�����`redis`,`mysql`,`golang`��

����Ҫ��һ̨Linux����ϵͳ�ļ�������ҽ��鰲װ`ubuntu16.04`��

Ȼ��װ��`git`��`docker`��`docker-compose`

��ο���


Dokcer��װ��[http://www.lenggirl.com/tool/docker-ubuntu-install.html](http://www.lenggirl.com/tool/docker-ubuntu-install.html)

���ڵ��Ƽ�������װ��[http://www.lenggirl.com/tool/docker-install.html](http://www.lenggirl.com/tool/docker-install.html)

Docker-compose��װ��[http://www.lenggirl.com/tool/docker-compose.html](http://www.lenggirl.com/tool/docker-compose.html)


# ��. ʹ��

�������ظÿ�


```
git clone https://github.com/hunterhug/GoSpider-docker
```


Ȼ����`build.sh`ִ��Ȩ��

```
chomd 777 build.sh
./build
```

�����󼴿ɴ��ⲿʹ�á�

mysql�ⲿ�˿�8003���˺�����:root/123456

redis�ⲿ�˿�8002������:GoSpider-docker

ʹ��Golang������ִ��

```
docker exec -it GoSpiderGo /bin/bash
```

���ߴ��������127.0.0.1:9999  �˺ţ�admin ����:GoSpider

�Ķ˿ڻ�����μ��·���

Golang�����¿����ܳ����ʹ��Mysql��redis�����Ķ˿�3306��6379

��Ϊ�����Ҿ����ڲ����ⲿ�޸Ĵ��룬����ͬ��

# ��. ԭ��
`build.sh`�������£�

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

ԭ�����Ƚ�`mysql`��redis`�������ļ��ƶ�����Ŀ¼�µ�ĳ���ط����ٹ��ؽ����������ݿ����ݻᱣ���ڱ��أ���ʹ��������Ҳ������������

�����ļ���`mysql`�������Ѿ����øߣ�`redis`����������:`requirepass GoSpider`


`docker-compose.yaml`�������£�

������
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
������



