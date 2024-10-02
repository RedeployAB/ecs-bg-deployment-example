resource "aws_security_group" "alb" {
  name        = "${var.service_name}-alb-sg"
  description = "Allow ${var.service_name} traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.service_name}-allow-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb" {
  security_group_id = aws_security_group.alb.id

  description = "Allow inbound HTTP"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id

  description                  = "Allow HTTP outbound"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.service.id
}

resource "aws_lb" "public" {
  name               = "${var.service_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.alb.id]

  tags = {
    Name = "${var.service_name}-alb"
  }
}

# Create the blue target group for the ECS service
resource "aws_lb_target_group" "blue" {
  name        = "${var.service_name}-target-group-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

# Create teh green target group for the ECS service
resource "aws_lb_target_group" "green" {
  name        = "${var.service_name}-target-group-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    port     = 80
    protocol = "HTTP"
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_security_group" "service" {
  name        = "${var.service_name}-sg"
  description = "Allow ${var.service_name} traffic from ALB"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.service_name}-allow-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "service" {
  security_group_id = aws_security_group.service.id

  description                  = "Allow HTTP from ALB"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "service" {
  security_group_id = aws_security_group.service.id

  description = "Allow outbound connections"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.ecs_cluster
  task_definition = var.task_definition_arn
  desired_count   = var.service_desired_count
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.service.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = var.service_name
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [
      load_balancer,
      task_definition
    ]
  }
}
