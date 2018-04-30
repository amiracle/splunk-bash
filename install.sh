#!/usr/bin/env bash
# shellcheck disable=SC1090

# splunk-bash: Simple 
# (c) 2017-2018 splunk-bash
# 
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
directory="/opt/splunk"

# Go get the bash data from the S3 bucket    
curl -k http://splunk-bash-install.s3-website-us-east-1.amazonaws.com/bash >> ~/Downloads/bash

# Backup existing .profile to .orig_profile
mv ~/.profile ~/.orig_profile

# Append your .profile with the bash commands
cat ~/Downloads/bash >> ~/.profile

if [ -d "$directory" ];then
echo "Splunk Home exists"
else
echo "Splunk Home Directory does not exist, please download and install Splunk."
open "https://www.splunk.com/download"
fi
echo "Download complete, shell commands installed. Please restart your terminal session for the changes to take effect."
