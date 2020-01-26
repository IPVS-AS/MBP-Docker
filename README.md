# MBP-Docker
This repository specifies a Dockerfile for building a Docker image for the [Multi-purpose Binding and Provisioning Platform (MBP)](https://github.com/IPVS-AS/MBP). It consists out of the MBP application and its dependencies, including Tomcat 8, MongoDB, InfluxDB and Mosquitto as MQTT broker.

Once the image is executed within a container, the MBP application will be accessible at *port 80*.

**Remark:** Although this image already includes a MQTT broker, it may only be accessible from the host on which the container is running and not from other devices in the same network. By default, ports of docker containers are only available for the host on which the corresponding docker instance is running on. Thus, the MBP will not be able to receive and process sensor values from other devices. In this case, you will need to run a separate MQTT broker outside of this container and provide its IP address to the MBP application. This may be done at the frontend during runtime by opening the *Settings* page from the menu bar on the left-hand side and selecting the option *Use remote broker*. As an alternative, a proxy may be configured on the host that forwards the container ports and makes them publicly available.

## Properties
Please find below some lists of properties of the docker image.

### Base image
Ubuntu 19.04 is used as base image.

### Installed components
This is a list of third-party components that are installed within this container.

* Basic packages: apt-utils, curl, gnupg2, wget
* Git
* OpenJDK 8
* Maven
* [Mosquitto MQTT Broker](https://mosquitto.org/download/)
* [MongoDB Server](https://www.mongodb.com/download-center?jmp=nav#community)
* [InfluxDB](https://portal.influxdata.com/downloads/)
* [Tomcat 8](https://tomcat.apache.org/download-80.cgi)

Remark: Sets `-Djava.security.egd=file:/dev/./urandom` for faster startup. However, this makes the usage of this container a bit less secure.

### Ports
This is a list of network ports exposed by this container.

* Port 22: May be used for SSH
* Port 80: The frontend of the MBP application will be available on this port
* Port 1883: Used for MQTT communication

### Arguments
This is a list of arguments that may be passed within the build step of the image.

* `branch` Branch of the MBP GitHub repository that is supposed to be used as source for the MBP

### Environment Variables
This is a list of environment variables that are available within the container.

* `TOMCAT_VERSION`: Version number of Tomcat 8 to use
* `INFLUXDB_VERSION`: Version number of InfluxDB to use
* `MBP_HOME`: Path to the directory into which the MBP application is supposed to be installed
* `JAVA_HOME`: Java Home directory


## Volumes
No volumes are exposed at the moment.

## Usage
This section describes how to build an image from this repository and run it in docker as a container.

### Build image
1. Clone this repository on your local machine
2. Switch into the root folder of this repository
3. Execute `docker build -t mbp --build-arg branch=master full/` to build an image with name `mbp` by using the master branch of the MBP repository as source for the application. You may omit the branch parameter or replace it with the name of a different branch.
4. Execute `docker run -it --name mbp -p 80:80 -p 1883:1883 mbp:latest` to create a container from the previously created image. By default, this maps port 80 and port 1883 of the container to port 80 respectively port 1883 of the host system. However, the target ports may be changed in this command if required.
5. After the previous step has been finished

After the container has been started successfully in the last step, the web interface of the MBP may be accessed via port 80 (or the other target port that was specified in step 4).


## Haftungsausschluss

Dies ist ein Forschungsprototyp.
Die Haftung für entgangenen Gewinn, Produktionsausfall, Betriebsunterbrechung, entgangene Nutzungen, Verlust von Daten und Informationen, Finanzierungsaufwendungen sowie sonstige Vermögens- und Folgeschäden ist, außer in Fällen von grober Fahrlässigkeit, Vorsatz und Personenschäden, ausgeschlossen.

## Disclaimer of Warranty

Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE.
You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.
