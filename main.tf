provider "aws" {
  region = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
}

# Create a VPC to contain the other resources.
resource "aws_vpc" "MainVPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Create the first subnet within the VPC.
resource "aws_subnet" "SubnetA" {
  vpc_id                  = aws_vpc.MainVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_network_interface" "SubnetAInterface" {
  subnet_id   = aws_subnet.SubnetA.id
  # private_ips = ["172.16.10.100"]
  security_groups= [var.security_group]

  tags = {
    Name = "subnet-a-interface"
  }
}

# Create the second subnet within the VPC.
resource "aws_subnet" "SubnetB" {
  vpc_id                  = aws_vpc.MainVPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "subnet-b"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "petclinic_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
resource "aws_instance" "FrontendInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.SubnetAInterface.id
    device_index         = 0
  }
}
# Create AWS ec2 instance
resource "aws_instance" "BackendInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.SubnetAInterface.id
    device_index         = 1
  }
}