#!/bin/bash
aws ec2 create-tags --resources $1 --tags Key=Name,Value='CloudAdicDevops Public'

