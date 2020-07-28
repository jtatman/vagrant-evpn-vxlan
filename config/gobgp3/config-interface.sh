#!/bin/bash

# create veth pair and netns
ip netns add vxlan-ns
#ip addr add dev lo 10.3.3.3/32 # use dummy instead of loopback
ip link add dummy0 type dummy
ip link set dummy0 netns vxlan-ns
ip netns exec vxlan-ns ip addr add 10.3.3.3/32 dev dummy0
ip netns exec vxlan-ns ip link set dummy0 up

# virtual eth interfaces
ip link add veth0 type veth peer name veth1
ip addr add 192.168.10.5/24 dev veth1  
ip link set veth0 mtu 1450
ip link set veth1 mtu 1450
ip link set veth0 netns vxlan-ns
ip netns exec vxlan-ns ip addr add 192.168.10.6/24 dev veth0
ip netns exec vxlan-ns ip link set veth0 up
ip link set veth1 up 

#ip netns exec vxlan ifconfig lo up

cat <<EOF > /etc/rc.local
# create veth pair and netns
ip netns add vxlan-ns
#ip addr add dev lo 10.3.3.3/32 # use dummy instead of loopback
ip link add dummy0 type dummy
ip link set dummy0 netns vxlan-ns
ip netns exec vxlan-ns ip addr add 10.3.3.3/32 dev dummy0
ip netns exec vxlan-ns ip link set dummy0 up

# virtual eth interfaces
ip link add veth0 type veth peer name veth1
ip addr add 192.168.10.5/24 dev veth1
ip link set veth0 mtu 1450
ip link set veth1 mtu 1450
ip link set veth0 netns vxlan-ns
ip netns exec vxlan-ns ip addr add 192.168.10.6/24 dev veth0
ip netns exec vxlan-ns ip link set veth0 up
ip link set veth1 up 

exit 0
EOF

ip route add 10.0.12.0/24 via 10.0.23.10
ip route add 10.1.1.1/32 via 10.0.23.10

exit
