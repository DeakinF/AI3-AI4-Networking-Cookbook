#!/bin/bash

# This script automates the installation and configuration of an HTTPS web server on a Fedora workstation.
#
# Functionality:
# 1. Installs the Apache web server and SSL module.
# 2. Generates a private key and a self-signed SSL certificate for secure HTTPS communication. The certificate is stored in the Operating Systems's PKI folder - /etc/pki/tls/private
# 3. Configures Apache to use the generated SSL certificate.
# 4. Starts and enables the Apache service to run on system boot.
#
# Prerequisites:
# - The script must be run with root privileges.
# - OpenSSL must be installed for generating the SSL certificate (comes by default with Fedora).
#
# Usage:
# - Run the script using `sudo bash setup_https_server.sh`.
#
# Notes:
# - The SSL certificate generated is self-signed and valid for 365 days. This is just an example - a real web server would have a properly signed certificate and certificate chain,
#     but that is not the focus of this task, so a self signed file will do

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install Apache web server
echo "Installing Apache web server..."
dnf install -y httpd mod_ssl

# Start and enable Apache service
echo "Starting and enabling Apache service..."
systemctl start httpd
systemctl enable httpd

# Generate a private key and self-signed certificate. 
# Options:
#   - nodes: Do not encrypt the private key
#   - subj: Set the subject to our imaginary company
#   - days: Set the certificate for a year
#   - x509: Save it in PEM format
#   - newkey: Generate a new key
#   - (rsa:2048) : Make the new key an RSA key of length 2048 bytes
echo "Generating private key and self-signed certificate..."
openssl req -newkey rsa:2048 -nodes -keyout /etc/tls/pki/private/apacheserverprivate.key -x509 -days 365 -out /etc/tls/pki/apacheservercert.pem -subj "/C=AU/ST=ACT/L=Canberra/CN=securum.com"

# Configure Apache to use the SSL certificate
echo "Configuring Apache to use the SSL certificate..."
cat <<EOF > /etc/httpd/conf.d/ssl.conf
<VirtualHost *:443>
    ServerName securum.com
    Header Set X-FileRetrieveEndpoint "/cgi-bin/do.cgi"
    Header Set X-CompanyURLCompliance "Strict/XML"
    Header Set X-uriACL "Not For Bob"
    DocumentRoot "/var/www/html"
    SSLEngine on
    SSLCertificateFile /etc/tls/pki/apacheservercert.pem
    SSLCertificateKeyFile /etc/tls/pki/private/apacheserverprivate.key
</VirtualHost>
EOF

# Start and enable Apache service
echo "Starting and enabling Apache service..."
systemctl start httpd
systemctl enable httpd
