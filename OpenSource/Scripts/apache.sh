setenforce 0 &> /dev/null
touch /tmp/ip
ifconfig eth0 | grep Bcast | awk '{ print $2 }' | awk -F ":" '{ print $2 }' > /tmp/ip
echo "$ip www.anonyx.local" >> /etc/hosts
hostname www.anonyx.local
yum install -y httpd* &> /dev/null

mkdir /var/www/html/anonyx &> /dev/null
touch /var/www/html/anonyx/index.html
echo "<center><h1>Web Server is working correctly.</h1></center>" > /var/www/html/anonyx/index.html

HTTPD_PATH=/etc/httpd/conf/httpd.conf

echo "<VirtualHost *:80>" >> $HTTPD_PATH
echo "ServerAdmin root@www.anonyx.local" >> $HTTPD_PATH
echo "DocumentRoot /var/www/html/anonyx" >> $HTTPD_PATH
echo "ServerName www.anonyx.local" >> $HTTPD_PATH
echo "</VirtualHost>" >> $HTTPD_PATH

service httpd restart &> /dev/null
firefox www.anonyx.local & &> /dev/null
