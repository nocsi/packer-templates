#!/usr/bin/env bash

FQDN='vagrant000-arch.nocsi.org'
KEYMAP='us'
LANGUAGE='en_US.UTF-8'
TIMEZONE='UTC'
PASSWORD=$(/usr/bin/openssl passwd -crypt 'vagrant')

echo '${FQDN}' > /etc/hostname
/usr/bin/systemctl enable sshd.service
ln -s '/usr/lib/systemd/system/xe-linux-distribution.service' '/etc/systemd/system/multi-user.target.wants/xe-linux-distribution.service'
# Vagrant-specific configuration
/usr/bin/userdel -r vagrant
/usr/bin/useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --gid users vagrant
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
/usr/bin/chmod 0440 /etc/sudoers.d/10_vagrant
/usr/bin/install --directory --owner=vagrant --group=users --mode=0700 /home/vagrant/.ssh
/usr/bin/curl --output /home/vagrant/.ssh/authorized_keys --location https://keys.nocsi.org/nocsinuc.pub
/usr/bin/chown vagrant:users /home/vagrant/.ssh/authorized_keys
/usr/bin/chmod 0600 /home/vagrant/.ssh/authorized_keys
/usr/bin/sleep 3
#/usr/bin/systemctl reboot
