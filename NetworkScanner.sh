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
