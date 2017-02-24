#!/bin/bash

# Arguments
# $1 : number of docker hosts
echo "Number of nodes : $1"

# Install HAProxy
sudo apt-get install -y haproxy

# Write HAProxy configuration
sudo echo '' >> /etc/haproxy/haproxy.cfg
# Create listener
sudo echo 'listen randomuuid' >> /etc/haproxy/haproxy.cfg
# Bind on port 80
sudo echo ' bind 0.0.0.0:80' >> /etc/haproxy/haproxy.cfg
# Processes HTTP protocol for each request and response
sudo echo ' mode http' >> /etc/haproxy/haproxy.cfg
# Enable stats
sudo echo ' stats enable' >> /etc/haproxy/haproxy.cfg
# Configure URI
sudo echo ' stats uri /haproxy?stats' >> /etc/haproxy/haproxy.cfg
# Round robin as algorithm for balancing
sudo echo ' balance roundrobin' >> /etc/haproxy/haproxy.cfg
# Close connection, validate that the header is present
sudo echo ' option httpclose' >> /etc/haproxy/haproxy.cfg
# Add the X-Forwarded-For header
sudo echo ' option forwardfor' >> /etc/haproxy/haproxy.cfg
# Add every docker host
for (( c=1; c<=$1; c++ ))
do
  sudo echo " server randomuuid$c 192.168.0.1$c:80 check" >> /etc/haproxy/haproxy.cfg
done

# Restart HAProxy
sudo /etc/init.d/haproxy restart
