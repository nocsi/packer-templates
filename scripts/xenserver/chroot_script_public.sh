#!/bin/bash

sudo sed s/\$releasever/7.1.1503/g -i /etc/yum.repos.d/* 
sudo cat > /etc/yum.repos.d/xs.repo << EOF
[xs]
name=XenServer
baseurl=http://www.recoil.org/~jon/xs-dundee/domain0
enabled=1
gpgcheck=0
exclude=xenserver-release
EOF

for i in /etc/yum.repos.d/*; do
  base=`basename $i`
  grep -v www.uk.xensource.com /etc/yum.repos.d/$base > /tmp/${base}.fixed
  sed s/#baseurl/baseurl/g /tmp/${base}.fixed > /tmp/$base
  sudo mv /tmp/$base /etc/yum.repos.d/
done

sudo rm -f /etc/yum.repos.d/Citrix.repo

