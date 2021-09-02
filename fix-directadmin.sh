#!/bin/sh
rm -rf /etc/sysconfig/network-scripts/ifcfg-lo:1000
ifconfig lo:1000 176.99.3.34 netmask 255.255.255.0 up;
echo 'DEVICE=lo:1000' >> /etc/sysconfig/network-scripts/ifcfg-lo:1000;
echo 'IPADDR=176.99.3.34' >> /etc/sysconfig/network-scripts/ifcfg-lo:1000;
echo 'NETMASK=255.255.255.0' >> /etc/sysconfig/network-scripts/ifcfg-lo:1000;
echo 'ONBOOT=yes' >> /etc/sysconfig/network-scripts/ifcfg-lo:1000;
echo 'BOOTPROTO=none' >> /etc/sysconfig/network-scripts/ifcfg-lo:1000;
/usr/bin/perl -pi -e 's/^ethernet_dev=.*/ethernet_dev=lo:1000/' /usr/local/directadmin/conf/directadmin.conf;
service network restart;
service directadmin stop;
rm -rf /etc/cron.d/directadmin_cron;
rm -rf /usr/local/directadmin/conf/license.key;
/usr/bin/wget -O /usr/local/directadmin/conf/license.key http://da.trongtri.com/license.key;
chmod 600 /usr/local/directadmin/conf/license.key;
chown diradmin:diradmin /usr/local/directadmin/conf/license.key;
cd /usr/local/directadmin;
wget --no-check-certificate -O update.tar.gz 'http://da.trongtri.com/1624/update.tar.gz';
tar xvzf update.tar.gz;
./directadmin p;
cd /usr/local/directadmin/scripts;
./update.sh;
service directadmin restart;
find . -name "downgrade1.62.4.sh" -delete;
if [ -s /usr/local/directadmin/conf/directadmin.conf ]; then
	echo "================================================"
	echo "Downgrade DirectAdmin 1.62.4 thanh cong";
	echo "TUYET DOI khong nen cap len DA 1.62.5"
	echo "Licsense su dung den nam 2038"
	echo "================================================"
fi

printf \\a
sleep 1
printf \\a
sleep 1
printf \\a
