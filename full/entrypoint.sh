#!/bin/bash
echo "Starting software components..."
service mosquitto start
service mongodb start
service influxdb start
bash /opt/tomcat/bin/catalina.sh run