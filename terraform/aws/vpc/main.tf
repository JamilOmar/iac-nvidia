locals {
  environment = "dev"
  project     =  "nvidia"
  region      = "us-east-1"
  vpc_name    = var.vpc_name_override != null ? var.vpc_name_override : "${local.project}-vpc-${local.environment}"
}
provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Environment = "${local.environment}"
    }
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "jamilomar-nvidia-aws-tf-state"
    key            = "nvidia/dev/vpc/terraform.tfstate"
    dynamodb_table = "jamilomar-nvidia-aws-tf-state-locks"
    encrypt        = true
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = local.vpc_name

  }
}
