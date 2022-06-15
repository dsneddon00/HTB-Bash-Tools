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
