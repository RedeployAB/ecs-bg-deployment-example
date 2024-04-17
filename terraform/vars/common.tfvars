# Name of the application
application_name = "hello"

# ECR Repository Nane
ecr_repo_name = "hello"

## Repository configuration for the repository

# URL of the Github repository
github_repo_url = "https://github.com/esgrano-redeploy/hello.git"
# ID of the repository <owner>/<repo>
github_repo_id = "esgrano-evolate/hello"
# SSM path where the Github Token is stored. This is only needed if the repository is private. 
github_token_ssm = "/ecs-bg-deployment-example/github-token"
