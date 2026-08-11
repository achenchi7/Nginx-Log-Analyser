#!/bin/bash

# Nginx Access log analyser
LOG_FILE="${1:-nginx-access.log.txt}"

echo "NGINX ACCESS LOG ANALYSIS REPORT"

echo "Log File : $LOG_FILE"
echo "Total Records: $(wc -l < "$LOG_FILE")"

# Top 5 IP addresses with the most requests
echo "---[Top 5 IP addresses with the most requests]---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5 | \
awk '{printf " %-18s : %s requests\n", $2, $1}'
echo ""

# Top 5 most requested paths
echo "---[Top 5 most requested paths]---"
awk -F'"' '{print $2}' "$LOG_FILE" | awk '{print $2}' | grep -v '^$' | sort | uniq -c | sort -nr | head -n 5 | \
awk '{printf "  %-40s : %s requests\n", $2, $1}'
echo ""

# ------------------------------------------------------------------------------
# 3. Top 5 response status codes
# ------------------------------------------------------------------------------
echo "--- [Top 5 Response Status Codes] ---"
awk -F'"' '{print $3}' "$LOG_FILE" | awk '{print $1}' | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr | head -n 5 | \
awk '{printf "  Status Code %-5s : %s responses\n", $2, $1}'
echo ""

# ------------------------------------------------------------------------------
# 4. Top 5 user agents
# ------------------------------------------------------------------------------
echo "--- [Top 5 User Agents] ---"
awk -F'"' '{print $6}' "$LOG_FILE" | grep -v '^$' | sort | uniq -c | sort -nr | head -n 5 | \
while read -r count agent; do
  printf "  [%s requests] %s\n" "$count" "$agent"
done
echo ""

echo "======================================================"
echo "                   End of Report                      "
echo "======================================================"
