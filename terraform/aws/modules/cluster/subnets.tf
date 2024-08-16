
# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name                                               = "${var.project}-${element(var.availability_zones, count.index)}-${local.public_subnet_name}-${var.environment}"
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = var.vpc_id
  count                   = length(var.private_subnets_cidr)
  cidr_block              = element(var.private_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name                                               = "${var.project}-${element(var.availability_zones, count.index)}-${local.private_subnet_name}-${var.environment}"
    "kubernetes.io/role/internal-elb"                  = "1"
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }
}

