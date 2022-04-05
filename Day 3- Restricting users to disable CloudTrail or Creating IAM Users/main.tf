provider "aws" {
  region  = "us-west-2"
}

resource "aws_organizations_policy" "logging" {
  name = "scp_cloudtrail_iam"
  description = "This SCP policy will prevents users to disable CloudTrail logging, Deleting CloudTrail and creating IAM users"
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudtrail:StopLogging",
        "cloudtrail:DeleteTrail",
        "iam:CreateUser"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}