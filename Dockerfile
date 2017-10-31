FROM ubuntu
RUN apt-get update && apt-get install -y php5 libapache2-mod-php5 php5-cli php5-curl && apt-get clean && rm -rf /var/lib/apt/lists/*
# Enable mod_rewrite
RUN a2enmod rewrite
# Obey .htaccess with AllowOverride
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
ADD . /var/www/html
RUN mkdir /etc/apache2/falloutweb/
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /etc/apache2/falloutweb/
ENV APACHE_PID_FILE /opt/apache
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
