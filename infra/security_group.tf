resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Permite acesso Postgres (5432) apenas dos CIDRs autorizados"
  vpc_id      = local.vpc_id

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "postgres" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.rds.id
  description        = "Acesso Postgres a partir de ${each.value}"
  cidr_ipv4          = each.value
  from_port          = 5432
  to_port             = 5432
  ip_protocol        = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.rds.id
  description        = "Permite todo tráfego de saída"
  cidr_ipv4          = "0.0.0.0/0"
  ip_protocol        = "-1"
}
