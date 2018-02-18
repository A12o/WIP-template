#!/usr/bin/env bash

# assuming Internet g/w / nat g/w bound to subnets
# openssl genrsa -out a12o-poc.pem 2048

export AWS_KEY_NAME=a12o-poc.pem

# I'm being specific here as I work with 5 different AWS accts on this Mac
export AWS='aws --profile default'

openssl rsa -in $AWS_KEY_NAME -pubout > ${AWS_KEY_NAME/pem/tmp}
tr -d "\n" < ${AWS_KEY_NAME/pem/tmp} | tr -s '\-\-\-\-\-' ':' | cut -d ':' -f3 > ${AWS_KEY_NAME/pem/pub}

$AWS ec2 import-key-pair --key-name ${AWS_KEY_NAME/\.pem/}  --public-key-material $(cat ${AWS_KEY_NAME/pem/pub})

$AWS ec2 create-security-group --group-name a12o-poc --description "a12o-poc SSH group"
$AWS ec2 authorize-security-group-ingress --group-name a12o-poc --protocol tcp --port 22 --cidr 0.0.0.0/0
$AWS ec2 authorize-security-group-ingress --group-name a12o-poc --protocol tcp --port 80 --cidr 0.0.0.0/0


$AWS ec2 run-instances --image-id ami-c5062ba0 --instance-type t2.micro --count 1 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=a12o-POC}, {Key=Owner,Value=a12o}]' --key-name ${AWS_KEY_NAME/\.pem/} --security-groups "a12o-poc" --user-data file://poc.txt


echo "Public and Private URL of web page"

$AWS ec2 describe-instances  --filter "Name=tag:Name,Values=a12o-POC" | grep -m 1 PublicDnsName | awk '{print $2}'
$AWS ec2 describe-instances  --filter "Name=tag:Name,Values=a12o-POC" | grep -m 1 PrivateDnsName | awk '{print $2}'

echo "​Alternate Public and Private URL of web page using jq"

$AWS ec2 describe-instances  --filter "Name=tag:Name,Values=a12o-POC" | jq '.Reservations[].Instances[].PublicDnsName'
$AWS ec2 describe-instances  --filter "Name=tag:Name,Values=a12o-POC" | jq '.Reservations[].Instances[].PrivateDnsName'

echo "SSH Username is ec2-user and the private key is $AWS_KEY_NAME"
