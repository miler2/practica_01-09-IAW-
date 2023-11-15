#!/bin/bash

#Muestra todos los comandos que se van ejecutando y para si hay errores
set -ex

#actualizamos los repositorios
sudo apt update

#Actualizamos los paquetes
#sudo apt upgrade -y

#Instalamos el servidor web Apache
sudo apt install apache2 -y

#Instalamos php
sudo apt install php libapache2-mod-php php-mysql -y

#Copiamos nuestro archivo de configuración a su sitio, para que se apliquen los cambios.
cp ../conf/000-default.conf /etc/apache2/sites-available/

#Reiniciamos el servidor para aplicar los cambios
systemctl restart apache2

#Modificamos el propietario y el grupo del directorio /var/www/html para
#que la persona que abra esta página desde la web tenga permisos.
#El comando "-R" para hacer los cambios de forma recursiva.
chown -R www-data:www-data /var/www/html