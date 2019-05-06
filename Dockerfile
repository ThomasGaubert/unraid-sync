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

# Generate SSH
RUN ssh-keygen -t rsa
RUN mkdir /root/.ssh/
RUN cp "~/.ssh/id"* "/root/.ssh"

# Copy SSH
RUN ssh-copy-id -i ~/.ssh/id_rsa.pub thomas@${DEST_IP} -p ${DEST_PORT}

# Set / Get configuration
RUN mkdir /etc/lsyncd
RUN scp -P ${DEST_PORT} thomas@${DEST_IP}:lsyncd.conf.lua /etc/lsyncd/lsyncd.conf.lua

# Run lsyncd
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]