# Answers Check Script
echo "Give Candidate IP : "
read ip
rm -rf /tmp/exam &> /dev/null
mkdir /tmp/exam &> /dev/null
touch /tmp/exam/flogs &> /dev/null
scp 192.168.1.$ip:/etc/vsftpd/user_list /tmp/exam/user_list_$ip &>> /tmp/exam/flogs
diff /tmp/exam/user_list_$ip answers/user_list &>> /tmp/exam/flogs
a=$?
scp 192.168.1.$ip:/etc/vsftpd/ftpusers /tmp/exam/ftpusers_$ip &>> /tmp/exam/flogs
diff /tmp/exam/ftpusers_$ip answers/ftpusers &>> /tmp/exam/flogs
b=$?
scp 192.168.1.$ip:/etc/vsftpd/vsftpd.conf /tmp/exam/vsftpd.conf_$ip &>> /tmp/exam/flogs
diff /tmp/exam/vsftpd.conf_$ip answers/vsftpd.conf &>> /tmp/exam/flogs
c=$?
if [ $a -eq 0 ] && [ $b -eq 0 ] && [ $c -eq 0 ]; then
	echo "Pass."
	exit
fi
grep "ram" /tmp/exam/user_list_$ip &>> /tmp/exam/flogs
a1=$? # 0 for pass
grep "sham" /tmp/exam/user_list_$ip &>> /tmp/exam/flogs
a2=$? # 0 for pass
grep "ram" /tmp/exam/ftpusers_$ip &>> /tmp/exam/flogs
a3=$? # 0 for pass
grep "sham" /tmp/exam/ftpusers_$ip &>> /tmp/exam/flogs
a4=$? # 0 for pass
grep "userlist_deny=NO" /tmp/exam/vsftpd.conf_$ip &>> /tmp/exam/flogs
a5=$? # 1 for pass
if [ $a3 -eq 0 ] && [ $a4 -eq 0 ] || [ $a1 -eq 0 ] && [ $a2 -eq 0 ] && [ $a5 -eq 1 ]; then
	echo "Pass."
else 
	echo "Fail."
fi
