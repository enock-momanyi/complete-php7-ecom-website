#!/bin/bash
#start server
cd /var/www/html/
exec php -S 0.0.0.0:8000 > /dev/null &
