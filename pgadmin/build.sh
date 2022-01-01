#!/bin/bash -xe
#
# pgAdmin4
#
docker build -t ajss/pgadmin:v1 .
docker tag ajss/pgadmin:v1 ajss/pgadmin:latest
docker push ajss/pgadmin:v1
docker push ajss/pgadmin:latest