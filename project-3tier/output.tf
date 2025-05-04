 output "frontend_alb_dns_name" {
  description = "DNS name of the frontend ALB"
  value       = aws_lb.frontend_alb.dns_name
}

output "backend_alb_dns_name" {
  description = "DNS name of the backend ALB"
  value       = aws_lb.backend_alb.dns_name
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}

output "frontend_asg_name" {
  description = "Name of the frontend Auto Scaling Group"
  value       = module.frontend_asg.autoscaling_group_name
}

output "backend_asg_name" {
  description = "Name of the backend Auto Scaling Group"
  value       = module.backend_asg.autoscaling_group_name
}
