#!/bin/sh

checkPid () {
    pidof $1 > /dev/null
    return $?
}
 
argWarmUp=1
argNginx=0

for arg in "$@"
do  
  if [ "${arg}" = "with-nginx" ]; then
    argNginx=1
  elif [ "${arg}" = "nowarmup" ]; then
    argWarmUp=0
  fi 
done

catalina.sh ${CATALINA_COMMAND:start}

if [ "${argWarmUp}" = "1" ]; then
  if [ -f /usr/local/tomcat/bin/warmup.sh ]; then
    echo "Running warmup script..."
    . /usr/local/tomcat/bin/warmup.sh
  else
    echo "No warmup script found. skipping...."
  fi
fi

if [ "${argNginx}" = "1"]; then
  nginx -g "daemon on;"
fi

while checkPid java; do sleep 5; done
