#!/bin/bash -xe
#
# CAIXA-SISAG-dnsserver
#
docker build -t ajss/dnsserver:v1 .
docker tag ajss/dnsserver:v1 ajss/dnsserver:latest
docker push ajss/dnsserver:v1
docker push ajss/dnsserver:latest