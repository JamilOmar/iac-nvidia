resource "aws_iam_role" "cluster" {
  name               = local.eks_iam_role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}


resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_eks_cluster" "this" {
  name     = local.eks_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version


  kubernetes_network_config {
    service_ipv4_cidr = var.kube_network_cfg
  }

  vpc_config {
    subnet_ids=  setunion(aws_subnet.public_subnet.*.id, aws_subnet.private_subnet.*.id)
    security_group_ids      = [aws_security_group.this.id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  depends_on = [
    aws_iam_role.cluster,
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy
  ]
  tags = {
    Name = local.eks_name
  }
}
