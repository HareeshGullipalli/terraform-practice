terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}

provider "aws" {
  region = var.region
}
variable "instance-type" {
  type        = string
  description = "instance type"
  default     = "t2.small"
}
variable "auto-ip" {
  type        = bool
  description = "to assign public ip  or not"
  default     = false
}
variable "region" {
  type        = string
  description = "example for variable string"
  default     = "us-east-1"
}
variable "instance-count" {
  type        = number
  description = "number of instances to create"
  default     = 1
}

output "public-ip" {
  value = aws_instance.dev-ec2-instance[*].public_ip
}
locals {
  n = length(aws_instance.dev-ec2-instance[*])
}
output "total_instance_count" {
  value = local.n
}
resource "aws_instance" "dev-ec2-instance" {
  region                      = var.region
  ami                         = "ami-0ea87431b78a82070"
  count                       = var.instance-count
  associate_public_ip_address = var.auto-ip
  instance_type               = var.instance-type
  subnet_id                   = "subnet-0699127118e1dd60a"
  tags = {
    Name = "dev-instance-${count.index}"
  }

}