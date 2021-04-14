# ***************** Init *****************
# ****************************************

# Base image
FROM tomcat:9.0.45-jdk11

# Meta data
LABEL maintainer="as@ipvs.uni-stuttgart.de"
LABEL org.label-schema.name="Multi-purpose Binding and Provisioning Platform"
LABEL org.label-schema.description="Contains a Tomcat 9 installation with an already deployed and ready-to-use instance of the Multi-purpose Binding and Provisioning Platform (MBP) for Internet of Things devices. Since the required MongoDB and MQTT broker are not included in this image, it is recommended to use this image within a docker-compose setup."
LABEL org.label-schema.vcs-url="https://github.com/IPVS-AS/MBP-Docker"

# Input arguments
ARG branch=master

# Environment variables
ENV MBP_HOME /tmp/mbp
ENV MBP_BRANCH ${branch}
ENV MBP_REPOSITORY https://github.com/IPVS-AS/MBP


# ************* Preparations *************
# ****************************************

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install required packages
RUN apt-get update && apt-get install -qy git
RUN apt-get update && apt-get install -qy maven

# Create temporary working directory for MBP
RUN mkdir ${MBP_HOME}
WORKDIR ${MBP_HOME}


# *********** MBP installation ***********´
# ****************************************

# Clone repository
RUN git clone -b ${MBP_BRANCH} ${MBP_REPOSITORY} .

# Replace application.properties
ADD ./application.properties ${MBP_HOME}/src/main/resources/application.properties

# Build WAR file from MBP repository
RUN mvn clean install

# Deploy WAR file by moving it into webapps directory
RUN find target/ -name "MBP-*.war" -print0 | xargs -0 -I {} mv {} /usr/local/tomcat/webapps/ROOT.war

# **************** Startup ****************
# *****************************************

# Start Tomcat
CMD ["catalina.sh", "run"]
