# Codedeploy module

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
| [aws_codedeploy_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_iam_role.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | Name of the ECS cluster where your service will be deployed to | `string` | n/a | yes |
| <a name="input_service_alb_listener_arn"></a> [service\_alb\_listener\_arn](#input\_service\_alb\_listener\_arn) | ARN of the Service ALB Listener | `string` | n/a | yes |
| <a name="input_service_blue_target_group_name"></a> [service\_blue\_target\_group\_name](#input\_service\_blue\_target\_group\_name) | Name of the Blue target group | `string` | n/a | yes |
| <a name="input_service_green_target_group_name"></a> [service\_green\_target\_group\_name](#input\_service\_green\_target\_group\_name) | Name of the Green target group | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service that will be deployed via Codedeploy | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_arn"></a> [app\_arn](#output\_app\_arn) | ARN of the CodeDeploy App |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | Name of the CodeDeploy App |
| <a name="output_deployment_group_arn"></a> [deployment\_group\_arn](#output\_deployment\_group\_arn) | ARN of the CodeDeploy deployment group |
| <a name="output_deployment_group_name"></a> [deployment\_group\_name](#output\_deployment\_group\_name) | Name of the CodeDeploy deployment group |
<!-- END_TF_DOCS -->
