FROM ubuntu:20.04

# Install wireguard packges
RUN apt-get update && \
 apt-get install -y --no-install-recommends wireguard-tools iptables nano net-tools procps openresolv inotify-tools iproute2 && \
 apt-get clean

# Add main work dir to PATH
WORKDIR /scripts
ENV PATH="/scripts:${PATH}"

# Use iptables masquerade NAT rule
ENV IPTABLES_MASQ=1

# Watch for changes to interface conf files (default off)
ENV WATCH_CHANGES=0

# Copy scripts to containers
COPY install-module /scripts
COPY run /scripts
COPY genkeys /scripts
RUN chmod 755 /scripts/*

# Wirguard interface configs go in /etc/wireguard
VOLUME /etc/wireguard

# Normal behavior is just to run wireguard with existing configs
CMD ["run"]
