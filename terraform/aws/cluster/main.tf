locals {
  environment = "dev"
  project     =  "nvidia"
  region      = "us-east-1"
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
    key            = "nvidia/dev/cluster/terraform.tfstate"
    dynamodb_table = "jamilomar-nvidia-aws-tf-state-locks"
    encrypt        = true
  }
}

module "cluster" {
  source               = "../modules/cluster"
  environment          = local.environment
  project              = local.project
  vpc_id = var.vpc_id
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
  kube_network_cfg     = var.kube_network_cfg
  node_disk            = var.node_disk
  node_instance_types  = var.node_instance_types
  node_scaling_config = var.node_scaling_config
  cluster_version = var.cluster_version
  region          = local.region
}




