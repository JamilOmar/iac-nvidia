output "public_subnets_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets_ids" {
  value =  aws_subnet.private_subnet[*].id
}

output "public_route_table" {
  value = aws_route_table.public.id
}
output "aws_eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}
output "aws_eks_cluster_name" {
  value =aws_eks_cluster.this.name
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "aws_vpc_cni_role_arn" {
  value = aws_iam_role.aws_vpc_cni.arn
}
output "aws_ebs_csi_role_arn" {
  value = aws_iam_role.aws_ebs_csi.arn
}
output "aws_efs_file_system_aws_efs_id" {
  value = aws_efs_file_system.aws_efs.id
}
output "aws_security_group_id" {
  value       = aws_security_group.this.id
}