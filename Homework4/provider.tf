terraform {
  backend "remote" {
    organization = "opsschool-gals"

    workspaces {
      name = "aws-and-terraform"
    }
  }
}
provider "tfe" {
}