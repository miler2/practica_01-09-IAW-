#!/bin/bash
set -x

apt update -y

source .env

#Instalamos y actualizamos snapd
snap install core
snap refresh core

#Eliminamos cualquier instalación previa de certbot con apt
apt remove certbot

#Instalamos la aplicación 
snap install --classic certbot

#Creamos un alias para la aplicación certbot
sudo ln -sf /snap/bin/certbot/bin/certbot

#Obtenemos el certificado y configuramos el servidor web Apache
certbot --apache -m $CERTIFICATE_EMAIL --agree-tos --no-eff-email -d $CERTIFICATE_DOMAIN --non-interactive

#Con el siguiente comando podemos comprobar que hay un temporizador en el sistema en 
#systemctl list-timers