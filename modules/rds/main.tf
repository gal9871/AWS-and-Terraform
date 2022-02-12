resource "aws_db_instance" "default" {
  allocated_storage     = 20
  max_allocated_storage = 1000
  engine                = "postgres"
  engine_version        = "13.4"
  instance_class        = "db.t3.micro"
  db_name               = "mydb"
  username              = "postgres"
  password              = jsondecode(data.aws_secretsmanager_secret_version.postgres_password.secret_string)["password"]
  parameter_group_name  = "default.postgres13"
  skip_final_snapshot   = true
  publicly_accessible   = true
  port                  = 5432
}

data "aws_secretsmanager_secret" "postgres_secret" {
  name = "prod/db/postgres"
}

data "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id = data.aws_secretsmanager_secret.postgres_secret.id
}