# Supported tags and respective Dockerfile links

# Introduction

GLPI (formely Gestion Libre de Parc Infortique) is the most free & open source IT asset and service management tool available on the web.

It supports various languages, provides a configuration management database for various devices (CMDB for computer, software, printers, etc.) and enables an online administration interface to manage assets and tickets via a Webrowser.

GLPI can leverage LDAP protocol to manage the access and supports IMAP protocol to let end-users to create issues via email.

# Roadmap

* [x] Implement Crontab for GPLI Scheduler

 # Description
The Dockerfile builds from "php:5-apache (see https://hub.docker.com/_/php/)

**This image does not leverage embedded database**

## Quick Start

Run a supported database container with persistent storage (i.e. MySQL, MariaDB).

```bash
docker volume create "glpi-db"

docker run --name='glpi-md' -d \
--restart=always \
-e MYSQL_DATABASE=glpi \
-e MYSQL_ROOT_PASSWORD=V3rY1ns3cur3P4ssw0rd \
-e MYSQL_USER=glpi \
-e MYSQL_PASSWORD=V3rY1ns3cur3P4ssw0rd \
-v glpi-db:/var/lib/mysql \
-v glpi-dblog:/var/log/mysql \
-v glpi-etc:/etc/mysql \
mariadb
```

Run the GLPI container exposing internal port 80 with persistent storage for _files_ folder (i.e for Software deployment packages).

```bash
docker volume create "glpi-files"
docker volume create "glpi-plugins"

docker run --name='GLPI' -d \
	--restart=always \
	-p 80:80 \
	-v glpi-plugins:/var/www/html/plugins \
	-v glpi-files:/var/www/html/files \
	makertim/glpi:9.4.3
```

## Initial configuration

1. Start a web browser session to http://ip:port
2. Select your language, then click _OK_.
3. Select _I have read and ACCEPT the terms of the license written above._ option, then click _Continue_.
4. Click on _Install_.
5. Review the requirement check-list, then click _Continue_.
6. Full-fill the following fields:
* **SQL server (MariaDB or MySQL)**: mysql
* **Database user**: glpi
* **Database password**: V3rY1ns3cur3P4ssw0rd
7. Then click _Continue_.
8. Select `glpi` database, then click _Continue_.
9. Confirm that message `OK - database was initialized` appears, then click _Continue_.
10. Click on _Use GLPI_.
11. Logon as `glpi` with password `glpi`.
12. 
```bash
docker exec -it GLPI rm ./install/install.php
```

# References

* http://glpi-project.org/spip.php?lang=en
* http://fusioninventory.org/documentation/fi4g/cron.html
