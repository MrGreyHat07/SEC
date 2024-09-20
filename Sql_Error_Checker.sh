#!/bin/bash
echo -e "\033[4m\033[35m ░▒▓███████▓▒░ ░▒▓████████▓▒░  ░▒▓██████▓▒░  
░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░        ░▒▓█▓▒░        ░▒▓█▓▒░        
 ░▒▓██████▓▒░  ░▒▓██████▓▒░   ░▒▓█▓▒░        
       ░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░        
       ░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓███████▓▒░  ░▒▓████████▓▒░  ░▒▓██████▓▒░  
                                             
                                             

\033[0m"
echo -e "\033[32mAuthor: Deepak Rawat\033[0m"  # Green author's name

# Usage: bash check_sql_injection.sh urls.txt

URL_FILE=${1?Pass the URL file as a parameter!}

while read -r url; do
    # Split the query string into individual parameters
    IFS='&' read -ra params <<< "$url"
    
    # Initialize a flag to track vulnerability
    is_vulnerable=false
    
    # Iterate through each parameter
    for ((i = 0; i < ${#params[@]}; i++)); do
        # Construct the modified URL with only the current parameter
        modified_url=""
        for ((j = 0; j <= i; j++)); do
            modified_url+="${params[j]}'&"
        done
        modified_url="${modified_url%&}"
        
        # Fetch the response using curl
        response=$(curl -s "$modified_url")

        # Check if the response contains SQL syntax error
        if [[ $response == *"SQL error"* || $response == *"SQL syntax"* || $response == *"mysql"* || $response == *"sql"* ]]; then
            is_vulnerable=true
            break
        fi
    done

    # Print the result
    if $is_vulnerable; then
        echo -e "\e[31mVulnerable: $url\e[0m"  # Red color for vulnerable URLs
    else
        echo -e "\e[32mNot vulnerable: $url\e[0m"  # Green color for non-vulnerable URLs
    fi
done < "$URL_FILE"
