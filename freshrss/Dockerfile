# Todo - Silence healthcheck in apache logs
# Todo - Set trusted proxies on runtime
# Todo - config.php not working, overwritten on first start, require nano to set values
# Todo - Make it distroless

FROM debian:12-slim

ENV TZ=UTC
ENV OIDC_ENABLED=true
ENV OIDC_SESSION_INACTIVITY_TIMEOUT=300
ENV OIDC_SESSION_MAX_DURATION=27200
ENV OIDC_SESSION_TYPE=server-cache
ENV TRUSTED_PROXY="10.244.0.0/16"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install necessary packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates cron \
    apache2 libapache2-mod-php \
    libapache2-mod-auth-openidc \
    php-curl php-gmp php-intl php-mbstring php-xml php-zip \
    php-sqlite3 php-mysql php-pgsql unzip curl nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY FreshRSS.Apache.conf /etc/apache2/sites-available/
COPY setup.sh /
RUN chmod +x /setup.sh && /setup.sh

RUN a2dismod -q -f alias autoindex negotiation status && \
    a2dismod -q auth_openidc && \
    phpdismod calendar exif ffi ftp gettext mysqli posix readline shmop sockets sysvmsg sysvsem sysvshm xsl && \
    a2enmod -q deflate expires filter headers mime remoteip setenvif auth_openidc && \
    a2disconf -q '*' && \
    a2dissite -q '*' && \
    a2ensite -q 'FreshRSS*'

# Download and unzip FreshRSS
ADD https://github.com/FreshRSS/FreshRSS/archive/latest.zip /tmp/latest.zip
RUN unzip /tmp/latest.zip -d /var/www/ && mv /var/www/FreshRSS-latest /var/www/FreshRSS

COPY config.php /var/www/FreshRSS/data/

# Take ownership of werbserver dirs
RUN mkdir -p /var/run/apache2 /var/lock/apache2 /var/log/apache2
RUN chown -R www-data:www-data /var/run/apache2 /var/lock/apache2 /var/log/apache2 /var/www/html /var/www/FreshRSS

# Copy the entrypoint that starts apache into the container
COPY --chown=www-data:www-data entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Configure Apache to listen on port 8080 instead of 80
RUN echo "Listen 8080" > /etc/apache2/ports.conf

USER www-data:www-data
WORKDIR /var/www/FreshRSS

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080 || exit 1