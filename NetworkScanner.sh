#!/bin/bash

# look for given arguement on execution
if [ $# -eq 0 ]
then
	echo "Please specify the target domain.\n"
	echo "Usage:\tbash $0 <domain>" # \t for tab, $0 for first argument of the script (the name of the script)
	exit 1
else
	domain=$1 #identifies domain as the second argument of the script in the command line
fi # fi closes an if statement

# Identify Network range for the specified IP address(es)
function network_range {
	for ip in $ipaddr
	do
		netrange=$(whois $ip | grep "NetRange\|CIDR" | tee -a CIDR.txt)
		cidr=$(whois $ip | grep "CIDR" | awk '{print $2}')
		cidr_ips=$(prips $cidr)
		echo -e "\nNetRange for $ip:"
		echo -e "$netrange"
	done
}

# Ping discovered IP addresses
function ping_host {
	hosts_up=0
	hosts_total=0
	
	echo -e "\nPinging host(s):"
	for host in $cidr_ips
	do
		stat=1
		while [ $stat -eq 1 ]
		do
			ping -c 2 $host > /dev/null 2>&1
			if [ $? -eq 0 ]
			then
				echo "$host is up."
				((stat--))
				((hosts_up++))
				((hosts_total++))
			else
				echo "$host is down."
				((stat--))
				((hosts_total++))
			fi
		done
	done
	
	echo -e "\n$hosts_up out of $hosts_total hosts are up."
}

# Identify IP address
hosts=$(host $domain | grep "has address" | cut -d" " -f4 | tee discovered_hosts.txt)

echo -e "Discovered IP address:\n$hosts\n"
ipaddr=$(host $domain | grep "has address" | cut -d" " -f4 | tr "\n" " ")

echo -e "Options:"
echo -e "\t1) Identify network range of target domain."
echo -e "\t2) Ping discovered hosts."
echo -e "\t3) Perform all checks."i
echo -e "\tq) Exit.\n"

read -p "Choose an Option: " opt

case $opt in
	"1") network_range ;;
	"2") ping_host ;;
	"3") network_range && ping_host ;;
	"q") exit 0 ;;
esac
