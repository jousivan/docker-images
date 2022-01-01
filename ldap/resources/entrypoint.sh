#!/bin/bash

if [ ! -f /.containerConfigurado ]; then

	if [ ! -n ${SLAPD_PASSWORD} ]; then
		echo "Variável SLAPD_PASSWORD não informada ou nula. Será adotado uma senha aleatório..."
	fi;

	PW=$(openssl rand -base64 16;)
	SLAPD_PASSWORD="${SLAPD_PASSWORD:-$PW}"
	export SLAPD_PASSWORD

	echo "Iniciando o slapd..."
	/etc/init.d/slapd start >/dev/null

	echo "Alterando a senha..."
	slappasswd -s ${SLAPD_PASSWORD} >> .slappasswd

	echo "LDAP em execução..."

	echo "Ajustando o arquivo /etc/openldap/slapd.conf"
	echo "
	#######################################################################
	####################### Database Definitions ##########################
	#######################################################################

	database		bdb
	suffix			\"o=company\"
	checkpoint		1024 15
	rootdn			\"cn=Manager,o=company\"
	rootpw			`cat .slappasswd`

	# The database directory MUST exist prior to running slapd AND
	# should only be accessible by the slapd and slap tools.
	# Mode 700 recommended.
	directory       /var/lib/ldap

	" >> /etc/openldap/slapd.conf

	echo "Parando o slapad..."
	/etc/init.d/slapd stop >/dev/null


	echo "Indexando a base dados..."
	slapindex -v >/dev/null

	echo "Definindo as permissões no diretório /var/lib/ldap/"
	chown ldap.ldap /var/lib/ldap/*

	echo "Iniciando o slapd..."
	/etc/init.d/slapd start >/dev/null

	touch /.containerConfigurado

else
	echo "Iniciando o slapd..."
	/etc/init.d/slapd restart >/dev/null
fi

exit 0