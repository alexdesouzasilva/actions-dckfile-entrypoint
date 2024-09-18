# Usando uma imagem base (pode ser a que preferir, por exemplo, openjdk para Java projects)
FROM openjdk:11-jdk-slim

# Definir a versão do Sonar Scanner que você deseja instalar
ENV SONAR_SCANNER_VERSION=4.8.0.2856

# Definir o diretório onde o Sonar Scanner será instalado
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner

# Definir a URL do pacote do Sonar Scanner
ENV SONAR_SCANNER_CLI_URL="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip"

# Instalar dependências necessárias: wget, unzip
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Baixar e instalar o Sonar Scanner
RUN wget $SONAR_SCANNER_CLI_URL -O /tmp/sonar-scanner.zip && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    mv /opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux $SONAR_SCANNER_HOME && \
    rm /tmp/sonar-scanner.zip

# Adicionar o Sonar Scanner ao PATH
ENV PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

# Configurar o Sonar Scanner para usar o Java instalado na imagem base
ENV SONAR_SCANNER_OPTS="-server"

# Exemplo de comando que pode ser executado automaticamente ao iniciar o contêiner (opcional)
CMD ["sonar-scanner", "-h"]
