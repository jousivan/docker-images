FROM dokken/ubuntu-16.04


# Rótulos de documentação
LABEL name="ajss/firebird" \
    maintainer="Antonio Jousivan <ajssti@gmail.com>" \
    summary="Imagem para execução do Firebird" \
    description="sudo docker run --name <NOME_CONTAINER> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL>" \
    br.com.ajss.firebird-usuario="SYSDBA ou sysdba" \
    br.com.ajss.firebird-senha="masterkey"

ENV DEBIAN_FRONTEND noninteractive

RUN /root/fb && cd /root/fb

COPY conf/FirebirdCS-2.5.5.26952-0.amd64.tar.gz /root/fb

RUN apt update && apt install -y wget libtommath-dev libicu-dev && \
    tar -xzvpf FirebirdCS-2.5.5.26952-0.amd64.tar.gz && cd Firebird* && ./install.sh -silent && \
    echo "DatabaseAccess = Full" >>/opt/firebird/firebird.conf && \
    echo "ServerMode = SuperClassic" >>/opt/firebird/firebird.conf && \
    echo "WireCrypt = Enabled" >>/opt/firebird/firebird.conf && \
    echo "AuthServer = Legacy_Auth, Srp, Win_Sspi " >>/opt/firebird/firebird.conf && \
    echo "UserManager = Legacy_UserManager, Srp" >>/opt/firebird/firebird.conf && \
	mkdir -p /opt/firebird/bd/ && \
	/opt/firebird/bin/gsec -user sysdba -password `cat /opt/firebird/SYSDBA\.password | grep ISC_PASSWD | cut -d= -f2` -modify sysdba -pw masterkey 

WORKDIR /opt/firebird/bin

VOLUME [ "/opt/firebird/bd" ]

EXPOSE 3050

ENTRYPOINT [ "./fbguard" ]