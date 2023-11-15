#!/bin/bash

#Muestra todos los comandos que se van ejecutando y para si hay errores
set -ex

#actualizamos los repositorios
sudo apt update

#Actualizamos los paquetes
#sudo apt upgrade -y

#Importamos el archivo .env
source .env

#Instalamos el sistema gestor de bases de datos MySQL
sudo apt install mysql-server -y

#Configuramos MySQL para que sólo acepte conexiones desde la IP privada
sed -i "s/127.0.0.1/$MYSQL_PRIVATE_IP/" /etc/mysql/mysql.conf.d/mysqld.cnf