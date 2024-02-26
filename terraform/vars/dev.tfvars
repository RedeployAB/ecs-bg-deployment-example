# Name of the bucket used for artifacts
artifact_bucket = ""

# Name of the ECS Cluster
ecs_cluster = ""

## Network configuration

# ID of the VPC
vpc_id = ""
# List of one or more public subnets for your public load balancer
public_subnets = [
  "",
  "",
  ""
]

# List of one or more private subnets you want to deploy you application to
private_subnets = [
  "",
  "",
  ""
]

# Git branch you want to deploy
github_branch = "develop"
