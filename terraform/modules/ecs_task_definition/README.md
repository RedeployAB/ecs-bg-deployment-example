# ECS Task Definition module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port number on the container | `number` | `80` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units reserved for the container | `number` | `256` | no |
| <a name="input_ecr_image_url"></a> [ecr\_image\_url](#input\_ecr\_image\_url) | Url of the image store in ECR | `string` | n/a | yes |
| <a name="input_host_port"></a> [host\_port](#input\_host\_port) | The port number on the container instance | `number` | `80` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount (in MiB) of memory to present to the container | `number` | `512` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service for which you are creating a task definition | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the ECS Task Definition |
<!-- END_TF_DOCS -->
