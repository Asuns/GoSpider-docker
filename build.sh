#!/bin/bash
#sudo rm -rf $HOME/mydocker
sudo mkdir -p $HOME/mydocker/redis/data
sudo mkdir -p $HOME/mydocker/redis/conf
sudo mkdir -p $HOME/mydocker/mysql/data
sudo mkdir -p $HOME/mydocker/mysql/conf
sudo mkdir -p $HOME/mydocker/go
sudo cp my.cnf $HOME/mydocker/mysql/conf/my.cnf
sudo cp redis.conf $HOME/mydocker/redis/conf/redis.conf
#sudo mkdir -p $HOME/mydocker/go/src/github.com/hunterhug
#cd $HOME/mydocker/go/src/github.com/hunterhug
#sudo git clone https://github.com/hunterhug/GoSpider
#cd -
sudo docker-compose stop
sudo docker-compose rm -f
sudo docker-compose up -d
#sudo chmod 775 -R $HOME/mydocker
sudo docker pull golang:1.8
sudo docker run --rm --net=host -it -v $HOME/mydocker/go:/go --name mygolang golang:1.8 /bin/bash
