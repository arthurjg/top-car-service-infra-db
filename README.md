# Top Car Service DB

## Técnologias

- **AWS RDS**
- **Git**
- **PostgreSQL**

## Propósito

Esta stack provisiona uma instância **Amazon RDS PostgreSQL**, incluindo:

- VPC dedicada (opcional) com subnets privadas em múltiplas AZs
- DB Subnet Group
- Security Group restringindo a porta 5432 aos CIDRs autorizados
- Instância RDS Postgres com storage criptografado
- Senha gerada automaticamente e armazenada no **AWS Secrets Manager**
  (nunca fica em texto puro em variáveis)
- Enhanced Monitoring opcional (via IAM Role)

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| `versions.tf` | Versão do Terraform e providers |
| `provider.tf` | Configuração do provider AWS |
| `variables.tf` | Todas as variáveis de entrada |
| `network.tf` | VPC, subnets e roteamento (opcional) |
| `security_group.tf` | Regras de firewall para o RDS |
| `rds.tf` | Subnet group, secret e instância RDS |
| `outputs.tf` | Saídas (endpoint, ARNs, IDs) |
| `terraform.tfvars.example` | Exemplo de valores customizados |

## Passos para execução e deploy

### 1.1. Execução Local

```bash
# 1. Copie e edite as variáveis
cp terraform.tfvars.example terraform.tfvars
# edite terraform.tfvars com seus valores

# 2. Inicialize
terraform init

# 3. Revise o plano
terraform plan

# 4. Aplique
terraform apply
```

### 1.2. Deploy

- commitar o código e fazer push na branch release/**

## Recuperando a senha do banco

A senha é gerada pelo Terraform e salva no Secrets Manager. Para recuperá-la:

```bash
aws secretsmanager get-secret-value \
  --secret-id $(terraform output -raw db_credentials_secret_arn) \
  --query SecretString --output text | jq .
```

## Usando uma VPC já existente

Se você já tem uma VPC e não quer que o Terraform crie uma nova:

```hcl
create_vpc          = false
existing_vpc_id      = "vpc-xxxxxxxx"
existing_subnet_ids  = ["subnet-aaaa", "subnet-bbbb"]
```

As subnets informadas precisam estar em pelo menos 2 AZs distintas
(exigência do RDS para o DB Subnet Group).

## Pontos de atenção

- **`deletion_protection = true`** por padrão. Para destruir a instância via
  `terraform destroy`, defina `false` antes, ou remova a proteção manualmente
  no console/CLI.
- **`skip_final_snapshot = false`** por padrão, ou seja, ao destruir a
  instância será criado um snapshot final (`<db_identifier>-final-snapshot`).
- Para produção, considere `multi_az = true` e um `db_instance_class` maior
  que `db.t4g.micro`.
- O Security Group não abre nenhuma porta por padrão — preencha
  `allowed_cidr_blocks` com os CIDRs que devem ter acesso (ex: VPC da
  aplicação, bastion, VPN).
- Ajuste `db_engine_version` conforme as versões de Postgres disponíveis na
  sua região (`aws rds describe-db-engine-versions --engine postgres`).

## Arquitetura

![arquitetura](/docs/top-car-service-aws-rds.drawio.png)
