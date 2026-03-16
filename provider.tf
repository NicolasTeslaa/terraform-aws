terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }

  ## Guarda o state da infra que é o estado atual da infra
  backend "s3" {
    bucket = "terraformaws"
    key    = "dev/terraform/state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}