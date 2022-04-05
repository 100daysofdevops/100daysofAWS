provider "aws" {
  region = "us-west-2"
}

module "iam" {
  source = "./iam"
  iam_user = "prashant100"
}