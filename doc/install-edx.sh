#!/usr/bin/env bash

sudo su root

# update os
sudo apt update -y; sudo apt upgrade -y; sudo reboot

# install edx
export OPENEDX_RELEASE=open-release/ironwood.1 # TODO cannot install this release on ubuntu 16 ec2
export OPENEDX_RELEASE=open-release/hawthorn.2 # pick value from ref. https://edx.readthedocs.io/projects/edx-developer-docs/en/latest/named_releases.html


INSTALL_HOME="$HOME/install-edx"; mkdir -p $INSTALL_HOME
cd $INSTALL_HOME
    echo << EOF > config.yml
# The host names of LMS and Studio. Don't include the "https://" part
EDXAPP_LMS_BASE: "sk.edtek.vn"
EDXAPP_CMS_BASE: "studio.sk.edtek.vn"
EOF

    # install python 3.6.x & upgrade pip
    : ref. https://gist.github.com/namgivu/b6a0bcc4ecc6b71d1a8b11b1d32b218a
    pip install --upgrade pip

    # bootstrap ansible
    wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/ansible-bootstrap.sh -O - | sudo bash

    # randomize passwords
    wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/generate-passwords.sh -O - | bash

    # install open edx
    wget https://raw.githubusercontent.com/edx/configuration/$OPENEDX_RELEASE/util/install/native.sh -O - | bash

cd -
