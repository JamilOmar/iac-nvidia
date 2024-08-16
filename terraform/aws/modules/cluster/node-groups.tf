resource "aws_iam_role" "nodes" {
  name = local.private_nodes_iam_role_name
  assume_role_policy = <<EOF
{
"Statement" : [{
"Action" : "sts:AssumeRole",
"Effect" : "Allow",
"Principal" : {
"Service" : "ec2.amazonaws.com"
}
}],
"Version" : "2012-10-17"
}
EOF

  tags = {
    Name = local.private_nodes_iam_role_name
  }
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "private_nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = local.private_nodes_group_name
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = aws_subnet.private_subnet.*.id
  disk_size       = var.node_disk
  instance_types  = var.node_instance_types
  scaling_config {
    desired_size = var.node_scaling_config.desired_size
    max_size     = var.node_scaling_config.max_size
    min_size     = var.node_scaling_config.min_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name =local.private_nodes_group_name
  }
}