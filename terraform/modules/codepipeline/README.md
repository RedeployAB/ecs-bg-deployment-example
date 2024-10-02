# CodePipeline module

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
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarconnections_connection.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |
| [aws_iam_policy.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_bucket"></a> [artifact\_bucket](#input\_artifact\_bucket) | S3 Bucket for CodePipeline artifacts | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | Name of the CodeBuild project | `string` | n/a | yes |
| <a name="input_codedeploy_app_arn"></a> [codedeploy\_app\_arn](#input\_codedeploy\_app\_arn) | ARN of the CodeDeploy App | `string` | n/a | yes |
| <a name="input_codedeploy_app_name"></a> [codedeploy\_app\_name](#input\_codedeploy\_app\_name) | Name of the CodeDeploy App | `string` | n/a | yes |
| <a name="input_codedeploy_deployment_group_arn"></a> [codedeploy\_deployment\_group\_arn](#input\_codedeploy\_deployment\_group\_arn) | ARN of the CodeDeploy deployment group | `string` | n/a | yes |
| <a name="input_codedeploy_deployment_group_name"></a> [codedeploy\_deployment\_group\_name](#input\_codedeploy\_deployment\_group\_name) | Name of the CodeDeploy deployment group | `string` | n/a | yes |
| <a name="input_ecr_repo_arn"></a> [ecr\_repo\_arn](#input\_ecr\_repo\_arn) | ARN of the ECR repository where the image is stored | `string` | n/a | yes |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | Name of the ECR repository where the image is stored | `string` | n/a | yes |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | Github branch that will be used for deployment | `string` | `"main"` | no |
| <a name="input_github_repo_id"></a> [github\_repo\_id](#input\_github\_repo\_id) | Id of the Github repository. (Ex. <owner>/<repository-name>) | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service you want to deploy to ECS | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
