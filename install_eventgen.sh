#!/bin/bash

#prompt to install event-gen 
echo "Do you want to install the event-gen on your instance?"
read yneventgen
if  [[ "$yneventgen" == *y* ]];then
	#open "https://s3.amazonaws.com/splunk-bash-installs/eventgen-develop.tgz"
    wget https://s3.amazonaws.com/splunk-bash-installs/eventgen-develop.tgz
	echo "Downloaded eventget to $pwd"
#setup eventgen
echo "What is the Splunk instance you want to install the eventget into?"
read splunkhome

tar xzvf eventgen-develop.tgz -C "/opt/splunk/splunk_$splunkhome/etc/apps"
echo "Splunk Eventgen installed."
fi
