FROM ubuntu:latest
MAINTAINER John Fink <john.fink@gmail.com>
RUN apt-get update # Fri Oct 24 13:09:23 EDT 2014
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql  php5-ldap  php5-curl  php5-gd  php5-xmlrpc  php5-intl
RUN easy_install supervisor
ADD ./scripts/start.sh /start.sh
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
ADD ./configs/supervisord.conf /etc/supervisord.conf
ADD ./configs/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/
ADD https://download.moodle.org/download.php/direct/stable28/moodle-latest-28.tgz /moodle.tar.gz
RUN tar xvzf /moodle.tar.gz 
RUN mv /moodle /var/www/
RUN chown -R www-data:www-data /var/www/
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
RUN mkdir /var/log/supervisor/
RUN mkdir /var/moodata/
RUN chown -R www-data:www-data /var/moodata/
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
