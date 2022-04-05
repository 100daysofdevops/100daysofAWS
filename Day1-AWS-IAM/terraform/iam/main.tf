resource "aws_iam_user" "newuser" {
  name = var.iam_user
}

resource "aws_iam_access_key" "accesskey" {
  user = aws_iam_user.newuser.name
}

resource "aws_iam_user_policy" "userpolicy" {
  name = "s3fullaccess"
  user = aws_iam_user.newuser.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}