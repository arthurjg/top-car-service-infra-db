variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo nos recursos"
  type        = string
  default     = "meu-projeto"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# --- Rede ---

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Lista de AZs a utilizar para as subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das subnets privadas onde o RDS será provisionado"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "create_vpc" {
  description = "Se true, cria uma VPC nova. Se false, use var.existing_vpc_id e var.existing_subnet_ids"
  type        = bool
  default     = true
}

variable "existing_vpc_id" {
  description = "ID de uma VPC existente (usado quando create_vpc = false)"
  type        = string
  default     = ""
}

variable "existing_subnet_ids" {
  description = "IDs de subnets existentes (usado quando create_vpc = false)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDRs permitidos a acessar o RDS na porta Postgres (ex: CIDR da VPC de app, VPN, bastion)"
  type        = list(string)
  default     = []
}

# --- RDS ---

variable "db_identifier" {
  description = "Identificador único da instância RDS"
  type        = string
  default     = "meu-projeto-postgres"
}

variable "db_name" {
  description = "Nome do banco de dados inicial"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Usuário administrador do banco"
  type        = string
  default     = "dbadmin"
}

variable "db_engine_version" {
  description = "Versão do engine Postgres"
  type        = string
  default     = "16.4"
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "Armazenamento inicial (GB)"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Limite máximo para autoscaling de storage (GB). 0 desativa."
  type        = number
  default     = 100
}

variable "db_storage_type" {
  description = "Tipo de storage (gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}

variable "multi_az" {
  description = "Se true, habilita Multi-AZ para alta disponibilidade"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Dias de retenção de backup automático"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Janela de backup preferida (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Janela de manutenção preferida (UTC)"
  type        = string
  default     = "mon:04:30-mon:05:30"
}

variable "deletion_protection" {
  description = "Se true, impede exclusão acidental da instância"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Se true, não cria snapshot final ao destruir a instância"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Se true, habilita criptografia do storage"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Se true, expõe o RDS publicamente (não recomendado)"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Habilita o Performance Insights"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Intervalo (segundos) para Enhanced Monitoring. 0 desativa."
  type        = number
  default     = 0
}
