#!/bin/bash

# create veth pair and netns
echo "creating namespace"
ip netns add vxlan-ns
#ip addr add dev lo 10.1.1.1/32 # use dummy instead of loopback
echo "creating dummy interface"
ip link add dummy0 type dummy
echo "add dummy interface to namespace"
ip link set dummy0 netns vxlan-ns
ip netns exec vxlan-ns ip addr add 10.1.1.1/32 dev dummy0
ip netns exec vxlan-ns ip link set dummy0 up

# virtual eth interfaces
echo "create virtual ethernets"
ip link add veth0 type veth peer name veth1
ip link set veth0 mtu 1450
ip link set veth1 mtu 1450
echo "add veth0 to netns"
ip link set veth0 netns vxlan-ns
echo "configure veths"
ip netns exec vxlan-ns ip addr add 192.168.10.1/24 dev veth0
ip netns exec vxlan-ns ip link set veth0 up
ip addr add 192.168.10.2/24 dev veth1
ip link set veth1 up

cat <<EOF > /etc/rc.local
# create veth pair and netns
ip netns add vxlan-ns
ip link add dummy0 type dummy
ip addr add dummy0 10.1.1.1/32 dev dummy0
ip link set dummy0 netns vxlan-ns
ip netns exec vxlan-ns ip link set dummy0 up

# virtual eth interfaces
ip link add veth0 type veth peer name veth1
ip addr add 192.168.10.2/24 dev veth1
ip addr add 192.168.10.1/24 dev veth0
ip link set veth0 mtu 1450
ip link set veth1 mtu 1450
ip link set veth0 netns vxlan-ns
ip netns exec vxlan-ns ip link set veth0 up
ip link set veth1 up
exit 0
EOF

# add static route
echo "add route for 10.0.23.0"
ip route add 10.0.23.0/24 via 10.0.12.20
echo "add route for 10.3.3.3 dummy"
ip route add 10.3.3.3/32 via 10.0.12.20

exit
