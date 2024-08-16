
resource "aws_security_group" "this" {
  name        = local.eks_security_group_name
  description = "${var.environment} traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = local.eks_security_group_name
    "kubernetes.io/cluster/cluster-${var.environment}}" : "owned"
  }
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.this.id
  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
  ipv6_cidr_blocks = local.all_ipsv6
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.this.id
  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
  ipv6_cidr_blocks = local.all_ipsv6
}