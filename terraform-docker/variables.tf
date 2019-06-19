# Variables
variable "env" {
  description = "Prod OR Dev"
}
variable "image" {
  description = "Image For Container"
  type = "map"
}
variable "con_name" {
  description = "Container Name"
  type= "map"
}
variable "int_port" {
  description = "Container Internal Port"
}
variable "ext_port" {
  description = "Container External Port"
  type = "map"
}

