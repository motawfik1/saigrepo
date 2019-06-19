region_name = "eu-west-1"
project_name = "mttfproject"
vpc_cidr = "10.10.0.0/16"
public_cidrs = [
        "10.10.1.0/24", 
        "10.10.2.0/24"
    ]
access_ip = "0.0.0.0/0"
key_name = "tf_sshkey"
key_path = "/home/ec2-user/.ssh/id_rsa.pub"
instance_count = 2
instance_type = "t2.micro"