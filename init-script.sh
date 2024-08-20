#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

yum update -y
yum -y remove httpd
yum install -y httpd

service httpd start
chkconfig httpd on

usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
cd /var/www/html
#curl http://169.254.169.254/latest/meta-data -o index.html
curl 
curl https://raw.githubusercontent.com/hashicorp/learn-terramino/master/index.php -O