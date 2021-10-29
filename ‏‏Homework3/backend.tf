terraform {
  backend "s3" {
    bucket = "tfstategalsegal"
    key    = "tfstatehw3"
    region = "us-east-1"
  }
}