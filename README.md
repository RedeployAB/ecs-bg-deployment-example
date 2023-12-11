# ECS Blue/Green Deployment Example

This repository shows how to deploy an ECS service using blue/green deployment via Terraform.


## Description

This is just an example and can be adapted for your purpose.

In order to deploy the full example you also need to clone the [Hello repository](https://github.com/esgrano-evolate/hello) which is where the code for our service is stored.

For more details please see the diagram [here](#architecture)

### How it works

When a change is pushed to git in the `hello` repository CodePipeline trigger the Build stage, using Codebuild, which build and push the docker image to ECR.

Once the Build stage is completed, the deploy stage runs a Blue/Green deployment to ECS via CodeDeploy.
The service is deployed to the green Target Group and when it is completed it automatically switches traffic from the ALB to the latter.

## Architecture

![Diagram](/assets/ecs-blue-green.drawio.png)

## Terraform

The code in this repository will deploy the following components:
- **ECS Task Definition**: which is the blueprint of our service
- **ECS Service**: the actual impelmentation of our service on ECS/Fargate, including the ALB and the two target group (blue and green)
- **AWS CodeBuild**: to build the docker image and push to ECR
- **AWS CodeDeploy**: to deploy the service on ECS using a blue/green deployment strategy
- **AWS CodePipeline**: to orchestrate the build and the deployment

Each terraform module creates all required resources for the components above, such as IAM roles, security groups, etc.
Under each module folder you can find a README to describe all resources that will be created, input variables and outputs if any.

## Deploy

### Prerequisites

- ECS Cluster
- Artifact bucket
- An SSM Parameter to store the Github token if your application is in a private git repository

### Variables

To store your terraform variables you can create a `terraform.tfvars` like the following:

```
artifact_bucket = "<artifact-bucket>"

aws_region = "eu-north-1"

# Application
application_name   = "hello"
ecr_repo_name      = "hello"

ecs_cluster        = "<ecs-cluster-name>"

# Network configuration
vpc_id = "<vpc-id>"
public_subnets = [<comma-separated-public-subnets>]

private_subnets = [<comma-separated-private-subnets>]

# Repository configuration for the repository
github_repo_url  = "<application-repo-url>"
github_repo_id   = "<repository-id>"
github_token_ssm = "<ssm-path-where-github-token-is-stored-
github_branch    = "<github-branch-you-want-to-deploy>"
```

```bash
make plan.tf

make apply.tf
```


