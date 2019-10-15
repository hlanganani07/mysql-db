#!/bin/bash

# Install and start docker
sudo yum update -y

sudo amazon-linux-extras install -y docker

sudo service docker start

# Create dev profile for jenkin user  access keys
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region eu-west-1
aws configure set role_arn arn:aws:iam::0123456789:role/OrganizationAccountAccessRole --profile dev
aws configure set source_profile default --profile dev

# Log in to ECR
sudo $(aws ecr get-login --no-include-email --region eu-west-1 --profile dev)

# Pull mysql image from ECR
sudo docker pull 0123456789.dkr.ecr.eu-west-1.amazonaws.com/ec2/mysql:latest

# Setup mysql cnf dir for volume mounting
mkdir -p ~/cfg/mysql/
chown -R ec2-user cfg/
echo "[mysqld]" >> ~/cfg/mysql/my.cnf
echo "bind-address = 0.0.0.0" >> ~/cfg/mysql/my.cnf

# Run mysql docker container
sudo docker run --name mysql-db -d  -p 3306:3306 -v ~/cfg/mysql/:/etc/mysql/  0123456789.dkr.ecr.eu-west-1.amazonaws.com/ec2/mysql:latest
