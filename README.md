# GoSpider-docker

# һ. ����

�ڿ�������ʱ������Ҫ��װ��redis���������ֲ�ʽ���棬װMYSQL���÷��������

������������⣬��������������ʱ��������Ҳ�����Ƽ��㣬������docker�����ٲ��𻷾���

�����Ŀǰ����Ļ�����`redis`,`mysql`,`golang`��`golang`ȥ�����ҽ��鰲װ�ڱ��ء�

����Ҫ��һ̨Linux����ϵͳ�ļ�������ҽ��鰲װ`ubuntu16.04`��

Ȼ��װ��`git`��`docker`��`docker-compose`

��ο���

Dokcer��װ��[http://www.lenggirl.com/tool/docker-ubuntu-install.html](http://www.lenggirl.com/tool/docker-ubuntu-install.html)

���ڵ��Ƽ�������װ��[http://www.lenggirl.com/tool/docker-install.html](http://www.lenggirl.com/tool/docker-install.html)

Docker-compose��װ��[http://www.lenggirl.com/tool/docker-compose.html](http://www.lenggirl.com/tool/docker-compose.html)

���Ѿ�д�ýű���װdocker�ˣ���ֱ������

```
chmod 777 docker-install.sh
./docker-install.sh
```

�һ��ǽ�������԰ٶ�һ�¡�

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

redis�ⲿ�˿�8002������:GoSpider

��Ϊ�����Ҿ����ڲ����ⲿ�޸Ĵ��룬����ͬ��

�������û�а�װ`mysql`��`redis`�ͻ��ˣ���ִ��

```
docker exec -it GoSpider-redis redis-cli -a GoSpider
docker exec -it  GoSpider-mysqldb mysql -uroot -p123456

mysql> show variables like '%max_connect%';
```

����golang���ҽ��鱾�ذ�װ�����������ͨ��docker������װ��

��������:

```
docker pull golang:1.8
docker run --rm --net=host -it -v $HOME/mydocker/go:/go --name mygolang golang:1.8 /bin/bash
```

# ��. ԭ��
`build.sh`�������£�

```
#!/bin/bash
#sudo rm -rf $HOME/mydocker
sudo mkdir -p $HOME/mydocker/redis/data
sudo mkdir -p $HOME/mydocker/redis/conf
sudo mkdir -p $HOME/mydocker/mysql/data
sudo mkdir -p $HOME/mydocker/mysql/conf
sudo mkdir -p $HOME/mydocker/go
sudo cp my.cnf $HOME/mydocker/mysql/conf/my.cnf
sudo cp redis.conf $HOME/mydocker/redis/conf/redis.conf
sudo docker-compose stop
sudo docker-compose rm -f
sudo docker-compose up -d
```

ԭ�����Ƚ�`mysql`��redis`�������ļ��ƶ�����Ŀ¼�µ�ĳ���ط����ٹ��ؽ����������ݿ����ݻᱣ���ڱ��أ���ʹ��������Ҳ������������

�����ļ���`mysql`�������Ѿ����øߣ�`redis`����������:`requirepass GoSpider`


`docker-compose.yaml`�������£�

```
version: '2'
services:
    redis: 
      container_name: "GoSpider-redis"
      image: redis:3.2
      ports: 
        - "6379:6379"
      volumes:
        - $HOME/mydocker/redis/data:/data
        - $HOME/mydocker/redis/conf:/usr/local/etc/redis
      command: redis-server /usr/local/etc/redis/redis.conf
    mysqldb: 
      container_name: "GoSpider-mysqldb"
      image: mysql:5.7
      ports: 
        - "3306:3306"
      environment: 
        - MYSQL_ROOT_PASSWORD=459527502
      volumes:
        - $HOME/mydocker/mysql/data:/var/lib/mysql
        - $HOME/mydocker/mysql/conf:/etc/mysql/conf.d
```

���ʵ��Ķ˿�

