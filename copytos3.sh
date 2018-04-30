#!/bin/bash
aws s3 sync . s3://splunk-bash-install --exclude '.git*'
