#-----------------Network/main.tf------------------

data "aws_availability_zones" "azs" {}

resource "aws_vpc" "tf_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags {
        Name = "tf_vpc"
    }
}

resource "aws_internet_gateway" "tf_igw" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    tags {
        Name = "tf_igw"
    }
}

resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tf_igw.id}"
    }
    tags {
        Name = "tf_public_rt"
    }
}

resource "aws_default_route_table" "tf_private_rt" {
    default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"
    tags {
        Name = "tf_private_rt"
    }
}

resource "aws_subnet" "tf_public_subnet" {
    count = "2"
    vpc_id = "${aws_vpc.tf_vpc.id}"
    cidr_block = "${var.public_cidrs[count.index]}"
    map_public_ip_on_launch = "true"
    availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
    tags {
        Name = "tf_public_subnet_${count.index + 1}"
    }
}

resource "aws_route_table_association" "tf_public_asoc" {
    count = "${aws_subnet.tf_public_subnet.count}"
    subnet_id = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
    route_table_id = "${aws_route_table.tf_public_rt.id}"
}

resource "aws_security_group" "tf_public_sg" {
    name = "tf_public_sg"
    description = "public security group"
    vpc_id = "${aws_vpc.tf_vpc.id}"
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["${var.access_ip}"]
    }
    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["${var.access_ip}"]
    }
    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}