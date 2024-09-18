#!/bin/sh 

set -e

projectKey=$1
sources=$2
url=$3
login=$4
version=$5
binaries=$6

sonar-scanner \
            -Dsonar.projectKey=$projectKey \
            -Dsonar.sources=$sources \
            -Dsonar.host.url=$url \
            -Dsonar.login=$login \
            -Dsonar.version=$version \
            -Dsonar.java.binaries=$binaries