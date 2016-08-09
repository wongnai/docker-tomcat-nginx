#!/bin/sh

if [ "$1" = "with-nginx" ]; then
  nginx -g "daemon on;"
fi

exec catalina.sh run