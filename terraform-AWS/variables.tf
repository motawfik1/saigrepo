variable "region_name" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_cidrs" {
    type = "list"
}
variable "access_ip" {}