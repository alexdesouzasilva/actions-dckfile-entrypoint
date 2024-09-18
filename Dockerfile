# Container image that runs your code
#FROM alpine:3.10
FROM openjdk:11-jdk-slim

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Instalar dependências necessárias: wget, unzip
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*
    
# Baixar e instalar o Sonar Scanner
RUN wget $SONAR_SCANNER_CLI_URL -O /tmp/sonar-scanner.zip && \
unzip /tmp/sonar-scanner.zip -d /opt && \
mv /opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux $SONAR_SCANNER_HOME && \
rm /tmp/sonar-scanner.zip

ENV PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

# Configurar o Sonar Scanner para usar o Java instalado na imagem base
ENV SONAR_SCANNER_OPTS="-server"

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
