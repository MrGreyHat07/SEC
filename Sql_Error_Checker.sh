#!/bin/bash

# Usage: bash check_sql_injection.sh urls.txt

URL_FILE=${1?Pass the URL file as a parameter!}

while read -r url; do
    # Split the query string into individual parameters
    IFS='&' read -ra params <<< "$url"
    
    # Append a single quote to each parameter
    modified_url=""
    for param in "${params[@]}"; do
        modified_url+="${param}'&"
    done

    # Remove the trailing '&' character
    modified_url="${modified_url%&}"
    
    # Fetch the response using curl
    response=$(curl -s "$modified_url")

    # Check if the response contains SQL syntax error
    if [[ $response == *"SQL error"* || $response == *"SQL syntax"* ]]; then
        echo -e "\e[31mVulnerable: $url\e[0m"  # Red color for vulnerable URLs
    else
        echo -e "\e[32mNot vulnerable: $url\e[0m"  # Green color for non-vulnerable URLs
    fi
done < "$URL_FILE"

