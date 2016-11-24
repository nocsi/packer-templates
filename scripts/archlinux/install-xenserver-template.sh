#!/usr/bin/bash -x

# XenServer Guest Utilities
# No need for 64-bit paravirtualization support for Xen by default
#/usr/bin/pacman -S --noconfirm xe-guest-utilities

pacman -S --noconfirm python2 linux-headers
ln -sf /usr/bin/python2 /usr/local/bin/python
