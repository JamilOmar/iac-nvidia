
variable "vpc_name_override" {
  description = "Override the default name of the VPC"
  type        = string
  default     = null
}
variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames"
  default     = true
}
  variable "enable_dns_support" {
  description = "Enable DNS support"
  default     = true
}
  