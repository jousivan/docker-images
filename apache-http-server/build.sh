#!/bin/bash -xe
#
# Apache-HTTP-Server
#
docker build -t ajss/apache-http-server:v1 .
docker tag ajss/apache-http-server:v1 ajss/apache-http-server:latest
docker push ajss/apache-http-server:v1
docker push ajss/apache-http-server:latest