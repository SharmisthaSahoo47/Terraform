output "rds_endpoint" {
  value = aws_db_instance.mysql_rds.address
}

output "sql_runner_public_ip" {
  value = aws_instance.sql_runner.public_ip
}

output "secret_arn" {
  value = aws_secretsmanager_secret.rds_secret.arn
}
