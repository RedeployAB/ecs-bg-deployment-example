variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "service_name" {
  description = "Name of the service for which you are creating a task definition"
  type        = string
}

variable "ecr_image_url" {
  description = "Url of the image store in ECR"
  type        = string
}

variable "memory" {
  description = "The amount (in MiB) of memory to present to the container"
  type        = number
  default     = 512
}

variable "cpu" {
  description = "The number of cpu units reserved for the container"
  type        = number
  default     = 256
}
