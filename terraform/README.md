<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_my_service"></a> [my\_service](#module\_my\_service) | ./modules/ecs_service | n/a |
| <a name="module_my_service_blue_green_deployment"></a> [my\_service\_blue\_green\_deployment](#module\_my\_service\_blue\_green\_deployment) | ./modules/codedeploy | n/a |
| <a name="module_my_service_codebuild"></a> [my\_service\_codebuild](#module\_my\_service\_codebuild) | ./modules/codebuild | n/a |
| <a name="module_my_service_pipeline"></a> [my\_service\_pipeline](#module\_my\_service\_pipeline) | ./modules/codepipeline | n/a |
| <a name="module_my_service_task_definition"></a> [my\_service\_task\_definition](#module\_my\_service\_task\_definition) | ./modules/ecs_task_definition | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.my_repo](https://registry.terraform.io/providers/hashicorp/aws/5.6.0/docs/data-sources/ecr_repository) | data source |
| [aws_ssm_parameter.github_token](https://registry.terraform.io/providers/hashicorp/aws/5.6.0/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_bucket"></a> [artifact\_bucket](#input\_artifact\_bucket) | Name of the S3 bucket that will be used by CodePipeline to store artifacts | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"eu-north-1"` | no |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | Name of the ECR repository where the image is stored | `string` | n/a | yes |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | Name of the ECS cluster where your service will be deployed to | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Git branch that stores the code of the service | `string` | `"main"` | no |
| <a name="input_github_repo_id"></a> [github\_repo\_id](#input\_github\_repo\_id) | Id of the Github repository (e.g. <owner>/<repository-name>) | `string` | n/a | yes |
| <a name="input_github_repo_url"></a> [github\_repo\_url](#input\_github\_repo\_url) | URL of the Git repository | `string` | n/a | yes |
| <a name="input_github_token_ssm"></a> [github\_token\_ssm](#input\_github\_token\_ssm) | SSM Path where the github token is stored | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Id of the private subnets for the ECS service | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Id of the public subnets for the internet-facing ALB | `list(string)` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service you want to deploy on ECS | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of the VPC where the Service will be deployed into | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ServiceURL"></a> [ServiceURL](#output\_ServiceURL) | URL of the service endpoint |
<!-- END_TF_DOCS -->