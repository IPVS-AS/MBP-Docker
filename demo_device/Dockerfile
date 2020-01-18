# ***************** Init *****************
# ****************************************

# Base image
FROM ubuntu:19.04

# Meta data
LABEL maintainer="as@ipvs.uni-stuttgart.de"
LABEL org.label-schema.name="Demo device"
LABEL org.label-schema.description="Empty ubuntu container working as demo device for the Multi-purpose Binding and Provisioning Platform (MBP)"


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

# Install and enable SSH
RUN apt-get install netcat -qy
RUN apt-get install ssh -qy
RUN apt-get install iputils-ping -qy
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd
RUN useradd -p $(openssl passwd -1 u2pass) --create-home --shell /bin/bash --groups sudo u2
 
# Copy SSH key
RUN mkdir /home/u2/.ssh
RUN chmod 700 /home/u2/.ssh
ADD ./id_rsa.pub /home/u2/.ssh/id_rsa.pub

# **************** Startup ****************
# *****************************************

# Execute SSH
RUN /usr/sbin/sshd

# Expose ports for SSH and MQTT
EXPOSE 22 1883

ADD ./entrypoint.sh /tmp/entrypoint.sh

ENTRYPOINT /tmp/entrypoint.sh
