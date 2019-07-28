# MBP-Docker
This repository specifies a Docker container for the [Multi-purpose Binding and Provisioning Platform (MBP)](https://github.com/IPVS-AS/MBP). It consists out of the MBP application and its dependencies, including Tomcat 8, MongoDB, InfluxDB and Mosquitto as MQTT broker. The MBP installation is mostly ready-to-use, so you just need to build an image from the container and run it in order to be able to manage your IoT environments using the MBP.

Once an image of this container is executed, the MBP application will be accessible at *port 80*.

**Caution**: Although this container already includes and runs a MQTT broker, it may not be accessible from other nodes and devices if the docker container is not made publicy available within the shared network. By default, docker containers are only available for the host the corresponding docker instance is running on. Therefore, the MBP will not be able to receive and process sensor values. In this case, you will need to run a separate MQTT broker outside of this container and provide its IP address to the MBP application. This may be done at the frontend during runtime by opening the *Settings* page from the menu bar on the left-hand side and selecting the option *Use remote broker*.

## Properties
Please find below lists of possibly relevant properties of this container.

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

* Port 80: The frontend of the MBP application will be available here
* Port 1883: This port is used for MQTT communication

### Environment Variables
This is a list of environment variables that are available within the container.

* `TOMCAT_VERSION`: Version number of Tomcat 8 to use
* `INFLUXDB_VERSION`: Version number of InfluxDB to use
* `MBP_HOME`: Path to the directory into which the MBP application is supposed to be installed
* `MBP_BRANCH`: Branch of the MBP GitHub repository to use for downloading the MBP software
* `JAVA_HOME`: Java Home directory


## Volumes
No volumes are exposed.

## Usage
This section describes how to build an image from the container and run it in docker.

### Build container
The container may be built by running `docker build full -t mbp` within the root directory of this repository. Subsequently, the resulting image will be available under the tag `mbp` in your local docker installation.

### Run container
After the container has been built, it may be executed by running `docker run mbp`. Optionally, additional commands or parameters might be passed as described in the [docker reference](https://docs.docker.com/engine/reference/run/).


## Haftungsausschluss

Dies ist ein Forschungsprototyp.
Die Haftung für entgangenen Gewinn, Produktionsausfall, Betriebsunterbrechung, entgangene Nutzungen, Verlust von Daten und Informationen, Finanzierungsaufwendungen sowie sonstige Vermögens- und Folgeschäden ist, außer in Fällen von grober Fahrlässigkeit, Vorsatz und Personenschäden, ausgeschlossen.

## Disclaimer of Warranty

Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE.
You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.
