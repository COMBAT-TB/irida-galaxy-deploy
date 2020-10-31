#!/bin/sh

start-stop-daemon --pidfile /var/run/nginx --exec /usr/sbin/nginx -S -- -g 'daemon on; master_process on;'
/usr/local/tomcat/bin/catalina.sh run
