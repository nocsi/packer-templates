#!/bin/bash -eux

# Remove Ansible and its dependencies.
pip freeze | grep -v "^-e" | xargs pip uninstall -y
yum -y remove git python-setuptools gcc python-devel openssl-devel

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
