#!/bin/bash

# Performing the git clone
function git_update() {
 cd /tmp

if [ -d 100daysofAWS ]
then
  cd 100daysofAWS
  git pull
else
  git clone https://github.com/100daysofdevops/100daysofAWS.git
  cd 100daysofAWS
fi
}

function check_aws_credentials(){

AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)

  if [ -z $AWS_ACCOUNT ]; then
     exit 1
  fi
}

# Executing terraform commands init, plan and apply

function terraform_release {
  cd 100daysofAWS
  echo "=========================="
  echo "Executing Terraform Init"
  echo "=========================="
  terraform init

  if [ $? != 0 ]; then
     echo "Terraform init failed with an error"
     exit 1
  fi
  sleep 5
  echo "=========================="
  echo "Executing Terraform Plan"
  echo "=========================="
  sleep 2
  terraform plan -out=terraform.plan

  if [ $? != 0 ]; then
     echo "Terraform plan failed with an error"
     exit 1
  fi

  terraform plan -lock=false -out=terraform.plan
  echo "Do you wish to proceed with Terraform deployment"
  select choice in "Yes" "No"; do
    case $choice in
        Yes ) echo "Executing Terraform Apply \n";echo "==========================\n"; terraform apply terraform.plan;rm -f terraform.plan; break;;
        No ) rm -f terraform.plan;exit;;
    esac
  done
}


git_update
check_aws_credentials
terraform_release
