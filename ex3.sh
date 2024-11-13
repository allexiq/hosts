#!/bin/bash

cat /etc/hosts | while read line; do
	if [ -z  "$line" ]; then
		continue
	fi
ip=`echo "$line" | awk '{print $1}'`
domain=`echo "$line" | awk '{print $2}'`
ns_ip=`nslookup "$domain" | grep 'Address' | awk '{print $2}'`

if [ "$ip" != "$ns_ip"]; then
	echo "Bogus IP for $domain in /etc/hosts!"
fi 
done 
