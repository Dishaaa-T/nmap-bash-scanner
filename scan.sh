

















#!/bin/bash

# Ensure results folder exists
mkdir -p results

echo "Welcome to Simple Nmap Bash Scanner"
read -p "Enter the target IP or domain: " target

# Check for empty input
if [[ -z "$target" ]]; then
    echo "Error: No target entered."
    exit 1
fi

# Timestamp for unique output files
timestamp=$(date +"%Y%m%d_%H%M%S")
filename="results/${target}_${timestamp}_scan.txt"

echo "Scanning host: $target"
echo "Results will be saved in $filename"
echo "Scan started at: $(date)" | tee -a "$filename"

# Ping Scan
echo -e "\n[+] Running Ping Scan..." | tee -a "$filename"
nmap -sn "$target" | tee -a "$filename"

# Port Scan
echo -e "\n[+] Running Full Port Scan..." | tee -a "$filename"
nmap -p- "$target" | tee -a "$filename"

# OS Detection and Service Version
echo -e "\n[+] Running OS Detection and Service Version Scan..." | tee -a "$filename"
nmap -A "$target" | tee -a "$filename"

echo -e "\n[✓] Scan completed at: $(date). Check: $filename"

