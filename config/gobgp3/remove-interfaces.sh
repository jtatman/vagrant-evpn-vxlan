#!/bin/bash

# remove created interfaces

ip link del dummy0
ip link del veth1
ip link del veth0
ip netns del vxlan-ns

ip route del 10.0.12.0/24 via 10.0.23.10
ip route del 10.1.1.1/32 via 10.0.23.10

rm -f /etc/rc.local
