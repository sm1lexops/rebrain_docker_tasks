#!/bin/sh

# Flush existing rules
ip6tables -F
ip6tables -X

# Set default policy to ACCEPT for all chains
ip6tables -P INPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -P OUTPUT ACCEPT

# Allow all traffic on the loopback interface
ip6tables -A INPUT -i lo -j ACCEPT
ip6tables -A OUTPUT -o lo -j ACCEPT

# Allow established and related incoming connections
ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow all ICMPv6 traffic (necessary for IPv6 functionality)
ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
ip6tables -A FORWARD -p ipv6-icmp -j ACCEPT

# Allow traffic on the Docker interface
ip6tables -A INPUT -i docker0 -j ACCEPT
ip6tables -A FORWARD -i docker0 -j ACCEPT
ip6tables -A FORWARD -o docker0 -j ACCEPT

# Allow traffic on the specific veth interface
ip6tables -A INPUT -i veth30dcd61 -j ACCEPT
ip6tables -A FORWARD -i veth30dcd61 -j ACCEPT
ip6tables -A FORWARD -o veth30dcd61 -j ACCEPT

# Allow incoming SSH connections on port 22
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow incoming HTTP connections on port 80
ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow incoming HTTPS connections on port 443
ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT
ip6tables -t nat -A POSTROUTING -s 2001:db8:1::/64 ! -o docker0 -j MASQUERADE