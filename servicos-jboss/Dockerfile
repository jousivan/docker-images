FROM jboss/base-jdk:8

# Rótulos
LABEL name="jboss" \
  summary="Image to run Jboss" \
  maintainer="Antonio Jousivan<ajssti@gmail.com>" \
  description="Servicos=Jboss Web"

# TERM
ENV TERM=xterm

# Variáveis de Banco de Dados.

ENV BANCO_DADOS_HOST=
ENV BANCO_DADOS_PORTA_DB=
ENV BANCO_DADOS_HOST_IP_FIXO_SERVICOS=
ENV SERVICOS_HOME=/home/servicos

RUN echo '### WORKDIR via SSH ###' >> /root/.bash_profile && \
  echo 'cd /home/servicos' >> /root/.bash_profile && \
  echo 'source /home/servicos/.bash_profile' >> /root/.bash_profile && \
  echo 'clear' >> /root/.bash_profile && \
  echo '### http://patorjk.com/software/taag/' >> /root/.bash_profile && \
  echo '### Font: Cybermedium' >> /root/.bash_profile && \
  echo 'cat /home/servicos/conf/boas_vindas.msg' >> /root/.bash_profile

RUN mkdir -p ${SERVICOS_HOME}/bin  && \
  mkdir -p ${SERVICOS_HOME}/conf

COPY ambiente/bin ${SERVICOS_HOME}/bin
COPY ambiente/conf ${SERVICOS_HOME}/conf
COPY ambiente/.bash_profile ${SERVICOS_HOME}/.bash_profile
COPY jboss/org ${JBOSS_HOME}/modules/org
COPY jboss/bin/standalone.conf /opt/jboss-eap-7.1/bin/

#Criando as instâncias dos serviços
RUN cp -Rfv $JBOSS_HOME/standalone $JBOSS_HOME/rest

COPY jboss/rest/standalone.xml $JBOSS_HOME/rest/configuration/standalone.xml
COPY jboss/rest/configuracoes.properties $JBOSS_HOME/rest/configuration/configuracoes.properties

RUN chmod +x ${SERVICOS_HOME}/bin/*.sh && \
    chmod 755 $SERVICOS_HOME/PacotesWebServiceRest

WORKDIR ${SERVICOS_HOME}

EXPOSE 20 21 22 4447 8009 8080 8443 8787 9704 \
       19990 18009 18080 18443 18787 19704 19990 \
       29990 28009 28080 28443 28787 29704 29990 \
       39990 38009 38080 38443 38787 39704 39990

COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
