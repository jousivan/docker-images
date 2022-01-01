#!/bin/sh
# Script para realizar a limpeza de arquivos.

function liberaEspacoDisco() {

    echo "Apagando os logs Simulador Rest"
	cd $JBOSS_HOME/rest/log
	find -mtime +0 -type f -print -exec rm -vf {} \;
}

# Laço de repetição
loop=true
while [ $loop == true ]
do
    echo "Iniciando o loop da limpeza de logs..." && sleep 10
    liberaEspacoDisco
    sleep 3600
done 