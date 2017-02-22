#!/bin/bash

set -e

touch tomcat/bin/docker-entrypoint.sh

docker build . -t wongnai/tomcat-nginx:8.5.5-jre8-wm

# cd test
# docker build . -t wongnai/tomcat-nginx-test:latest
# docker run --rm -it wongnai/tomcat-nginx-test:latest with-nginx

docker push wongnai/tomcat-nginx:8.5.5-jre8-wm