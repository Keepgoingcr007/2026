#!/bin/bash
# Basic user_data script

# Update and install Apache
apt-get update -y
apt-get install -y apache2

# Start Apache
systemctl start apache2
systemctl enable apache2

# Create a simple web page
echo "<h1>Hello from Terraform EC2 Instance</h1>" > /var/www/html/index.html

# Log completion
echo "User data script completed at $(date)" > /var/log/user_data.log