#!/bin/bash
#
# Script para verificar se o sistema esta em execucao.
#
servico=`ps -ef | grep java | grep -E --color "PID|$1"`
echo ""
if [ -z "$servico" ]; then
		tput setaf 1
        echo "O serviço $1 não está em execução."
else
        tput setaf 2
        echo "O serviço $1 está em execução."
fi
tput sgr0
echo ""
echo $servico | grep -E --color "PID|$1"