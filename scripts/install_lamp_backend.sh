#!/bin/bash

#Muestra todos los comandos que se van ejecutando y para si hay errores
set -ex

#actualizamos los repositorios
sudo apt update

#Actualizamos los paquetes
#sudo apt upgrade -y

#Instalamos el sistema gestor de bases de datos MySQL
sudo apt install mysql-server -y