# Answers Check Script
echo "Give Candidate IP : "
read ip
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
grep "#root" /tmp/exam/user_list_$ip &>> /tmp/exam/flogs
a=$?
grep "#root" /tmp/exam/ftpusers_$ip &>> /tmp/exam/flogs
b=$?
grep "root" /tmp/exam/user_list_$ip &>> /tmp/exam/flogs
c=$?
grep "root" /tmp/exam/ftpusers_$ip &>> /tmp/exam/flogs
d=$?
if [ $a -eq 0 ] || [ $c -eq 1 ] && [ $b -eq 0 ] || [ $d -eq 1 ]; then
        echo "Pass."
else
        echo "Fail."
fi

