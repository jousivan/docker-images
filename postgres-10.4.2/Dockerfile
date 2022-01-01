FROM postgres:10-bullseye

# Rótulos de documentação
LABEL name="cxa/postgres-10.4.2" \
    maintainer="Antonio Jousivan <ajssti@gmail.com>" \
    summary="Imagem para execução do PostgreSQL-10" \
    description="sudo docker run --name <NOME_CONTAINER> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL>" \
    br.com.ajss-default="postgres" \
    br.com.ajss.database-usuario-default="postgres" \
    br.com.ajss.database-senha-default="postgres" \
    br.com.ajss.ssh-usuario-default="root" \
    br.com.ajss.ssh-senha-default="password"

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres

RUN chmod 777 -R /docker-entrypoint-initdb.d/

COPY /conf/supervisord.conf /etc/supervisord.conf
COPY /conf/docker-entrypoint.sh /docker-entrypoint.sh
COPY /conf/root/*.sh /root/
COPY /conf/bin/*.sh /usr/lib/postgresql/10/bin/
RUN chmod +x /docker-entrypoint.sh && \
    chmod +x /root/*.sh &&
    

EXPOSE 22 5432

CMD ["/usr/bin/supervisord"]