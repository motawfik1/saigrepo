#-------Compute/main.tf-----------

data "aws_ami" "server_ami" {
    most_recent = "true"
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn-ami-hvm*-x86_64-gp2"]
    }
}

resource "aws_key_pair" "tf_key_pair" {
    key_name = "${var.key_name}"
    public_key = "${file(var.key_path)}"
}

data "template_file" "bootstrap_script" {
    count = 2
    template = "${file("${path.module}/userdata.tpl")}"
    
    vars {
        fw_subnets = "${element(var.subnet_ips, count.index)}"
    }
    
}


resource "aws_instance" "tf_instance" {
    count = "${var.instance_count}"
    instance_type = "${var.instance_type}"
    ami = "${data.aws_ami.server_ami.id}"
    tags {
        Name = "tf_Instance-${count.index +1}"
    }
    key_name = "${aws_key_pair.tf_key_pair.id}"
    vpc_security_group_ids = ["${var.security_group}"]
    subnet_id = "${element(var.subnets ,count.index)}" 
    user_data = "${data.template_file.bootstrap_script.*.rendered[count.index]}"
    
    
    
}