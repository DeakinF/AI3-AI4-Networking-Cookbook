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
9. Place secret maker script on server
10. Make an insecure bash shell


# Download a Fedora Workstation VM image
Download a fedora workstation image for you VM server. Install it into the Virtual server host. It only needs a little memory (4GB) and limited CPU
# Boot VM and log onto the console
Boot the VM and log onto the console. You will be disabling SSH access, so it is important that console access is working
# Become root (using sudo)
Open a terminal and become root
```sudo -i```
# Run the firewall configuration script
Download the firewall.sh configuration script to the server from this directory to the server and run it:
``` bash /tmp/firewall.sh```
# Run the Apache configuration script
Download the setup_https_server.sh configuration script to the server from this directory to the server and run it:
``` bash /tmp/setup_https_server.sh```
# Place html and cgi scripts on server
Download the scripts in ./var/www/html to the server's /var/www/html directory and set thier permissions:
```chown apache:apache /var/www/html/*.html
   chmod 644 /var/www/html/*.html
   chmown apache:apache /var/www/cgi-bin/*.cgi
   chmod 755 /var/www/cgi-bin/*.cgi
 ```  
# Place secret maker script on server
Copy the script in this playbook from systemSetup/opt/makesecret.sh to /opt and set permissions
```chown root:root /opt/makesecret.sh
   chmod 700 /opt/makesecret.sh
```

# Make an insecure bash shell
Copy a bash executable and make it setuid and owned by root
```cp -p /bin/bash /bin/bash-insecure
chmod u+s /bin/bash-insecure
chown root:root /bin/bash-insecure
```
# Configure Apache Web Server to Insert Custom Headers
Apache allows you to insert custom headers into HTTP responses using the `Header` directive provided by the `mod_headers` module. 

## Prerequisites
1. Ensure Apache is installed and running on your server.
2. Verify that the `mod_headers` module is enabled:
    ```a2enmod headers
       systemctl restart apache2
    ```

## Edit the Apache Configuration File
Edit /etc/httpd.conf and add the following lines in

## Restart the Apache server
    ```
    systemctl restart apache2
    ```
