#!/bin/sh -e
source /rw/config/qubes-openvpn-vm.conf

echo "Deleting all saved connections"
for id in $(nmcli c | grep ' vpn ' | cut -d' ' -f1) ; do
	nmcli connection delete $id
done

echo "Installing config files"
tempdir=$(mktemp -d)
for path in $QUBES_OPENVPN_CONFIG_FILE_PATHS; do
    cd $path
    for x in $(ls *.ovpn *.conf 2>/dev/null | sort) ; do
    	id=$(echo $x | sed -re 's/.(ovpn|conf)$//')
        y=$id.ovpn
        cp $x $tempdir/$y
        sed -i /auth-user-pass/d $tempdir/$y
    	echo auth-user-pass >>$tempdir/$y
    	nmcli connection import type openvpn file $y
        if [ "$QUBES_OPENVPN_USERNAME" != "" ]; then
        	nmcli connection modify $id +vpn.data username="$QUBES_OPENVPN_USERNAME"
        	nmcli connection modify $id +vpn.secrets password="$QUBES_OPENVPN_PASSWORD"
        	nmcli connection modify $id +vpn.data password-flags=0
        fi
    done
    cd ..
done
rm -rf $tempdir
