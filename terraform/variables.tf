variable "ecr_repo_name" {
  description = "Name of the ECR repository where the image is stored"
  type        = string
}

variable "image_tag" {
  description = "Tag of the image you want to deploy"
  type        = string
  default     = "latest"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-north-1"
}

variable "application_name" {
  description = "Name of the application you want to deploy on ECS"
  type        = string
}

variable "ecs_cluster" {
  description = "Name of the ECS cluster where your service will be deployed to"
  type        = string
}

variable "vpc_id" {
  description = "Id of the VPC where the Service will be deployed into"
  type        = string
}

variable "public_subnets" {
  description = "Id of the public subnets for the internet-facing ALB"
  type        = list(string)
}

variable "private_subnets" {
  description = "Id of the private subnets for the ECS service"
  type        = list(string)
}

variable "artifact_bucket" {
  description = "Name of the S3 bucket that will be used by CodePipeline to store artifacts"
  type        = string
}

variable "github_repo_id" {
  description = "Id of the Github repository (e.g. <owner>/<repository-name>)"
  type        = string
}

variable "github_repo_url" {
  description = "URL of the Git repository"
  type        = string
}

variable "github_branch" {
  description = "Git branch that stores the code of the service"
  type        = string
  default     = "main"
}
variable "github_token_ssm" {
  description = "SSM Path where the github token is stored"
  type        = string
  default     = ""
}
