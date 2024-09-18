#!/bin/sh 

set -e

projectKey=$1
sources=$2
url=$3
login=$4
version=$5
binaries=$6

sudo apt-get update
sudo apt-get install -y unzip
wget -O sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip sonar-scanner.zip
sudo mv sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

sonar-scanner \
    -Dsonar.projectKey=$projectKey \
    -Dsonar.sources=$sources \
    -Dsonar.host.url=$url \
    -Dsonar.login=$login \
    -Dsonar.version=$version \
    -Dsonar.java.binaries=$binaries