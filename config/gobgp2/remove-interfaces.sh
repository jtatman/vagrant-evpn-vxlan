#!/bin/bash

# remove created interfaces

ip link del dummy0
ip link del veth1
ip link del veth0
ip netns del vxlan-ns

rm -f /etc/rc.local
