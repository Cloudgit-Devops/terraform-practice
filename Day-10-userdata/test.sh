#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<html><body><h1>Userdata through terraform</h1></body></html>" > /var/www/html/index.html
