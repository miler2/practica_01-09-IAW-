#!/bin/bash

set -x 

source .env


#Eliminamos posibles instalaciones previas
rm -rf /tmp/latest.zip

#Descargamos el código fuente
wget http://wordpress.org/latest.zip -P /tmp

#Instalamos el comando unzip
apt install unzip -y

#Descomprimimos el archivo descargado en la carpeta tmp
unzip -u /tmp/latest.zip -d /tmp

#Movemos el contenido de /tmp/wordpress a /var/www/html
mv -f /tmp/wordpress/* /var/www/html

#Creamos un archivo de configuración wp-config.php a partir del archivo de ejemplo wp-config-sample.php.
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php


#Creamos la base de datos y el usuario para WordPress.
mysql -u root <<< "DROP DATABASE IF EXISTS $WORDPRESS_DB_NAME"
mysql -u root <<< "CREATE DATABASE $WORDPRESS_DB_NAME"
mysql -u root <<< "DROP USER IF EXISTS $WORDPRESS_DB_USER@$IP_CLIENTE_MYSQL"
mysql -u root <<< "CREATE USER $WORDPRESS_DB_USER@$IP_CLIENTE_MYSQL IDENTIFIED BY '$WORDPRESS_DB_PASSWORD'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO $WORDPRESS_DB_USER@$IP_CLIENTE_MYSQL"

#Reemplazamos los parametros dentro del archivo wp-config.php
sed -i "s/database_name_here/$WORDPRESS_DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$WORDPRESS_DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/" /var/www/html/wp-config.php
sed -i "s/localhost/$WORDPRESS_DB_HOST/" /var/www/html/wp-config.php

#Cambiamos el propietario y el grupo del directorio /var/www/html
chown -R www-data:www-data /var/www/html/