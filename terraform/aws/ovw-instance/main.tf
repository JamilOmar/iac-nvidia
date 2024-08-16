
locals {

  environment                         = "dev"
  project                             = "nvidia"
  region                              = "us-east-1"
  instance_type                       = "g5.2xlarge"
  disk_size                           = 250
  instance_name                       = "${local.project}-ec2-instance-${local.environment}"
  instance_security_group_name        = "${local.project}-ec2-instance-sg-${local.environment}"
  instance_security_group_description = "${local.project}-ec2-instance-sg-${local.environment} traffic"
  alias_https_port                    = 8443
  https_port                          = 443
  http_port                           = 80
  any_port                            = 0
  any_protocol                        = "-1"
  tcp_protocol                        = "tcp"
  all_ips                             = ["0.0.0.0/0"]
  all_ipsv6                           = ["::/0"]

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
    key            = "nvidia/dev/instance/terraform.tfstate"
    dynamodb_table = "jamilomar-nvidia-aws-tf-state-locks"
    encrypt        = true
  }
}



resource "aws_security_group" "instance" {
  name        = local.instance_security_group_name
  description = local.instance_security_group_description
  vpc_id      = var.vpc_id
  tags = {
    Name = local.instance_security_group_name
  }
}

resource "aws_security_group_rule" "instance_allow_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.instance.id
  from_port         = local.any_port
  to_port           = local.any_port
  protocol          = local.any_protocol
  cidr_blocks       = local.all_ips
  description       = "Allow outbound traffic"
}
resource "aws_security_group_rule" "instance_allow_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instance.id
  from_port         = local.alias_https_port
  to_port           = local.alias_https_port
  protocol          = local.tcp_protocol
  cidr_blocks       = local.all_ips
  description       = "Allow inbound traffic"
}


# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0dcec325865672a69" # us-east-1
  instance_type = local.instance_type
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [
    aws_security_group.instance.id,
  ]
  tags = {
    Name = local.instance_name
  }
  root_block_device {
    volume_size = local.disk_size
  }
}
