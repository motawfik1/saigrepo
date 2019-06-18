variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "public_cidrs" {
    type = "list"
    default = [
        "10.10.1.0/24", 
        "10.10.2.0/24"
    ]
}

variable "access_ip" {
    default = "0.0.0.0/0"
}