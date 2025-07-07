provider "aws" {
  region = "us-east-1"
}

# Creates a Amazon Linux based EC2 instance with 10 GB EBS attached to it and ssh inbound rule enabled
resource "aws_instance" "java-project-demo" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    # key-value pair
    key_name = "devopsdemo"
    # security_groups = [ "demo-sg" ] is deprecrated becoz now all EC2 instances are created inside default VPC
    vpc_security_group_ids = [ aws_security_group.demo-sg.id ]

     root_block_device {
      volume_size = "10"
      volume_type = "gp2"
    }

    tags = {
        # dont use 'name' attribute, it will not show in UI, use 'Name'
        Name = "devops-demo2"
    }
}


resource "aws_security_group" "demo-sg" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"

  # Inbound security group
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound security group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}