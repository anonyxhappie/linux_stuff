###Preboot eXecution Environment Installation
##SERVER -->
#Configure Network:
>--Server-->192.168.202.1/24(static)
>--Client-->192.168.202.2-254/24(DHCP)

#Configure Yum  Repo Via DVD:
>Insert DVD
>mount     //to check
>umount     /dev/sr0
>mount      /dev/sr0      /media
>vi      /etc/yum.conf     or     /etc/yum.repos.d/repo_name.repo
	[001]
	name=server
	baseurl=file:///media/Server
	gpgcheck=0
>yum repolist     //to check

#Install required Packages:
>yum  -y  install  dhcp  tftp-server  syslinux  (httpd  vsftpd  nfs-utils)  system-config-kickstart
>yum  -y  install  dhcp  tftp-server  syslinux  vsftpd  system-config-kickstart






#Configure DHCP server:
default-lease-time 600;
max-lease-time 1200;

allow booting;
allow bootp;
authoritative;

subnet 192.168.202.0 netmask 255.255.255.0{
	range dynamic-bootp 192.168.202.2 192.168.202.254;
	next-server 192.168.202.1; //ip of tftp
	filename "pxelinux.0"
}

>vi   /etc/dhcp/dhcpd.conf
	#	see	/usr/share/doc/dhcp*/dhcpd.conf.sample
>cp	/usr/share/doc/dhcp-4.1.1/dhcpd.conf.sample		/etc/dhcp/dhcpd.conf

>//make changes as above in dhcpd.conf 

#Start DHCP server:
>service dhcpd start		//to start dhcpd
>chkconfig dhcpd on		//start automatic on boot
>chkconfig	--list	dhcpd		//to check if on auto on boot or not



#Configure TFTP server:
>vi	/etc/xinetd.d/tftp
	disable=no		//by default it is disabled
save & exit
>cp	-a	/media/isolinux/*	/var/lib/tftpboot
>mkdir		/var/lib/tftpboot/pxelinux.cfg
>cp	/var/lib/tftpboot/isolinux.cfg		/var/lib/tftpboot/pxelinux.cfg/default
>cp	/usr/share/syslinux/pxelinux.0	/var/lib/tftpboot/

#Start TFTP server:
>service	xinetd		start
>chkconfig	xinetd		on

#Configure FTP server:
>cp	-vr	/media/*	/var/ftp/pub
>vi 	/etc/vsftpd/vsftpd.conf
	//anon_root=/rhel6//just check anonymous user is enabled/yes

#Start FTP server:
>service vsftpd start
>chkconfig	vsftpd		start
 
#Selinux & Firewall off:
>setenforce 0
>system-config-firewall	or 	setup

//Just crosscheck all servers are started & PXE SERVER IS READY..................!!!!
##Client -->
(LAN card must be PXE compatible)
>Set PXE 1st priority or choose from boot order on system start.
>System starts network OS -> Press [TAB]
	extend line -> vmlinuz   initrd=initrd.img   linux   repo=ftp://192.168.202.1/pub
>Complete the installation process.
