#!/bin/bash


var="8dm7KsjU28B7v621Jls"
value="ERmFRMVZ0U2paTlJYTkxDZz09Cg"

for i in {1..40}
do
        var=$(echo $var | base64)
		#echo "$var"		
		if [[ "$var" =~ "$value" ]]
		then
			echo -e "Var contains value"
			echo -e $var # then use 'tail -c 20' to get the answer to the question
		#else
			#echo -e "Var does not contain value"
		fi
		
		# other thing I tried
		#case $value in

  		#	*"$var"*)
    		#	echo -n "It's there."
    		#	;;
		#esac
done
