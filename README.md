# MBP-Docker
This repository specifies a docker-compose configuration which allows to operate an instance of the [Multi-purpose Binding and Provisioning Platform (MBP)](https://github.com/IPVS-AS/MBP). It consists out of multiple containers: One for the deployed MBP application itself, one for the requred MongoDB and one for a MQTT broker.

**Remark:** Although this setup already includes a MQTT broker, it may only be accessible from the host on which the container is running and not from other devices in the same network. By default, ports of docker containers are only available for the host on which the corresponding docker instance is running on. Thus, the MBP will not be able to receive and process sensor values from other devices. In this case, you will need to run a separate MQTT broker outside of this container and provide its IP address to the MBP application. This may be done at the frontend during runtime by opening the *Settings* page from the menu bar on the left-hand side and selecting the option *Use remote broker*. As an alternative, a proxy may be configured on the host that forwards the container ports and makes them publicly available.

## Usage
This section describes how to run an instance of the MBP using docker-compose.

### Build image
1. Clone this repository on your local machine
2. Open a terminal and switch into the root folder of this repository
3. Execute `docker-compose up`, which will build or download the required images for the different contains and run containers of the resulting images in a shared network.
4. After the previous step, the web interface of the MBP should now be accessible via a web browser at `http://<docker-ip>:80`, where `docker-ip` refers to the IP address of that has been previously assigned by Docker to the current machine. The running MBP instance has already access to the MongoDB and the MQTT broker which are both operated in different containers.

In order to stop or terminate the MBP instance, execute `docker-compose stop` or `docker-compose down`, respectively, in the root folder of this repository's clone.


## Haftungsausschluss

Dies ist ein Forschungsprototyp.
Die Haftung für entgangenen Gewinn, Produktionsausfall, Betriebsunterbrechung, entgangene Nutzungen, Verlust von Daten und Informationen, Finanzierungsaufwendungen sowie sonstige Vermögens- und Folgeschäden ist, außer in Fällen von grober Fahrlässigkeit, Vorsatz und Personenschäden, ausgeschlossen.

## Disclaimer of Warranty

Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE.
You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.
