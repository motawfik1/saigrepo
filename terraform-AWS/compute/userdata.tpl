#!/bin/bash
yum install https -y
echo "firewall subnet: ${fw_subnets}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on