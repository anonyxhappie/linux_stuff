#!/bin/bash
echo "Installation Media :"
echo "1. Linux"
echo "2. Windows"
read option
echo "Image Path :"
read ipath
echo "USB Path :"
read upath

umount $upath &> /dev/null
mkfs.vfat $upath &> /dev/null
if [ $option -eq 1 ]; then
	dd if=$ipath of=$upath bs=4M &> /dev/null	
elif [ $option -eq 2 ]; then
	mkdir -p /mnt/iso /mnt/usb &> /dev/null
	mount -o loop $ipath /mnt/iso &> /dev/null
	mount $upath /mnt/usb &> /dev/null
	cp -var /mnt/iso/* /mnt/usb/ &> /dev/null
	umount /mnt/iso &> /dev/null
	umount /mnt/usb &> /dev/null
else
	echo "You Must be a Kid." 
	exit
fi
echo "You've successfully booted your USB."
