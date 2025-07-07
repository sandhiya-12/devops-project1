provider "aws" {
  region = "us-east-1"
}
# Creates a Amazon Linux based EC2 instance with 10 GB EBS attached to it
resource "aws_instance" "java-project-demo" {
    ami = "ami-05ffe3c48a9991133"
    instance_type = "t2.micro"
    # key-value pair
    key_name = "devopsdemo"

    root_block_device {
      volume_size = "10"
      volume_type = "gp2"
    }

    tags = {
        # dont use 'name' attribute, it will not show in UI, use 'Name'
        Name = "devops-demo1"
    }
}