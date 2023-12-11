resource "aws_iam_role" "execution_role" {
  name = "${var.service_name}-task-execution-role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow"
        Principal : {
          Service : "ecs-tasks.amazonaws.com"
        }
        Action : "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "TaskPolicy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.service_name
  execution_role_arn       = aws_iam_role.execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name  = var.service_name
      image = var.ecr_image_url

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.service_name}"
          awslogs-region        = var.region
          awslogs-create-group  = "true"
          awslogs-stream-prefix = var.service_name
        }
      }

      essential = true
      memory    = var.memory
      cpu       = var.cpu
    }
  ])
}
