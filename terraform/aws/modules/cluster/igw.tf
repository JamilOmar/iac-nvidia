resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id
  tags = {
    Name = local.internet_gateway_name
  }
}