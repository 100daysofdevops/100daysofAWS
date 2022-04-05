# Enter the IAM username you want to create

read -r -p "Enter IAM username": username

# Using AWS CLI to create IAM user

aws iam create-user --user-name "${username}" --output json > /dev/null

# Creating Access Key and Secret Access key

aws_credentials=$(aws iam create-access-key --user-name "${username}" --query 'AccessKey.[AccessKeyId,SecretAccessKey]'  --output text)

# Getting the access_key and secret_key
access_key=$(echo ${aws_credentials} |awk '{print $1}')
secret_access_key=$(echo ${aws_credentials} |awk '{print $2}')

# Display the username, access_key and secret_access_key
echo "The IAM user "${username}" has been created"
echo "The access key id of ${username} is $access_key"
echo "The secret access key id of ${username} is $secret_access_key"

#Generating Random Password for the user
gen_random_pass() {
  head -c 9 /dev/urandom | uuencode -m - | head -2 | tail -1 |  tr '1IlO0' '$/%&#'
}

#Attaching an IAM Policy to the user
aws iam attach-user-policy --user-name="$username" --policy-arn=arn:aws:iam::aws:policy/AdministratorAccess

#To create a user and assign random password to it
user_password=$(gen_random_pass)
aws iam create-login-profile --user-name="$username" --password="$user_password" --password-reset-required > /dev/null

# Displaying the user password
echo "The IAM user "${username}" has been created with passowrd $user_password"