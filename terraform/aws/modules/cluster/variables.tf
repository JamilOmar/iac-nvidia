variable "environment" {
  description = "Deployment Environment"
}

variable "project" {
  description = "Project Name"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Public Subnet"
  default     = []
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Private Subnet"
  default     = []
}

variable "region" {
  description = "Region in which the cluster will be launched"
  default     = ""
}

variable "availability_zones" {
  type        = list(string)
  description = "AZ in which all the resources will be deployed"
  default     = []
}

variable "kube_network_cfg" {
  type        = string
  description = "The cidr of the kubernetes networking"
  default     = ""
}
variable "node_disk" {
  type        = string
  description = "The size of nodegroup disk"
  default     = ""
}
variable "node_instance_types" {
  type        = list(string)
  description = "The size of the nodegroups"
}
variable "node_scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  description = "The scaling config for the nodes"
}
variable "cluster_version" {
  type        = string
  description = "The version of the eks cluster"
  default     = "1.27"
}

variable "eks_name_override" {
  description = "Name of the EKS cluster"
  type        = string
  default     = null
}

variable "vpc_ini_name_override" {
  description = "Name of the VPC CNI"
  type        = string
  default     = null

}

variable "efs_csi_name_override" {
  description = "Name of the EFS CSI"
  type        = string
  default     = null

}

variable "efs_csi_driver_name_override" {
  description = "Override for the EFS CSI driver name"
  type        = string
  default     = null
}

variable "ebs_csi_name_override" {
  description = "Override for the EBS CSI name"
  type        = string
  default     = null
}

variable "ebs_sc_name_override" {
  description = "Override for the EBS SC name"
  type        = string
  default     = null
}

variable "eks_security_group_name_override" {
  description = "Override for the EKS security group name"
  type        = string
  default     = null
}

variable "internet_gateway_name_override" {
  description = "Override for the internet gateway name"
  type        = string
  default     = null
}

variable "nat_name_override" {
  description = "Override for the NAT name"
  type        = string
  default     = null
}

variable "nat_eip_name_override" {
  description = "Override for the NAT EIP name"
  type        = string
  default     = null
}

variable "private_nodes_group_name_override" {
  description = "Override for the private nodes group name"
  type        = string
  default     = null
}

variable "private_nodes_iam_role_name_override" {
  description = "Override for the private nodes IAM role name"
  type        = string
  default     = null
}

variable "private_route_table_name_override" {
  description = "Override for the private route table name"
  type        = string
  default     = null
}

variable "public_route_table_name_override" {
  description = "Override for the public route table name"
  type        = string
  default     = null
}


variable "alb_controller_name_override" {
  description = "Override for the alb controller name"
  type        = string
  default     = null
}

variable "eks_iam_role_name_override" {
  description = "Override for the eks IAM role name"
  type        = string
  default     = null
}



variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = null
}

variable "public_subnet_name_override" {
  description = "Override for the public subnet name"
  type        = string
  default     = null
}
variable "private_subnet_name_override" {
  description = "Override for the private subnet name"
  type        = string
  default     = null
}

