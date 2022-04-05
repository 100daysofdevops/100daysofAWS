resource "aws_organizations_policy" "specific-region" {
  name = "allow-access-to-specific-region"

  content = <<CONTENT
{
"Sid": "DenyAllOutsideOregonandVirginia",
			"Effect": "Deny",
			"NotAction": [
				"ec2:*",
				"s3:*"
			],
			"Resource": [
				"*"
			],
			"Condition": {
				"StringNotEquals": {
					"aws:RequestedRegion": [
						"us-west-2",
						"us-east-1"
					]
				}
			}
		}
CONTENT
}