FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        curl cron git vim screen supervisor \
        --no-install-recommends && apt-get -y upgrade && rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

## Add line to crontab to prevent mail from being sent
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy in start script
COPY start.sh /root/

# Volumes
VOLUME /var/www/server

WORKDIR /var/www/server

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
