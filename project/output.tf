 output "frontend_lb_arn" {
  description = "ARN of the frontend ALB"
  value       = aws_lb.frontend_alb.arn
}

output "backend_lb_arn" {
  description = "ARN of the backend ALB"
  value       = aws_lb.backend_alb.arn
}

output "frontend_tg_arn" {
  description = "Target group ARN for frontend"
  value       = aws_lb_target_group.frontend_tg.arn
}

output "backend_tg_arn" {
  description = "Target group ARN for backend"
  value       = aws_lb_target_group.backend_tg.arn
}
