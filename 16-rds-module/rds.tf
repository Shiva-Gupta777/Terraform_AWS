module "database" {
  source = "./modules/rds"

  project_name       = "my-rds-project"
  security_group_ids = []
  subnet_ids         = [aws_subnet.allowed.id]
  credentials = {
    username = "shivaji"
    password = "1234ASAD56"
  }
}
