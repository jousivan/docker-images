#!/bin/bash -e

startContainer() {

  CONTADOR=1
  MAX_CONTADOR=6
  while [  $CONTADOR -lt $MAX_CONTADOR ]; do
    if [ -f /docker-entrypoint/.containerConfigurado ]; then
      let CONTADOR=$MAX_CONTADOR;
      #
      # Iniciando o Apache Server
      #
	  rm -f /usr/local/apache2/logs/ssl_mutex
      /etc/init.d/apachectl start
      
      CONTADOR_APACHE=1
      MAX_CONTADOR_APACHE=6
      while [  $CONTADOR_APACHE -lt $MAX_CONTADOR_APACHE ]; do
        export APACHE_STARTED=`grep -E 'mod_jk.*.initialized' /usr/local/apache2/logs/* | wc -l`
        if [ $APACHE_STARTED -gt 0 ]; then
          let CONTADOR_APACHE=$MAX_CONTADOR_APACHE;
          tput setaf 2 && echo "#######################################" && tput sgr0
          tput setaf 2 && echo "# Apache Server iniciado com sucesso! #" && tput sgr0
          tput setaf 2 && echo "#######################################" && tput sgr0
          exit 0
        elif [ $CONTADOR_APACHE -eq 10 ]; then
          let CONTADOR_APACHE=$MAX_CONTADOR_APACHE;
          tput setaf 1 && echo "############################################" && tput sgr0
          tput setaf 1 && echo "# Falha na inicialização do Apache Server! #" && tput sgr0
          tput setaf 1 && echo "############################################" && tput sgr0
          exit 0
        else
          let CONTADOR_APACHE=CONTADOR_APACHE+1;
          tput setaf 3 && echo "########################################################" && tput sgr0
          tput setaf 3 && echo "# Apache Server em processo de inicialização. Aguarde! #" && tput sgr0
          tput setaf 3 && echo "########################################################" && tput sgr0
        fi
      done
    fi
  done
}

start () {

  CONTADOR=1
  MAX_CONTADOR=6
  while [  $CONTADOR -lt $MAX_CONTADOR ]; do
    if [ -f /docker-entrypoint/.containerConfigurado ]; then
      let CONTADOR=$MAX_CONTADOR;
      #
      # Iniciando o Apache Server
      #
      /etc/init.d/apachectl start

      CONTADOR_APACHE=1
      MAX_CONTADOR_APACHE=6
      while [  $CONTADOR_APACHE -lt $MAX_CONTADOR_APACHE ]; do
        export APACHE_STARTED=`grep -E 'mod_jk.*.initialized' /usr/local/apache2/logs/* | wc -l`
        if [ $APACHE_STARTED -gt 0 ]; then
          let CONTADOR_APACHE=$MAX_CONTADOR_APACHE;
          tput setaf 2 && echo "#######################################" && tput sgr0
          tput setaf 2 && echo "# Apache Server iniciado com sucesso! #" && tput sgr0
          tput setaf 2 && echo "#######################################" && tput sgr0
          exit 0
        elif [ $CONTADOR_APACHE -eq 10 ]; then
          let CONTADOR_APACHE=$MAX_CONTADOR_APACHE;
          tput setaf 1 && echo "############################################" && tput sgr0
          tput setaf 1 && echo "# Falha na inicialização do Apache Server! #" && tput sgr0
          tput setaf 1 && echo "############################################" && tput sgr0
          exit 0
        else
          let CONTADOR_APACHE=CONTADOR_APACHE+1;
          tput setaf 3 && echo "########################################################" && tput sgr0
          tput setaf 3 && echo "# Apache Server em processo de inicialização. Aguarde! #" && tput sgr0
          tput setaf 3 && echo "########################################################" && tput sgr0
        fi
      done
    fi
  done
}

stop() {

  if kill -9 $(ps -eo pid,cmd | grep httpd | grep -v grep | cut -c1-6) &>/dev/null
  then
    tput setaf 3 && echo "#############################" && tput sgr0
    tput setaf 3 && echo "# Apache Server finalizado! #" && tput sgr0
    tput setaf 3 && echo "#############################" && tput sgr0
  else
    tput setaf 1 && echo "#######################################" && tput sgr0
    tput setaf 1 && echo "# Apache Server não está em execução! #" && tput sgr0
    tput setaf 1 && echo "#######################################" && tput sgr0
  fi;
}

status() {
  
  servico=`ps -ef | grep httpd | grep -E --color 'PID|httpd'`
  echo ""
  if [ -z "$servico" ]; then
      tput setaf 1
      echo "#######################################"
      echo "# Apache Server não está em execução! #"
      echo "#######################################"
  else
      tput setaf 2
      echo "#######################################"
      echo "# Apache Server está em execução!     #"
      echo "#######################################"
  fi
  tput sgr0
  echo ""
}

case "$1" in
  startContainer)
    startContainer
        ;;
  start)
    start
        ;;
  status)
    status
        ;;
  restart)
    stop
    echo ""
    echo "Parando o Apache Server!"
    echo ""
    sleep 5s
    echo ""
    echo "Iniciando o Apache Server!"
    echo ""
    start
        ;;
  stop)
    stop
        ;;
  *)
  tput setaf 3
  echo "Utilize $0 {start|stop|status|restart}"
  tput setaf 9
  exit
esac
