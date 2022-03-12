resource "aws_db_instance" "default" {
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  name                  = var.name
  username              = var.username
  password              = jsondecode(data.aws_secretsmanager_secret_version.postgres_password.secret_string)["password"]
  parameter_group_name  = var.parameter_group_name
  skip_final_snapshot   = true
  publicly_accessible   = true
  port                  = 5432
  db_subnet_group_name  = aws_db_subnet_group.default.name
}

data "aws_secretsmanager_secret" "postgres_secret" {
  name = "prod/db/postgres"
}

data "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id = data.aws_secretsmanager_secret.postgres_secret.id
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.subnet_frontend, var.subnet_backend]

  tags = {
    Name = "My DB subnet group"
  }
}