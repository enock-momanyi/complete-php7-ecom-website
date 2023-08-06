#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server



sudo systemctl start httpd
sudo systemctl enable httpd
# Install MariaDB server
sudo systemctl start mariadb
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

mysql -u root -p"admin2" <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $custom_db_name;
CREATE USER '$custom_db_user'@'localhost' IDENTIFIED BY '$custom_db_password';
GRANT ALL PRIVILEGES ON $custom_db_name.* TO '$custom_db_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "Custom database '$custom_db_name' and user '$custom_db_user' created with the provided password."
#Install composer

cd ~
sudo yum install -y php7.2-mbstring php7.2-apcu php7.2-memcached php7.2-redis
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
cd /var/www/html/
composer install
cd ~
mysql -u "anonymous" -p"password" ecommerce < /var/www/html/config/db_dump.sql

