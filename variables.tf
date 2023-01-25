variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "PrimaryKeyPair"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.medium"
}

variable "security_group" {
  description = "Name of security group"
  default     = "petclinic_security_group"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance 22.04"
  default     = "ami-0333305f9719618c7"
}