#!/bin/bash -xe
#
# CAIXA-LDAP
#
docker build -t dockerrepo.foton.la:5000/cxa/ldap:v5 .
docker tag dockerrepo.foton.la:5000/cxa/ldap:v5 dockerrepo.foton.la:5000/cxa/ldap:latest
docker push dockerrepo.foton.la:5000/cxa/ldap:v5
docker push dockerrepo.foton.la:5000/cxa/ldap:latest