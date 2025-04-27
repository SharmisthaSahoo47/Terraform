#! bin/bash
sudo su -
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1> Welcome to Sharmistha's page through Terraform </h1>" > /var/www/html/index.html
 