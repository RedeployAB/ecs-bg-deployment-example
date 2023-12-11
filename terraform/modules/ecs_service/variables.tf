variable "vpc_id" {
  description = "ID of the VPC where your resources will be placed in"
  type        = string
}

variable "ecs_cluster" {
  description = "Name of the ECS cluster where your service will be deployed to"
  type        = string
}

variable "service_name" {
  type = string
}

variable "public_subnets" {
  description = "Id of the public subnets for the internet-facing ALB"
  type        = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "service_desired_count" {
  type    = number
  default = 1
}

variable "task_definition_arn" {
  type = string
}
