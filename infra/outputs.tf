output "db_instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.this.id
}

output "db_instance_endpoint" {
  description = "Endpoint (host:port) da instância RDS"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_address" {
  description = "Host da instância RDS"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "Porta da instância RDS"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.this.db_name
}

output "db_security_group_id" {
  description = "ID do security group associado ao RDS"
  value       = aws_security_group.rds.id
}

output "db_credentials_secret_arn" {
  description = "ARN do secret no Secrets Manager contendo usuário e senha"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "vpc_id" {
  description = "ID da VPC utilizada"
  value       = local.vpc_id
}

output "subnet_ids" {
  description = "IDs das subnets utilizadas pelo RDS"
  value       = local.subnet_ids
}
