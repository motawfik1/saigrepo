#---------root/main----------

provider "aws" {
    region = "${var.region_name}"
}

# Deploying S3 Bucket

module "s3_bucket" {
    source = "./storage"
    project_name = "${var.project_name}"
}

# Deploying Networking Resources

module "network" {
    source = "./network"
    vpc_cidr = "${var.vpc_cidr}"
    public_cidrs = "${var.public_cidrs}"
    access_ip = "${var.access_ip}"
}

# Deploying Compute Resources

module "ec2compute" {
    source = "./compute"
    instance_count = "${var.instance_count}"
    key_name = "${var.key_name}"
    key_path = "${var.key_path}"
    instance_type = "${var.instance_type}"
    subnets = "${module.network.public_subnets}"
    security_group = "${module.network.public_sg}"
    subnet_ips = "${module.network.subnet_ips}"
}