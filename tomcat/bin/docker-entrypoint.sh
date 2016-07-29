#!/bin/sh

if [[ "$1" = "with-nginx" ]]; then
  nginx -g 
fi

catalina.sh run