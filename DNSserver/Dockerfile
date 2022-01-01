FROM sameersbn/bind:latest

# Rótulos de documentação
LABEL name="dnsserver" \
    maintainer="Antonio Jousivan <ajssti@gmail.com" \
    summary="Imagem para execução de dnsserver." \
    description="sudo docker run --name <NOME_CONTAINER> --dns=<IP_DNS> --publish=<DNS_ENTRY_POINT> --publish=<DNS_WEBADMIN> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL>" 

ENV ROOT_USER_SSH="root"
ENV ROOT_PASSWORD=123456

RUN apt clean -y && \
    apt update -y && apt install -y \
    vim \
    tar \
    zip \
    sed \
    curl \
    less \
    nano \
    wget \
    sudo \
    whois \
    unzip \
    vsftpd \
    locales \
    net-tools \
    apt-utils \
    p7zip-full \
    supervisor \
    traceroute \
    iputils-ping \
    openssh-server \
    openssh-client \
	libcurl4-openssl-dev \
    software-properties-common && \
	apt-get autoclean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

# Definindo localidade.
RUN sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    # Criando diretório de trabalho do SSH.
    mkdir -p /var/run/sshd && \
    # Configurando o terminal.
    echo 'alias ls="ls -a --color=auto"' >> /etc/bash.bashrc && \
    echo 'alias ll="ls -la --color=auto"' >> /etc/bash.bashrc && \
    sudo sed -i 's/env_reset/env_reset,pwfeedback/g' /etc/sudoers && \
    # Definindo Timezone.
    echo 'America/Sao_Paulo' > /etc/timezone

RUN sed -i 's/\/etc\/init.d\/webmin start/\/etc\/init.d\/webmin start \n \/etc\/init.d\/ssh start/g' /sbin/entrypoint.sh

EXPOSE  20 21 22 80 443 53 1000

