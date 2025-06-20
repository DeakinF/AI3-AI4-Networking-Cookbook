# Setting up a system for the challenge
This document describes how to set up a system for the challenge

# Overview
1. Download a Fedora Workstation VM image
2. Boot VM and log onto the console
3. Become root (using sudo)
4. Run the firewall configuration script
5. Run the Apache configuration script
6. Configure Apache Web Server to Insert Custom Headers
7. Place html and cgi scripts on server
8. Place secret maker script on server


# Download a Fedora Workstation VM image
# Boot VM and log onto the console
# Become root (using sudo)
# Run the firewall configuration script
# Run the Apache configuration script
# Configure Apache Web Server to Insert Custom Headers
# Place html and cgi scripts on server
# Place secret maker script on server
# Configuring Apache Web Server to Insert Custom Headers

Apache allows you to insert custom headers into HTTP responses using the `Header` directive provided by the `mod_headers` module. 

## Prerequisites
1. Ensure Apache is installed and running on your server.
2. Verify that the `mod_headers` module is enabled:
    ```a2enmod headers
       systemctl restart apache2
    ```

## Edit the Apache Configuration File
Edit /etc/httpd.conf and add the following lines in..

## Restart the Apache server
    ```systemctl restart apache2
    ```

