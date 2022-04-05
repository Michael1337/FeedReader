FROM php:8.0-apache
RUN docker-php-ext-install mysqli

COPY src/ /var/www/html/
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# CRONJOB
RUN apt-get update && \
    apt-get -y install tzdata cron

RUN cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    echo "Europe/Berlin" > /etc/timezone

#RUN apt-get -y remove tzdata
RUN rm -rf /var/cache/apk/*

# Copy cron file to the cron.d directory
COPY cron /etc/cron.d/cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cron

# Apply cron job
RUN crontab /etc/cron.d/cron

# Add a command to base-image entrypont scritp
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground
