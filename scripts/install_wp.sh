#!/bin/bash
MAINPATH=$(dirname $(cd `dirname "${BASH_SOURCE[0]}"` && pwd))
PROJECTNAME=$(basename $MAINPATH)

docker exec --user=1000:1000 $PROJECTNAME-apache curl -o /home/www-bridge-user/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
docker exec --user=1000:1000 $PROJECTNAME-apache chmod +x /home/www-bridge-user/wp-cli.phar
docker exec $PROJECTNAME-apache ln -s /home/www-bridge-user/wp-cli.phar /usr/bin/wp
docker exec --user=1000:1000 $PROJECTNAME-apache sh -c 'wp core download --path=wordpress && wp core config --dbname=wordpress --dbuser=root --dbpass=123 --dbhost=db'