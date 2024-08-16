variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  validation {
    condition     = length(var.public_subnets_cidr) == 2
    error_message = "Two public subnets cidr are required"
  }
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  validation {
    condition     = length(var.private_subnets_cidr) == 2
    error_message = "Two private subnets cidr are required"
  }
}

variable "availability_zones" {
  type        = list(string)
  description = "AZ in which all the resources will be deployed"
  default     = ["us-east-1a", "us-east-1b"]
  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Two availability zones are required"
  }
}

variable "kube_network_cfg" {
  type        = string
  description = "The cidr of the kubernetes networking"
  default     = "10.255.0.0/16"
}
variable "node_disk" {
  type        = string
  description = "The size of nodegroup disk"
  default     = "20"
}
variable "node_instance_types" {
  type        = list(string)
  description = "The size of the nodegroups"
  default     = ["t3.small"]
}
variable "node_scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  description = "The scaling config for the nodes"
  default = {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }
}
variable "cluster_version" {
  type        = string
  description = "The version of the eks cluster"
  default     = "1.29"
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default = null
}