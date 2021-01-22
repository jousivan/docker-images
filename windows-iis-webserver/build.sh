#!/bin/bash -xe
#
# Imagem Windows com Servidor IIS e SSH Server
#
docker build -t registry-host:5000/ajss/images/windows:iis .
docker tag registry-host:5000/ajss/images/windows:iis registry-host:5000/ajss/images/windows-iis:latest
docker push registry-host:5000/ajss/images/windows:iis
docker push registry-host:5000/ajss/images/windows:latest