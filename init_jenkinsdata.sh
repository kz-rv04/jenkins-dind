#!/bin/bash
echo "PWD: $PWD"

#
# copy
#
cp /repo/install_cert.sh /var/jenkins_home/

#
# change mode
#
chmod +x /var/jenkins_home/install_cert.sh

#
# install cert
#
cd /var/jenkins_home/
/var/jenkins_home/install_cert.sh 2>/dev/null

#
# change user
#
su - jenkins
echo "PWD: $PWD"

#
# configure git proxy
#
git config --global http.https://github.com/.proxy $https_proxy
git config --global http.https://gist.github.com/.proxy $https_proxy
git config --global http.https://dev.azure.com/.proxy $https_proxy

echo "\n===== result ====="
git config --global --list
echo "==================\n"