variable "region" {
  type        = string
  description = "Region in which the bastion host will be launched"
  default     = "us-east-1"
}
variable "bucket" {
  type        = string
  description = "S3 Bucket Name"
}
variable "locks_name" {
  type        = string
  description = "Locks Name"
}