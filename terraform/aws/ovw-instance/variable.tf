
variable "vpc_id" {
  description = "vpc id"
  type        = string
  default = null
}
variable "public_subnet_id" {
  description = "Public subnet id for ec2 instance"
  type    = string
  default = null
}
