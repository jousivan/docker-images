#!/bin/bash -xe
#
# WebServer-Servicos
#
docker build -t servicos-jboss:7 .
docker tag servicos-jboss:7 servicos-jboss:latest
docker push servicos-jboss:7
docker push servicos-jboss:latest