# Answers Check Script
echo "Give Candidate IP : "
read ip
touch /logs &> /dev/null
mkdir ~/exam &>> /logs
scp 192.168.1.$ip:/etc/vsftpd/user_list ~/exam/user_list_$ip &>> /logs
diff ~/exam/user_list_$ip ~/answers/user_list &>> /logs
a=$?
scp 192.168.1.$ip:/etc/vsftpd/ftpusers ~/exam/ftpusers_$ip &>> /logs
diff ~/exam/ftpusers_$ip ~/answers/ftpusers &>> /logs
b=$?
scp 192.168.1.$ip:/etc/vsftpd/vsftpd.conf ~/exam/vsftpd.conf_$ip &>> /logs
diff ~/exam/vsftpd.conf_$ip ~/answers/vsftpd.conf &>> /logs
c=$?
if [ $a -eq 0 ] && [ $b -eq 0 ] && [ $c -eq 0 ]; then
	echo "Pass."
	exit
fi
grep "#root" ~/exam/user_list_$ip &>> /logs
a=$?
grep "#root" ~/exam/ftpusers_$ip &>> /logs
b=$?
grep "root" ~/exam/user_list_$ip &>> /logs
c=$?
grep "root" ~/exam/ftpusers_$ip &>> /logs
d=$?
if [ $a -eq 0 ] || [ $c -eq 1 ] && [ $b -eq 0 ] || [ $d -eq 1 ]; then
	echo "Pass."
else 
	echo "Fail."
fi
