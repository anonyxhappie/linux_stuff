# Yum Configuration Script
# echo "Enter Server IP"
# read serverip
serverip=192.168.1.5

rm -rf /etc/yum.repos.d/*

YUM_PATH=/etc/yum.repos.d/centos.repo
touch $YUM_PATH

echo "[centos]" >> $YUM_PATH
echo "name=CentOS Repo" >> $YUM_PATH
echo "baseurl=ftp://$serverip/pub/centos" >> $YUM_PATH
echo "gpgcheck=0" >> $YUM_PATH
echo "enabled=1" >> $YUM_PATH

yum clean all
