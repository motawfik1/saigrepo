#-----root/variable.tf-----

# Storage vars
variable "region_name" {}
variable "project_name" {}

# Network vars
variable "vpc_cidr" {}
variable "public_cidrs" {
    type = "list"
}
variable "access_ip" {}

# Compute vars
variable "key_name" {}
variable "key_path" {}
variable "instance_count" {}
variable "instance_type" {}