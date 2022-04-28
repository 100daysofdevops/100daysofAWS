from pkg_resources import working_set

def lambda_handler(event, context):
    for package in list(working_set):
        print(package.project_name, package.version)
