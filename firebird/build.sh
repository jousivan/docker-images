#!/bin/bash -xe
#
# Firebird
#
docker build -t ajss/firebird:v1 .
docker tag ajss/firebird:v1 ajss/firebird:latest
docker push ajss/firebird:v1
docker push ajss/firebird:v1:latest