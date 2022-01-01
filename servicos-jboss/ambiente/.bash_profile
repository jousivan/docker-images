# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

### Configuracoes da Variavel de Servicos ###
export SERVICOS_HOME=/home/servicos
export PATH=$SERVICOS_HOME/bin:$PATH

### Configuracoes da Variavel do Jboss ###
export JBOSS_HOME=/opt/jboss-eap-7.1
export PATH=$JBOSS_HOME/bin:$PATH

### Configuracoes da Variavel do Java ###
export JAVA_HOME=/opt/jdk1.8.0_172
export PATH=$JAVA_HOME/bin:$PATH

export APP_NAME=SERVICOS

export PATH=$PATH:$HOME/bin:$PATH