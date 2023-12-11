# Get the ECR repository
data "aws_ecr_repository" "my_repo" {
  name = var.ecr_repo_name
}

# Get the github token from SSM
data "aws_ssm_parameter" "github_token" {
  count           = var.github_token_ssm == "" ? 0 : 1
  name            = var.github_token_ssm
  with_decryption = true
}

# Create the ECS Task Definition
module "my_service_task_definition" {
  source = "./modules/ecs_task_definition"

  service_name  = var.application_name
  ecr_image_url = "${data.aws_ecr_repository.my_repo.repository_url}:${var.image_tag}"
  region        = var.aws_region
}

# Create the ECS Service
module "my_service" {
  source = "./modules/ecs_service"

  service_name        = var.application_name
  vpc_id              = var.vpc_id
  ecs_cluster         = var.ecs_cluster
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  task_definition_arn = module.my_service_task_definition.arn
}

# Create codedeploy app and deployment group
module "my_service_blue_green_deployment" {
  source = "./modules/codedeploy"

  service_name                    = module.my_service.name
  ecs_cluster                     = var.ecs_cluster
  service_alb_listener_arn        = module.my_service.alb_listener_arn
  service_blue_target_group_name  = module.my_service.blue_target_group_name
  service_green_target_group_name = module.my_service.green_target_group_name
}

# Create Codebuild project to build the docker image and push to ECR
module "my_service_codebuild" {
  source = "./modules/codebuild"

  project_name     = var.application_name
  aws_region       = var.aws_region
  image_repo_name  = var.ecr_repo_name
  ecs_cluster_name = var.ecs_cluster
  github_repo_url  = var.github_repo_url
  github_token     = var.github_token_ssm == "" ? "" : data.aws_ssm_parameter.github_token[0].value
}

# Create a pipeline in Codepipeline that calls Codebuild to build the image and
# deploy the service to ECS blue/green deployment
module "my_service_pipeline" {
  source = "./modules/codepipeline"

  service_name                     = var.application_name
  artifact_bucket                  = var.artifact_bucket
  ecr_repo_name                    = var.ecr_repo_name
  ecr_repo_arn                     = data.aws_ecr_repository.my_repo.arn
  codedeploy_app_name              = module.my_service_blue_green_deployment.app_name
  codedeploy_app_arn               = module.my_service_blue_green_deployment.app_arn
  codedeploy_deployment_group_name = module.my_service_blue_green_deployment.deployment_group_name
  codedeploy_deployment_group_arn  = module.my_service_blue_green_deployment.deployment_group_arn
  codebuild_project_name           = module.my_service_codebuild.project_name
  github_repo_id                   = var.github_repo_id
  github_branch                    = var.github_branch
}
