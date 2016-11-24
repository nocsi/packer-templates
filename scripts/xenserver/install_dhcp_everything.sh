#!/bin/bash

mount /dev/sda1 /mnt

cp /tmp/dhcp-everything /mnt/etc/firstboot.d/96-dhcp-everything
chmod 755 /mnt/etc/firstboot.d/96-dhcp-everything

# Clean up
umount /mnt

