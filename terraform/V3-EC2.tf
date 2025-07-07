provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "java-project-demo" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    key_name = "devopsdemo"
    # security_groups = [ "demo-sg" ] is deprecrated becoz now all EC2 instances are created inside default VPC
    vpc_security_group_ids = [ aws_security_group.demo-sgrp.id ]

     root_block_device {
      volume_size = "8"
      volume_type = "gp2"
    }

    tags = {
        # dont use 'name' attribute, it will not show in UI, use 'Name'
        Name = "devops-demo3"
    }
}


resource "aws_security_group" "demo-sgrp" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh_access" {
  security_group_id = aws_security_group.demo-sgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo-sgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}