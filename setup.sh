#!/bin/bash
service mysql start
mysql < /opt/futureloan.sql
/opt/apache-tomcat-8.5.59/bin/startup.sh
tail -f /opt/apache-tomcat-8.5.59/logs/catalina.out
