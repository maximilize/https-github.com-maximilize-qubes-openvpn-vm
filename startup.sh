#!/bin/sh
# Prevent IP leaking
ip4n=$(( $(iptables -nL FORWARD --line-numbers | grep QBS-FORWARD | cut -d' ' -f1) + 0 ))
ip6n=$(( $(ip6tables -nL FORWARD --line-numbers | grep QBS-FORWARD | cut -d' ' -f1) + 0 ))
iptables -I FORWARD $ip4n -i eth0 -j DROP
iptables -I FORWARD $ip4n -o eth0 -j DROP
ip6tables -I FORWARD $ip6n -i eth0 -j DROP
ip6tables -I FORWARD $ip6n -o eth0 -j DROP

# Make sure the network-manager is up and running
systemctl enable NetworkManager-dispatcher.service
systemctl enable NetworkManager-wait-online.service
systemctl start NetworkManager.service

# Autostart the default VPN connection
if [ -e /rw/config/qubes-openvpn-vm.conf ]; then
    source /rw/config/qubes-openvpn-vm.conf
    if [ "$QUBES_OPENVPN_DEFAULT_CONNECTION" != "" ]; then
        nm-online -s -q
        nmcli c up "$QUBES_OPENVPN_DEFAULT_CONNECTION"
    fi
fi
