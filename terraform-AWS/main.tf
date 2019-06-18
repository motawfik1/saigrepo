#---------root/main----------

provider "aws" {
    region = "${var.region_name}"
}

module "s3bucket" {
    source = "./storage"
    project_name = "${var.project_name}"
}

module "networking" {
    source = "./network"
    vpc_cidr = "${var.vpc_cidr}"
    public_cidrs = "${var.public_cidrs}"
    access_ip = "${var.access_ip}"
}