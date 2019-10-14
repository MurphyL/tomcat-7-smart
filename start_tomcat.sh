#!/bin/sh

catalina.sh start

tail -fn 100 $CATALINA_HOME/logs/catalina.out
