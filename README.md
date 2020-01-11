# Qubes OpenVPN VM

Simple tools to add OpenVPN config files to network manager, and start a preferred VPN at VM startup.

## Features

- Add many VPN config files at once
- Store the VPN login data in network manager
- Prevent IP leaking from VM's which use the OpenVPN VM for networking

## Installation

1. Clone the repo and cd to it
2. Run `sudo ./install.sh`
3. Download your VPN provider's config files and extract them to somehwere. Note that they need to have the extension `.conf` or `.ovpn`.
4. Edit the file `/rw/config/qubes-openvpn-vm.conf`
5. (optional) To start the VPN without rebooting the VM, run `sudo /rw/openvpn-vm/startup.sh`
6. Enjoy :-)

## Motivation

This setup is working already since a few years for me. I think it's much more user friendly to manage the VPN config via network manager, instead of just placing the configurations somewhere and hope that the systemd service will do the right things.

I want to share my Qubes VPN approach with the community, and with a little luck, this project will gain some interest.

## Known bugs

In very rare cases the network manager configuration got lost. I didn't check yet why this happens. Simply re-run the `install-configs.sh` script and you are good again.
