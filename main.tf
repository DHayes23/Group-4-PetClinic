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

#Create security group with firewall rules
resource "aws_security_group" "petclinic_security_group" {
  description = "Main security group"
  vpc_id      = aws_vpc.MainVPC.id

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

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


# Create the first subnet within the VPC.
resource "aws_subnet" "SubnetA" {
  vpc_id                  = aws_vpc.MainVPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-a"
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


# Create FrontEnd EC2 instance
resource "aws_instance" "FrontendInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.SubnetA.id
  vpc_security_group_ids = [aws_security_group.petclinic_security_group.id]

  tags = {
    Name = "frontend-instance"
  }
}

# Create Backend EC2 instance
resource "aws_instance" "BackendInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.SubnetA.id
  vpc_security_group_ids = [aws_security_group.petclinic_security_group.id]

  tags = {
    Name = "backend-instance"
  }
}

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = aws_vpc.MainVPC.id

  tags = {
    Name = "internet-gateway"
  }
}

# Create a route table for the internet gateway
resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.MainVPC.id

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.InternetGateway.id
  }

  route {
    ipv6_cidr_block = "::/0" 
    gateway_id = aws_internet_gateway.InternetGateway.id
  }

  tags = {
    Name = "route-table"
  }
}

# Associate the route table with subnet A
resource "aws_route_table_association" "A" {
  subnet_id      = aws_subnet.SubnetA.id
  route_table_id = aws_route_table.RouteTable.id
}

# Associate the route table with subnet B
resource "aws_route_table_association" "B" {
  subnet_id      = aws_subnet.SubnetB.id
  route_table_id = aws_route_table.RouteTable.id
}

# Populate inventory file with dynamic ips
resource "local_file" "dynamic_inventory" {
  content  = "[instances]\n ${output.ec2_instance_frontend} \n ${output.ec2_instance_backend}"
  filename = "./inventory.yml"
}