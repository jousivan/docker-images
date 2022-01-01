#!/bin/bash -xe
#
# PostgreSQL 10.4.2
#
docker build -t ajss/postgres-10.4.2:v1 .
docker tag ajss/postgres-10.4.2:v1 ajss/postgres-10.4.2:latest
docker push ajss/postgres-10.4.2:v1
docker push ajss/postgres-10.4.2:latest