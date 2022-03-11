#!/bin/bash

# Script to install terraform
# Script must need to run as root user
if [[ $EUID -ne 0 ]]
then
  echo "You must be root user in order to execute this script"
  exit 1
fi
# Script is tested only with
if cat /etc/*release | grep ^NAME | grep Ubuntu
then
  echo "Ubuntu operating system"
else
  echo "This script is only tested in Ubuntu operating, exiting..."
  exit 1
fi

# Updating all the system packages
apt-get update

# Checking if curl and jq installed on the system
which curl 2>/dev/null || { apt-get install -y curl; }
which jq 2>/dev/null || { apt-get install -y jq; }

# Terraform Installation of version 1.1.7

function terraform_installation(){

  if which terraform 2>/dev/null
  then
    echo "Terraform is already installed in this system"
  else
    Terraform_1_1_7_Ver="$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n -k 5,5n | egrep '1.1.7' |egrep -v 'rc|beta' | egrep 'linux.*amd64'|head -1)"
    curl -sL ${Terraform_1_1_7_Ver} > /tmp/terraform.zip
    unzip /tmp/terraform.zip
    cp terraform /usr/local/bin
    echo "Verifying the terraform version"
    terraform version
  fi
}
