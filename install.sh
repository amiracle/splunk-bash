#!/usr/bin/env bash
# shellcheck disable=SC1090

# splunk-bash: Simple 
# (c) 2017-2018 Pi-hole, LLC (https://pi-hole.net)
# Network-wide ad blocking via your own hardware.
#
# Installs splunk-bash
#
# This file is copyright under the latest version of the Apache2.
# Please see LICENSE file for your rights under this license.

# 
#
# Install with this command (from your Linux machine):
#
# curl -sSL https://bit.ly/splunk-bash | bash

# First, let's make sure you have the proper directory and variables set
directory=/opt/splunk2

if [ -d "$directory" ];then
echo "Splunk Home exists"
else
echo "Splunk Home Directory does not exist, do you want to download Splunk? [Y/N]:"
read yesnodir
    if [[ "$yesnodir" == *y* ]];then
            open "https://www.splunk.com/download"
    fi
# Go get the bash data from the S3 bucket    
curl -k http://splunk-bash-install.s3-website-us-east-1.amazonaws.com/bash >> ~/Downloads/bash

# Append your .profile with the bash commands
cat ~/Downloads/bash >> ~/.profile
