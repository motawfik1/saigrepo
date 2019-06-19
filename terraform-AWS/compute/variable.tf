#-----compute/variable.tf----

variable "key_name" {}
variable "key_path" {}
variable "subnet_ips" {
    type = "list"
}
variable "instance_count" {
    default = 1
}
variable "instance_type" {}
variable "security_group" {}
variable "subnets" {
    type = "list"
}