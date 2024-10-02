output "alb_listener_arn" {
  value = aws_lb_listener.this.arn
}

output "blue_target_group_name" {
  value = aws_lb_target_group.blue.name
}

output "green_target_group_name" {
  value = aws_lb_target_group.green.name
}

output "url" {
  value = "http://${aws_lb.public.dns_name}"
}

output "name" {
  value = aws_ecs_service.this.name
}
