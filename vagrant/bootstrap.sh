#!/usr/bin/env bash
 
apt-get update
 
# install apache
apt-get install -q -y apache2 php php7.3-dev php7.3-zip php7.3-curl php7.3-gd php7.3-mysql php7.3-xml libapache2-mod-php7.3 mysql-server

# /vagrant is shared by default
# symlink that to /var/www
# this will be the pubic root of the site

# configuration files live at /etc/apache2/
rm -rf /var/www/project
ln -fs /vagrant /var/www/project

################################################################################

# Enable SSI following (mostly) the directions here:
# https://help.ubuntu.com/community/ServerSideIncludes

# Add the Includes module
a2enmod include

# Add Includes, AddType and AddOutputFilter directives
cp /vagrant/default /etc/apache2/sites-available/000-default.conf

cd /etc/apache2/sites-available
a2ensite 000-default.conf

# restart apache2
apachectl -k graceful

# smoke test
# open a brower to http://127.0.0.1:8080 to test
#echo '<html><head><title>SSI Test Page</title></head><body><!--#echo var="DATE_LOCAL" --></body></html>' > /vagrant/www/index.html