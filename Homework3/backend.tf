terraform {
  backend "s3" {
    bucket = "tfstategalsegal"
    key    = "tfstatehw3"
    region = "us-east-1"
  }
}

# terraform {
#   backend "remote" {
#     organization = "opsschool-gals"
#     workspaces {
      
#       name = "AWS-and-Terraform"
#     }
#   }
#   required_version = "1.0.9"
#   required_providers {
#     aws = {
#       version = "3.13.0"
#     }
#     tls = {
#       version = "3.0.0"
#     }
#   }
# }