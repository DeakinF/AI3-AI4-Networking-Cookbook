#!/bin/bash
#File to make the secret.txt flag file. The secret.txt file will:
#	- Be created in /var/www/html/secret.txt
#	- Be owned by root
#	- Be only readable by root
#	- Be unreadable by apache, the owner which runs the webserver
#	- Be encrypted (signed) by the webserver private key
#	- Be encoded into base64 so the user can see the file, and he web server can serve it up as text
#	- Has an associated check sum file which can be checked to see if someone has the secret
#Accepts one parameter - a string to make the secret
#Example calling:
#	makesecret.sh "This is my flag"	

#Version
# 1.0: Initial cut
# 1.1 Added check sum file
#

###Globals
## Constants
#Exit Codes returned by script
RET_ALL_OK=0 		#Exit code of 0 means success
ERR_STRING_NOT_SET=1 	#Scripted called incorrectly - missing parameter

#Where to write the secret file to
SECRET_FILE=/var/www/html/secret.txt

SECRET_OWNER=root
SECRET_GROUP=root

PRIVATE_KEY="/etc/pki/tls/private/apache-selfsigned.key"

#File to hold check sum of secret so it can be checked
CHECKSUM_FILE="/var/www/html/secret.cksum"

#Set a variable for the return code. A zero means success, so start success
return_code=$RET_ALL_OK

#Functions
#Write information out
function info() {
	info_str="$1"
	date_str=`date`
	echo "$date_str: [INFO] $info_str"
}

#Write error out and set a error code
function error() {
	error_str="$1"
	code_val="$2"
	date_str=`date`
	#Send error to Standard error
	echo "$date_str: [ERROR] $error_str" >&2
	#Set return code to supplied code, or 1
	if [ -z "$code_val" ]; then
		return_code=1
	else
		return_code=$code_val
	fi
}

#Show how to call script
show_usage() {
	info "Makes a secret file at $SECRET_FILE from the string supplied on the command line"
	info "Encrypts the string with the private key at $SECRET_KEY"
	info "Makes the file only accessable by root"
	info "Run by:"
	info "		$0 \"Secret String\""
	info "Returns 0 on success"
}

secret_string="$1"
if [ ! -z "$secret_string" ]; then
	info "Secret will be: \"$secret_string\""
	info "Will write secret to \"$SECRET_FILE\""
	info "Will be owned by \"$SECRET_OWNER:$SECRET_GROUP"
else
	error "Need to set a string" $ERR_STRING_NOT_SET
	show_usage
	exit $return_code
fi

info "Encrypting secret"
echo "$secret_string" | openssl pkeyutl  -sign -inkey $PRIVATE_KEY   | openssl enc -a -out $SECRET_FILE
chown $SECRET_OWNER:$SECRET_GROUP $SECRET_FILE
chmod 600 $SECRET_FILE

info "File permissions: `ls -l $SECRET_FILE`"
info "File encrypted contents:" 
echo
cat $SECRET_FILE

info "Check sum is being written to $CHECKSUM_FILE"
echo "$secret_string" | cksum > $CHECKSUM_FILE
info "Check sum is `cat $CHECKSUM_FILE`"
chown $SECRET_OWNER:$SECRET_GROUP $CHECKSUM_FILE
chmod 644 $CHECKSUM_FILE

exit $return_code

