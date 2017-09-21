#!/bin/sh

checkPid () {
    pidof $1 > /dev/null
    return $?
}

catalina.sh $@

if [ "${WARMUP:-1}" = "1" ]; then
  if [ -f /usr/local/tomcat/bin/warmup.sh ]; then
    echo "Running warmup script..."
    . /usr/local/tomcat/bin/warmup.sh
  else
    echo "No warmup script found. skipping...."
  fi
fi

if [ "${START_NGINX:-0}" = "1" ]; then
  nginx -g "daemon on;"
fi

while checkPid java; do sleep 5; done
