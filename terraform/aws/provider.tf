provider "aws" {
  profile = "terraform"
  region  = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket  = "nosignal-terraform-state"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
  }
}
