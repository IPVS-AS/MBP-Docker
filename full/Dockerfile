# ***************** Init *****************
# ****************************************

# Base image
FROM ubuntu:19.04

# Meta data
LABEL maintainer="as@ipvs.uni-stuttgart.de"
LABEL org.label-schema.name="Multi-purpose Binding and Provisioning Platform"
LABEL org.label-schema.description="A Multi-purpose Binding and Provisioning Platform (MBP) for Internet of Things devices"
LABEL org.label-schema.vcs-url="https://github.com/IPVS-AS/MBP-Docker"

# Environment variables
ENV TOMCAT_VERSION 8.5.43
ENV INFLUXDB_VERSION 1.7.7
ENV MBP_HOME /opt/mbp
ENV MBP_BRANCH master


# ************* Preparations *************
# ****************************************

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set config to non-interactive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Update software repository
RUN apt-get update

# Install required packages (apt-utils, curl, gnupg2, wget)
RUN apt-get install -qy dialog apt-utils
RUN apt-get install -qy --no-install-recommends apt-utils
RUN apt-get install -qy curl
RUN apt-get install -qy gnupg2
RUN apt-get install -qy wget

# Install git
RUN apt-get install -qy git

# Create temporary working directory for MBP
RUN mkdir ${MBP_HOME}
WORKDIR ${MBP_HOME}

# Clone repository
RUN git clone -b ${MBP_BRANCH} https://github.com/IPVS-AS/MBP .


# *********** MBP installation ***********
# ****************************************

# Write hostname
RUN sh -c "echo '127.0.0.1' $(hostname) >> /etc/hosts"

# Install JDK 8
RUN apt-get install -qy openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install Maven
RUN apt-get install -qy maven

# Install Mosquitto Broker
RUN apt-get install -qy mosquitto

# Install MongoDB
RUN apt-get -qy install mongodb-server

# Install InfluxDB
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb
RUN dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb

# Install Tomcat 8, execute security fix and start
RUN wget http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && tar xzf /tmp/catalina.tar.gz -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && rm /tmp/catalina.tar.gz
ADD ./server.xml /opt/tomcat/conf/
ADD ./tomcat-users.xml /opt/tomcat/conf/
ADD ./manager.xml /opt/tomcat/conf/Catalina/localhost/manager.xml
RUN export CATALINA_OPTS="$CATALINA_OPTS -Djava.security.egd=file:/dev/./urandom"

# Build MBP *.war file
WORKDIR ${MBP_HOME}
RUN mvn clean install

# Remove ROOT webapp
RUN rm -r -f /opt/tomcat/webapps/ROOT

# Deploy *.war file to tomcat as ROOT webapp
RUN mv target/MBP-0.1.war /opt/tomcat/webapps/ROOT.war


# **************** Startup ****************
# *****************************************

# Expose ports for web, MQTT, application, InfluxDB and Tomcat
EXPOSE 80 1883

ADD ./entrypoint.sh /tmp/entrypoint.sh
ENTRYPOINT /tmp/entrypoint.sh