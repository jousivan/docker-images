FROM centos

# Rótulos de documentação
LABEL name="ajss/apache-http-server" \
    maintainer="Antonio Jousivan <ajssti@gmail.com>" \
    summary="Imagem para execução do Apache-HTTP-Server" \
    description="sudo docker run --name <NOME_CONTAINER> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL>" \
	la.foton.apache-user="apache" \
	la.foton.apache-password="apache" \
	la.foton.apache-ssh-user="apache" \
	la.foton.apache-ssh-password="apache"

# Instalando as dependências de compilação.
RUN yum install -y gcc zlib-devel openssl-devel make rotatelogs

RUN groupadd apache-adm && \
	useradd -d /home/apache -g apache-adm -k /etc/skel -m -s /bin/bash apache && \
    echo "apache:apache" | chpasswd

COPY apache/httpd-2.2.31.tar.gz /opt/
COPY apache/tomcat-connectors-1.2.48.zip /opt/

# Instalação do Apache HTTP Server.
RUN tar -zxvf /opt/httpd-2.2.31.tar.gz -C /opt/ && \
	# Realizando o checksum
	grep $(md5sum /opt/httpd-2.2.31.tar.gz) /opt/httpd-2.2.31.tar.gz.md5 && \
	# Removendo Apache HTTP Server.
	rm -f /opt/httpd-2.2.31.tar.gz /opt/httpd-2.2.31.tar.gz.md5 && \
	# Extraindo o arquivo ZIP
	unzip /opt/tomcat-connectors-1.2.48.zip -d /opt/ && \
	# Removendo o arquivo ZIP
	rm -f /opt/tomcat-connectors-1.2.27.zip && \
	# Extraindo o módulo do JK
	tar -zxvf /opt/tomcat-connectors-1.2.27-src.tar.gz -C /opt/ && \
	# Realizando o checksum
	grep $(md5sum /opt/tomcat-connectors-1.2.27-src.tar.gz) /opt/tomcat-connectors-1.2.27-src.tar.gz.md5 && \
	# Removendo o módulo do JK.
	rm -f /opt/tomcat-connectors-1.2.27-src.tar.gz /opt/tomcat-connectors-1.2.27-src.tar.gz.md5

# Realizando a configuração do pacote antes da compilação.
RUN cd /opt/httpd-2.2.31 && \
	./configure --enable-deflate --enable-vhost-alias --enable-ssl --enable-so --enable-module=so && \
	grep 'configure: exit' config.log && \
	make && \
	make install && \
	cd /opt/tomcat-connectors-1.2.27-src/native && \
	./configure --with-apxs=/usr/local/apache2/bin/apxs && \
	grep 'configure: exit' config.log && \
	make && \
	make install

#
# Copiando arquivos de ambiente.
#
COPY ambiente/bin /home/apache/bin
RUN chmod +x /home/apache/bin/*

COPY ambiente/conf /home/apache/conf

#
# Copiando arquivos para o Apache.
#
COPY apache/ssl.crt /usr/local/apache2/ssl.crt
COPY apache/ssl.key /usr/local/apache2/ssl.key
COPY apache/conf/ssl /usr/local/apache2/conf/ssl
COPY apache/modules/* /usr/local/apache2/modules/
COPY apache/conf/vhosts /usr/local/apache2/conf/vhosts
COPY apache/conf/extra/* /usr/local/apache2/conf/extra/
COPY apache/conf/mime.types /usr/local/apache2/conf/mime.types
COPY apache/conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY apache/conf/charset.conv /usr/local/apache2/conf/charset.conv
COPY apache/conf/workers.properties /usr/local/apache2/conf/workers.properties

WORKDIR /home/apache

EXPOSE 22 80 443

COPY docker-entrypoint /docker-entrypoint

RUN chmod +x /docker-entrypoint/*

COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]