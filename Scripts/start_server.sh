#!/bin/bash
#start server
cd /var/www/html/
exec php -S 0.0.0.0:80 > /dev/null &
