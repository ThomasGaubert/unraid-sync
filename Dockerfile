FROM ubuntu:18.04

ARG DEST_IP
ARG DEST_PORT

# Install packages
RUN apt-get update \
&& apt-get install -y lsyncd

# Create logger files
RUN mkdir /var/log/lsyncd
RUN touch /var/log/lsyncd/lsyncd.status
RUN touch /var/log/lsyncd/lsyncd.log

# Set configuration
COPY ./lsyncd.exclude /etc/lsyncd/lsyncd.exclude
COPY ./lsyncd.conf.lua /etc/lsyncd/lsyncd.conf.lua

# Run lsyncd
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]