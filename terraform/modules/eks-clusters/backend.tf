terraform {
  backend "s3" {
    bucket         = "auths-2fa-mern"
    region         = "us-east-1"
    key            = "dev/eks/terraform.tfstate"
    use_lockfile  =  true
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}