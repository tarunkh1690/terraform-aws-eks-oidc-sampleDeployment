
provider "aws" {
  region     = var.aws_region
  #assume_role {
  #  role_arn = ""
  #}
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
