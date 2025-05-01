output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.db_instance_endpoint
}

output "rds_username" {
  description = "RDS username"
  value       = jsondecode(data.aws_secretsmanager_secret_version.db_creds.secret_string)["username"]
}

