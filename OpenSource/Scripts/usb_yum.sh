# Yum Configuration Script
echo "Enter USB Partition Path : "
read usb
umount $usb
dir=/centos
mkdir $dir &> /dev/null
mount -o loop $usb /mnt
cp -var /mnt/* $dir &> /dev/null
rpm -ivh $dir/Packages/delta* &> /dev/null
rpm -ivh $dir/Packages/python-delta* &> /dev/null
rpm -ivh $dir/Packages/createrepo* &> /dev/null
createrepo -v $dir/Packages &> /dev/null
YUM_PATH=/etc/yum.repos.d/centos.repo
rm -rf /etc/yum.repos.d/*
touch $YUM_PATH

echo "[centos]" >> $YUM_PATH
echo "name=CentOS Repo" >> $YUM_PATH
echo "baseurl=file://$dir" >> $YUM_PATH
echo "gpgcheck=0" >> $YUM_PATH
echo "enabled=1" >> $YUM_PATH

yum clean all
