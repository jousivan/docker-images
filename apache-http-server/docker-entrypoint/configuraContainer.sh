#!/bin/bash -e
#
# Verifica se container já está configurado.
#
tput sgr0
if [ ! -f /docker-entrypoint/.containerConfigurado ]; then
	tput setaf 3 &&	echo "############################" && tput sgr0
	tput setaf 3 &&	echo "# CONFIGURANDO CONTAINER!  #" && tput sgr0
	tput setaf 3 &&	echo "############################" && tput sgr0

	#
	# Copiando o binário do apachectl
	#
	cp /opt/httpd-2.2.31/support/apachectl /etc/init.d/apachectl
	
	
	#
	# Criando links simbólicos.
	#
	ln -s /usr/local/apache2/logs /home/apache/logs
	ln -s /usr/local/apache2/ /home/apache/instancia-apache

	#
	# Definindo permissões.
	#
	chmod +x /home/apache/bin/*.sh
	chmod 744 /etc/init.d/apachectl
	chown apache.apache-adm /usr/local/apache2/modules/mod_jk.so

	#
	# Configuração de mensagem para login via root.
	#
	echo '### WORKDIR via SSH ###' >> /root/.bash_profile
	echo 'cd /home/apache' >> /root/.bash_profile
	echo 'source /home/apache/.bash_profile' >> /root/.bash_profile
	echo 'clear' >> /root/.bash_profile
	echo '### http://patorjk.com/software/taag/' >> /root/.bash_profile
	echo '### Font: Cybermedium' >> /root/.bash_profile
	echo '' >> /root/.bash_profile
	echo 'export LANG=pt_BR.UTF-8' >> /root/.bash_profile
	echo 'export LC_ALL=pt_BR.UTF-8' >> /root/.bash_profile
	echo 'cat /home/apache/conf/boas_vindas.msg' >> /root/.bash_profile
	echo 'nameserver $DNS_SERVER' >> /etc/resolv.conf
	#sed -i 's/${env.DNS_SERVER}/'"$DNS_SERVER"'/g' /etc/resolv.conf
	#
	# Criando o arquivo de controle de configuração.
	#
    touch /docker-entrypoint/.containerConfigurado
fi

tput setaf 2 &&	echo "###########################" && tput sgr0
tput setaf 2 &&	echo "# CONTAINER CONFIGURADO!  #" && tput sgr0
tput setaf 2 &&	echo "###########################" && tput sgr0

exit 0