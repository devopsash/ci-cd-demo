#!/bin/bash

# DNS IP details file
dns_file="dns_ipdetails.yml"

# List of target IP addresses and corresponding DNS services
declare -A target_ips=(
    ["192.168.30.22"]="tftp.test.com"
    ["10.30.221.111"]="tftp.test.com"
    # Add more IP-DNS pairs here as needed
)

# Read the dns_ipdetails.yml file
while IFS= read -r line; do
    # Extract the DNS and IP details
    if [[ "$line" =~ ([a-zA-Z_]+)\ has\ service\ ([a-zA-Z0-9.-]+):\ ([0-9.]+) ]]; then
        dc="${BASH_REMATCH[1]}"
        service="${BASH_REMATCH[2]}"
        ip="${BASH_REMATCH[3]}"
        
        # Check if the IP matches any target IP and DNS pair
        for target_ip in "${!target_ips[@]}"; do
            if [[ "$ip" == "$target_ip" && "$service" == "${target_ips[$target_ip]}" ]]; then
                echo "$dc running with: $service"
            fi
        done
    fi
done < "$dns_file"
