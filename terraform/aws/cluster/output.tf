output "kubeconfig_certificate_authority_data" {
  value =module.cluster.kubeconfig_certificate_authority_data
}
output "aws_eks_cluster_name" {
  value =module.cluster.aws_eks_cluster_name
}

output "private_subnets_ids" {
  value =module.cluster.private_subnets_ids
}
  
  output "public_subnets_ids" {
  value =module.cluster.public_subnets_ids
}
  
