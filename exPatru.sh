#!/bin/bash

cat /etc/hosts | while read line; do
	IP=$(echo "$line" | awk '{print $1}')
	name=$(echo "$line" | awk '{print $2}')
	[ "$IP" = "" ] && break
	echo "$IP $name"
	nslookup "$name" 8.8.8.8 | while read line2; do
		NIP=$(echo "$line2" | awk '/Address: / {print $2}')
		[ "$NIP" != "$IP" -a -n "$NIP" ] && echo "You are wrong about $name"
		[ -n "$NIP" ] && break
	done
done
