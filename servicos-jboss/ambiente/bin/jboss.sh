export SERVICOS_HOME=/home/servicos
export APP_NAME=SERVICOS
export DEBUG_PORT=8787
export JAVA_OPTS="
  -server
  -Xms64m
  -Xmx256m
  -Dfile.encoding=UTF-8
  -Duser.language=pt
  -Duser.country=BR
  -Djava.net.preferIPv4Stack=true
  -Djava.net.preferIPv4Addresses=true
  "

source $SERVICOS_HOME/.bash_profile
servico=$1

start() {
  setup
  echo "Iniciando: $APP_NAME - $servico"  
  #$JBOSS_HOME/bin/standalone.sh -bmanagement 0.0.0.0 -b 0.0.0.0 > $SERVICOS_HOME/log/server.log 2>&1 &
  $JBOSS_HOME/bin/standalone.sh -bmanagement 0.0.0.0 -b 0.0.0.0 --debug ${DEBUG_PORT} -Djboss.server.base.dir=$JBOSS_HOME/${servico}/ > $JBOSS_HOME/${servico}/log/${servico}.log 2>&1 &
}

setup() {
  case $servico in
    rest)
        DEBUG_PORT=38787
        JAVA_OPTS="$JAVA_OPTS -Dprog.name=$APP_NAME-$servico -agentlib:jdwp=transport=dt_socket,address=${DEBUG_PORT},server=y,suspend=n"
    ;;
    *)
      echo "Instancia inválida. Use jboss.sh rest} {start|stop|status}"
      exit 1
    ;;
  esac
}

stop() {
  setup
  if kill -9 $(ps -eo pid,cmd | grep .name=$APP_NAME-$servico | grep -v grep | cut -c1-6) &>/dev/null
  then
    echo "Parando: $APP_NAME-$servico"
  else
     echo "$APP_NAME-$servico não está em execução."
  fi;
}

status() {
  $SERVICOS_HOME/bin/./statusSistema.sh $servico
}

case "$2" in
  start)
    start
        ;;
  stop)
    stop
        ;;
  status)
    status
        ;;
  restart)
    stop
        echo Stopping ...
        sleep 60
        echo Starting ...
    start
        ;;
  *)
  echo "Utilize $0 {start|stop|status|restart}"
  exit
esac
