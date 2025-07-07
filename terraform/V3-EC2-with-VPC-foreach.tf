provider "aws" {
  region = "us-east-1"
}

# Creates a Ubuntu based EC2 instance with 8 GB EBS attached to it and ssh inbound rule enabled
resource "aws_instance" "java-project-demo" {
    ami = "ami-020cba7c55df1f615"
    instance_type = "t2.micro"
    key_name = "devopsdemo"
    
    vpc_security_group_ids = [ aws_security_group.demo-sgrp.id ]
    subnet_id = aws_subnet.subnet1.id

     root_block_device {
      volume_size = "8"
      volume_type = "gp2"
    }
    
    # create EC2 instance for each entry in the set
    for_each = toset(["jenkins-master","build-slave","ansible"])
    tags = {
        Name = "${each.key}"
    }
}


resource "aws_security_group" "demo-sgrp" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.vpc-demo.id

  tags = {
    Name = "allow-ssh"
  }
}

# Inbound security group
resource "aws_vpc_security_group_ingress_rule" "ssh_access" {
  security_group_id = aws_security_group.demo-sgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Outbound security group
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo-sgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Create VPC and subnets in below order
# 1.Create VPC
# 2.Create a Subnet
# 3.Create Internet Gateway
# 4.Create RouteTable
# 5.Route Table Association
resource "aws_vpc" "vpc-demo" {
    cidr_block = "10.1.0.0/16"
    tags = {
      Name = "new-vpc"
    }
  
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc-demo.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc-demo.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-demo.id

  tags = {
    Name = "new-igw"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "new-rt"
  }
}

resource "aws_route_table_association" "rta-public-subnet-1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta-public-subnet-2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt1.id
}