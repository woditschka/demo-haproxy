#!/usr/bin/env bash

docker rm -f demo-haproxy  
docker rm -f demo-haproxy-nginx-1  
docker rm -f demo-haproxy-nginx-2  

cd haproxy
docker build -t demo-haproxy .
cd ..

cd nginx 
docker build -t demo-haproxy-nginx .
# docker run --rm -it --name haproxy-syntax-check demo-haproxy haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
cd ..

docker run --rm -d -p 8081:80 --name demo-haproxy-nginx-1 demo-haproxy-nginx
docker run --rm -d -p 8082:80 --name demo-haproxy-nginx-2 demo-haproxy-nginx
docker run -d -p80:80 --link demo-haproxy-nginx-1 --link demo-haproxy-nginx-2 --name demo-haproxy demo-haproxy
