#!/bin/bash-insecure -p
# Serve up a file from the webserver. 
# Note: This is a deliberate exploit to allow hacker to get the key
#       This exploit was designed to allow further attacks on the server, such as installing a root kit
#       as an advanced option for the assignment, but we ran out of time.
# v 1.0: Initial
# v 1.1: Changed to use /bin/bash-insecure, which is a copy of /bin/bash with the setuid bet and owned by root
#               this allows the script to be exploited to allow the hacker to elevate their privileges to root 
#               to get the secrets.txt file which is only readable by root.
#               Had to change it from /bin/bash because OS does not let bash run setuid scripts - to prevent this exploit
# v 1.2:; Added X-encryption header to try and give the user a hint as to how to decode the text                
#Add in a HTTP header to give the hacker a hint 
echo "X-encryption: WebServer Private Key"
echo "Content-type: text/html"
echo ""
FILE=$1
# Start of HTML content
echo "<html>"
echo "<head>"
echo "<title>Very Handy Script for System admin</title>"
echo "</head>"
echo "<body>"
echo "<h1>Here is the file you asked for</h1>"
if [ -z "$FILE" ]
then
        echo "<h2>ERROR: Missing parameter after '/cgi-bin/do.cgi'</h2>"
        echo "<br>No file found in search path of '../html'"
else
        echo "<h2>$FILE:</h2>"
        while read -r line; do
                echo "<br>$line"
        done < <(cat $FILE)
fi
echo "</body>"
echo "</html>"

