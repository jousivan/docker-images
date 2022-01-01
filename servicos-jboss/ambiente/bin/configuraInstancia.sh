#!/bin/bash -x

#
# Criando diretórios de logs
#

mkdir -p $JBOSS_HOME/rest/log

#
# Criando liks simbólicos.
#
mkdir -p $SERVICOS_HOME/logs

ln -s $JBOSS_HOME/rest/log/rest.log $SERVICOS_HOME/logs/rest.log
ln -s $JBOSS_HOME/rest $SERVICOS_HOME/jboss-deploy-rest

ln -s $SERVICOS_HOME/bin/jboss.sh $SERVICOS_HOME/jboss.sh

# JBOSS - Banco de Dados
#
sed -i 's/${env.BANCO_DADOS_HOST}/'"$BANCO_DADOS_HOST"'/g' $JBOSS_HOME/assinador/configuration/standalone.xml
sed -i 's/${env.BANCO_DADOS_PORTA}/'"$BANCO_DADOS_PORTA"'/g' $JBOSS_HOME/assinador/configuration/standalone.xml
sed -i 's/${env.BANCO_DADOS_SID_ASSINADOR}/'"$BANCO_DADOS_SID"'/g' $JBOSS_HOME/assinador/configuration/standalone.xml
sed -i 's/${env.BANCO_DADOS_USUARIO_ASSINADOR}/'"$BANCO_DADOS_USUARIO"'/g' $JBOSS_HOME/assinador/configuration/standalone.xml
sed -i 's/${env.BANCO_DADOS_SENHA_ASSINADOR}/'"$BANCO_DADOS_SENHA"'/g' $JBOSS_HOME/assinador/configuration/standalone.xml

#
# Removendo o bloco do configuraInstancia do arquivo /etc/supervisord.conf
#
sed -i '23,30d' /etc/supervisord.conf

# Alteração o hosts do container para os servicos funcionarem
echo "$BANCO_DADOS_HOST_IP_FIXO_SERVICOS       $BANCO_DADOS_HOST" >> /etc/hosts

#
# Removendo o arquivo de configuração e inicialização da instância.
#
rm -f ${SERVICOS_HOME}/bin/configuraInstancia.sh

# Iniciando os servicos
sleep 2
sh $SERVICOS_HOME/bin/jboss.sh rest start

#Adicionando serviços para o supervisor gerenciar
cat $SERVICOS_HOME/bin/blocoSupervisorJBoss.txt >> /etc/supervisord.conf
# Pausa para que o supervisor entenda que ele executou
sleep 2

exit 0
