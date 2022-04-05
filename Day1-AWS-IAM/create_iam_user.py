import boto3
import logging
from botocore.exceptions import ClientError

logger = logging.getLogger(__name__)
iam = boto3.resource('iam')

def create_iam_user(user_name):
    """
    The newly created IAM user doesn't have any policy attached to it
    """
    try:
        user = iam.create_user(UserName=user_name)
        logger.info("Create IAM user %s", user_name)
    except:
        logger.exception("Couldn't create an IAM user %s", user_name)
        raise
    else:
        return user


def attach_policy(user_name, policy_arn):
    """
    Attaches an IAM policy to a user.
    """
    try:
        iam.User(user_name).attach_policy(PolicyArn=policy_arn)
        logger.info("Attached IAM policy %s to user %s.", policy_arn, user_name)
    except ClientError:
        logger.exception("Couldn't attach IAM policy %s to user %s.", policy_arn, user_name)
        raise

def main():
    create_iam_user(user_name="plakheraiamnew")
    attach_policy(user_name="plakheraiamnew", policy_arn="arn:aws:iam::aws:policy/AdministratorAccess")


if __name__ == '__main__':
    main()







