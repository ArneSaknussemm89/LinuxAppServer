FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        curl cron git vim supervisor
        --no-install-recommends && apt-get -y upgrade && rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor /etc/confd/conf.d /etc/confd/templates

# Install Confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.15.0/confd-0.15.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

## Add line to crontab to prevent mail from being sent
#RUN sed -i '/SHELL/iMAILTO=""' /etc/crontab
#
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY confd /etc/confd/
#COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf
#COPY php.ini /etc/php/7.0/fpm/php.ini
#COPY site.conf /etc/apache2/sites-available/000-default.conf
#COPY remoteip.conf /etc/apache2/conf-enabled/remoteip.conf
#COPY apache2.conf /etc/apache2/apache2.conf
#COPY registry_rebuild /root/.drush/registry_rebuild

# Copy in start script
COPY start.sh /root/
#COPY bash_aliases /root/.bash_aliases
#COPY drupal-settings /root/drupal-settings/

# Volumes
VOLUME /var/www/server /etc/apache2/sites-enabled /mnt/sites-files

WORKDIR /var/www/server

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]