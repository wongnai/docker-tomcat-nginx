#!/bin/sh

checkPid () {
    pidof $1 > /dev/null
    return $?
}

catalina.sh start

if [ -f /usr/local/tomcat/bin/warmup.sh ]; then
  echo "Running warmup script..."
  . /usr/local/tomcat/bin/warmup.sh
else
  echo "No warmup script found. skipping...."
fi

if [ "$1" = "with-nginx" ]; then
  nginx -g "daemon on;"
fi

while checkPid java; do sleep 5; done
