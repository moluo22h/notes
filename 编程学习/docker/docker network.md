# Docker Network

dockers network ls

## 单机

Bridge Network

Host Network：共享主机的ip

None Network：没有ip

## 多机

安装分布式储存：etcd

* 下载etcd-v3.0.12-lunux-amd64/
* cd etcd-v3.0.12-lunux-amd64/
* nohup ./etcd --name docker-node2 --initial-advertise-...
* ./etcdctl cluster-health
* 重启docker：service docker stop&service

docker network create -d overlay demo





## Docker-Machine 

* dockers-machine create

