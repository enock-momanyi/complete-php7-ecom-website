#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo yum install -y php

# Install MariaDB server
sudo yum install -y mariadb-server

# Secure installation, set root password, and remove anonymous users
sudo mysql_secure_installation <<EOF

y
y
admin2
admin2
y
y
y
y
EOF

# Create a custom database and user
custom_db_name="ecommerce"
custom_db_user="anonymous"
custom_db_password="password"

mysql -u enockenm -p"admin2" <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $custom_db_name;
CREATE USER '$custom_db_user'@'localhost' IDENTIFIED BY '$custom_db_password';
GRANT ALL PRIVILEGES ON $custom_db_name.* TO '$custom_db_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "Custom database '$custom_db_name' and user '$custom_db_user' created with the provided password."
#Install composer
sudo apt install -y php-cli unzip
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Database configuration
########################
export DB_HOSTNAME='localhost'
export DB_USERNAME='anonymous'
export DB_PASSWORD='password'
export DB_DATABASE='ecommerce'
export DB_PORT='3306'
# export DB_SOCKET=''
#populate database with data
mysql -u "anonymous" -p"password" ecommerce < ./config/db_dump.sql

