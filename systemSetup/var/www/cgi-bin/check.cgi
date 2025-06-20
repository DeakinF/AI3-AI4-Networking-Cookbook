#!/bin/bash -x
SECRET_FILE="/var/www/html/secret.cksum"

#Function
#Decode URL post data - from web
urldecode() {
  local url_encoded="${1//+/ }"
  printf '%b' "${url_encoded//%/\\x}"
}
echo "Content-type: text/html"
echo ""

echo "<html>"
echo "<head><title>Check result</title></head>"
echo "<body>"

if [ "$REQUEST_METHOD" = "POST" ]; then
    # Read POST data from stdin
    read -n "$CONTENT_LENGTH" POST_DATA
    # Parse POST_DATA (e.g., using a similar approach to QUERY_STRING or a dedicated function)
    IFS='&' read -ra PAIRS <<< "$POST_DATA"
    for PAIR in "${PAIRS[@]}"; do
        KEY=$(echo "$PAIR" | cut -d'=' -f1)
        VALUE=$(echo "$PAIR" | cut -d'=' -f2-)
	VALUE=$(urldecode "$VALUE")
            # You might need to add URL decoding here for proper values
            echo "<p><strong>$KEY:</strong> $VALUE</p>"
        done
    GUESS_CHECK=`echo $VALUE | cksum`
    SECRET_SUM=`cat $SECRET_FILE`
    if [ "$GUESS_CHECK" == "$SECRET_SUM" ]; then
	    echo "<p><strong>Well done!</strong></p>"
    else
	    echo "<p><strong>Not yet!</strong></p>"
    fi


else
    echo "<p>Unsupported request method.</p>"
fi

echo "</body>"
echo "</html>"

