# $1 = Static IP
ETH_PATH=/etc/sysconfig/network-scripts/ifcfg-eth0
rm -f $ETH_PATH
touch $ETH_PATH

echo "DEVICE=eth0" >> $ETH_PATH
echo "TYPE=Ethernet" >> $ETH_PATH
echo "ONBOOT=yes" >> $ETH_PATH
echo "NM_CONTROLLED=yes" >> $ETH_PATH
echo "BOOTPROTO=none" >> $ETH_PATH
echo "IPADDR=$1" >> $ETH_PATH
echo "NETMASK=255.255.255.0" >> $ETH_PATH
echo "GATEWAY=192.168.1.1" >> $ETH_PATH
echo "DNS1=192.168.1.1" >> $ETH_PATH

service network restart
