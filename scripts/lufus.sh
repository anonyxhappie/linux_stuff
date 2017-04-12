#!/bin/bash
## This is simple script to Create USB Media bootable 
## By - Akshay Saini (anonyxhappie)
echo "##Bootable USB Creater##"
echo "ISO Image Absolute Path :"
read ipath
upath=/dev/sdb1

umount $upath &> /dev/null
mkfs.vfat $upath &> /dev/null
ls -l ipath &> /dev/null
if [ $? -eq 0 ]; then
	mkdir -p /mnt/iso /mnt/usb &> /dev/null
	mount -o loop $ipath /mnt/iso &> /dev/null
	mount $upath /mnt/usb &> /dev/null
	cp -var /mnt/iso/* /mnt/usb/ &> /dev/null
	umount /mnt/iso &> /dev/null
	umount /mnt/usb &> /dev/null
	rm -rf /mnt/iso /mnt/usb &> /dev/null
else
	echo "LoL! No Bootable Image Found." 
	exit
fi
echo "You've Successfully Booted USB Media."
## exit
