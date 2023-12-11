variable "project_name" {
  description = "Name of the codebuild project"
  type        = string
}

variable "image_repo_name" {
  description = "Name of the image deployed on ECR"
  type        = string
}

variable "image_tag" {
  description = "Tag od the image"
  type        = string
  default     = "latest"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster where the service will be deployed"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "github_repo_url" {
  description = "Url of the Github repository that contains the application code"
  type        = string
}

variable "github_token" {
  description = "Github token"
  type        = string
  default     = ""
}
