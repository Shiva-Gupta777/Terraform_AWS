module "database" {
  source = "./modules/rds"

  project_name = "my-rds-project"

  credentials = {
    username = "shivaji"
    password = "123456"
  }
}
