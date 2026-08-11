# Nginx Access Log Analyser

A lightweight, dependency-free Bash shell script for parsing and extracting key operational metrics from Nginx access log files.

---

## Overview

Web server logs contain critical data for performance monitoring, troubleshooting errors, and identifying security threats or unusual traffic spikes. 

This project provides an automated log analysis script that processes standard Nginx combined log format files and generates a concise summary report.

---

## Features

The script extracts and summarizes the following metrics:
- **Top 5 IP Addresses**: Identifies the client IP addresses generating the highest volume of traffic.
- **Top 5 Most Requested Paths**: Highlights the most frequently accessed endpoints/URLs.
- **Top 5 HTTP Status Codes**: Summarizes server response codes (e.g., `200`, `404`, `304`, `500`).
- **Top 5 User Agents**: Identifies the primary browsers, bots, crawlers, or uptime probes accessing the server.

---

## Prerequisites

- **Environment**: Linux, macOS, or Windows with WSL / Git Bash.
- **Shell**: `bash` (version 4.0 or higher recommended).
- **Core Utilities**: Standard POSIX tools (`awk`, `grep`, `sort`, `uniq`, `head`, `wc`). No additional package installations required.

---

## Project Structure

```text
project1-nginx-logs-analyser/
├── nginx-logs-analyser.sh   # Main log analysis shell script
├── nginx-access.log.txt     # Sample Nginx access log file
└── README.md                # Project documentation
```

---

## Installation & Usage

### 1. Make the Script Executable
```bash
chmod +x nginx-logs-analyser.sh
```

### 2. Run with the Default Log File
If no argument is passed, the script automatically searches for `nginx-access.log.txt` in the current working directory:
```bash
./nginx-logs-analyser.sh
```

### 3. Run with a Custom Log File
You can pass the path to any Nginx access log file as an argument:
```bash
./nginx-logs-analyser.sh /var/log/nginx/access.log
```

---

## Sample Output

```text
======================================================
          NGINX ACCESS LOG ANALYSIS REPORT            
======================================================
Log File     : nginx-access.log.txt
Total Records: 7605
======================================================

--- [Top 5 IP Addresses with the Most Requests] ---
  178.128.94.113     : 1087 requests
  142.93.136.176     : 1087 requests
  138.68.248.85      : 1087 requests
  159.89.185.30      : 1086 requests
  86.134.118.70      : 277 requests

--- [Top 5 Most Requested Paths] ---
  /v1-health                               : 4560 requests
  /                                        : 270 requests
  /v1-me                                   : 232 requests
  /v1-list-workspaces                      : 127 requests
  /v1-list-timezone-teams                  : 75 requests

--- [Top 5 Response Status Codes] ---
  Status Code 200   : 5740 responses
  Status Code 404   : 937 responses
  Status Code 304   : 621 responses
  Status Code 400   : 260 responses
  Status Code 403   : 23 responses

--- [Top 5 User Agents] ---
  [4347 requests] DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com)
  [513 requests] Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36
  [332 requests] Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36
  [294 requests] Custom-AsyncHttpClient
  [282 requests] Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36

======================================================
                   End of Report                      
======================================================
```

---

## Log Format Compatibility

This script is designed for the standard **Nginx Combined Log Format**:

```text
$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"
```
