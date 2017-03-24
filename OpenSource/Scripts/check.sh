echo "Give Candidate IP : "
read ip
mkdir ~/exam &> /dev/null
scp 192.168.1.$ip:/etc/vsftpd/user_list ~/exam/user_list_$ip &> /dev/null
diff ~/exam/user_list_$ip /etc/vsftpd/user_list &> /dev/null
a=$?
scp 192.168.1.$ip:/etc/vsftpd/ftpusers ~/exam/ftpusers_$ip &> /dev/null
diff ~/exam/ftpusers_$ip /etc/vsftpd/ftpusers &> /dev/null
b=$?
scp 192.168.1.$ip:/etc/vsftpd/vsftpd.conf ~/exam/vsftpd.conf_$ip &> /dev/null
diff ~/exam/vsftpd.conf_$ip /etc/vsftpd/vsftpd.conf &> /dev/null
c=$?
if [ $a -eq 0 ] && [ $b -eq 0 ] && [ $c -eq 0 ]; then
	echo "Pass."
else
	echo "Better Luck Next Time."
fi

