# Readme.md for check_sql_injection.sh Script

## check_sql_injection.sh

This script is designed to detect SQL injection vulnerabilities in a list of URLs. It uses the `bash` programming language and `curl` command to fetch the response from each URL and check for SQL syntax errors in the response.

### How to Use

1. Save the script as `check_sql_injection.sh` in your preferred directory.
2. Create a text file named `urls.txt` and list the URLs you want to test for SQL injection vulnerabilities. Each URL should be on a new line.
3. Open your terminal and navigate to the directory where you saved the script.
4. Run the script by executing the following command:
```bash
bash check_sql_injection.sh urls.txt
```
Replace `urls.txt` with the path to your `urls.txt` file if it's not in the same directory as the script.

### Script Explanation

The script reads the URLs from the `urls.txt` file and performs the following actions for each URL:

1. Split the query string into individual parameters.
2. Append a single quote to each parameter to simulate SQL injection.
3. Fetch the response from the modified URL using `curl`.
4. Check if the response contains any SQL syntax errors.
5. If a SQL syntax error is found, the URL is marked as "Vulnerable" in red color.
6. If no SQL syntax error is found, the URL is marked as "Not vulnerable" in green color.

### Limitations

This script is a basic detection tool and may not cover all possible cases of SQL injection vulnerabilities. It is recommended to use this script as a starting point and perform a thorough manual review and testing to confirm the vulnerability.
