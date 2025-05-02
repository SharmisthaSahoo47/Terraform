 output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "frontend_alb_dns" {
  value = aws_lb.frontend_alb.dns_name
}

output "backend_alb_dns" {
  value = aws_lb.backend_alb.dns_name
}
