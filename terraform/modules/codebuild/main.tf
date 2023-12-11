
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "codebuild" {
  statement {
    sid    = "S3Policy"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ECRPolicy"
    effect = "Allow"
    actions = [
      "ecr:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "CWPolicy"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }


  statement {
    sid    = "ECSPolicy"
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "codebuild" {
  name = "codebuild-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "codebuild.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild" {
  name   = "${var.project_name}-codebuild-policy"
  role   = aws_iam_role.codebuild.id
  policy = data.aws_iam_policy_document.codebuild.json
}

resource "aws_codebuild_project" "this" {
  name          = var.project_name
  description   = "Builds ${var.project_name} app"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = "5"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }
    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
    }
    environment_variable {
      name  = "ECS_CLUSTER_NAME"
      value = var.ecs_cluster_name
    }

    environment_variable {
      name  = "SERVICE_NAME"
      value = var.project_name
    }
  }
  source {
    type            = "GITHUB"
    location        = var.github_repo_url
    git_clone_depth = 1
  }
}

resource "aws_codebuild_source_credential" "github" {
  # Create only if github token has been provided
  count       = var.github_token == "" ? 0 : 1
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_token
}
