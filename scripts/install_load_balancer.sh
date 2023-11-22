#!/bin/bash

#Muestra todos los comandos que se van ejecutando y para si hay errores
set -ex

#actualizamos los repositorios
apt update

#Actualizamos los paquetes
#apt upgrade -y

#Importamos el archivo de variables
source .env

#Instalamos el servidor web Apache
apt install apache2 -y

#Habilitamos los siguientes módulos para configurar apache como proxy inverso
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer

#Habilitamos el balanceo de carga Round Robin
a2enmod lbmethod_byrequests

#Copiamos el archivo de configuración load balancer
cp ../conf/load-balancer.conf /etc/apache2/sites-available

#Reemplazamos los valores de la plantilla por las direcciones IP de los frontales
sed -i "s/IP_HTTP_SERVER_1/$IP_HTTP_SERVER1/" /etc/apache2/sites-available/load-balancer.conf
sed -i "s/IP_HTTP_SERVER_2/$IP_HTTP_SERVER2/" /etc/apache2/sites-available/load-balancer.conf

#Habilitamos el VirtualHost que acabmos de crear
sudo a2ensite load-balancer.conf
sudo a2dissite 000-default.conf

#Reiniciamos el servicio tras haber configurado apache
systemctl restart apache2

#Tras todo esto, ejecutar este comando a mano nos puede dar información sobre cómo está nuestro código
#sudo apache2ctl configtest