#!/bin/bash

# remove created interfaces

echo "delete dummy0"
ip link del dummy0
echo "delete veth0"
ip link del veth0
echo "delete veth1"
ip link del veth1
echo "delete namespace"
ip netns del vxlan-ns

echo "delete route 10.0.23.0"
ip route del 10.0.23.0
echo "delete route 10.3.3.3"
ip route del 10.3.3.3

echo "removing rc.local"
rm -f /etc/rc.local
