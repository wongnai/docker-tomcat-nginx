#!/bin/bash

set -e

tag=8.5.20-jdk8

touch tomcat/bin/docker-entrypoint.sh

docker build . -t wongnai/tomcat-nginx:${tag}

# cd test
# docker build . -t wongnai/tomcat-nginx-test:latest
# docker run --rm -it wongnai/tomcat-nginx-test:latest with-nginx

#docker push wongnai/tomcat-nginx:${tag}
