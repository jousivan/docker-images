FROM dockerrepo.foton.la:5000/ftn/ldap:latest

MAINTAINER Marcos Oliveira Soares <marcos.soares@foton.la>

# Rótulos de documentação
LABEL name="cxa/ldap" \
    maintainer="Marcos Oliveira Soares <marcos.soares@foton.la>" \
    summary="Imagem para execução do LDAP." \
    description="sudo docker run --name <NOME_CONTAINER> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL> -P dockerrepo.foton.la:5000/<TAG>"

ENV SLAPD_PASSWORD=secret

RUN mv /etc/openldap/schema /etc/openldap/schema_original && \
	mv /etc/openldap/slapd.d /etc/openldap/slapd.d_original && \
	mv /etc/openldap/ldap.conf /etc/openldap/ldap.conf_original
	
COPY resources/schema /etc/openldap/schema
COPY resources/slapd.d /etc/openldap/slapd.d
COPY resources/slapd.conf /etc/openldap/slapd.conf
COPY resources/supervisord.conf /etc/supervisord.conf
COPY resources/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY resources/BaseLdapCaixa.ldif /etc/openldap/BaseLdapCaixa.ldif

CMD ["/usr/bin/supervisord"]