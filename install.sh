#!/bin/sh -e
mkdir -p /rw/openvpn-vm
cp install-configs.sh startup.sh /rw/openvpn-vm
test -e /rw/config/qubes-openvpn-vm.conf || cp qubes-openvpn-vm.conf /rw/config
if ! grep -q "^/rw/openvpn-vm/startup.sh$" /rw/config/rc.local ; then
	echo "/rw/openvpn-vm/startup.sh" >> /rw/config/rc.local
fi
