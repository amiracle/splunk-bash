#!/bin/bash
aws s3 sync . s3://splunk-bash-install --exclude '.git*' --exclude 'copytos3.sh' --acl public-read
