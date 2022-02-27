terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }
}

variable "aws_access_key" {
  description = "Enter access Key"
}

variable "aws_secret_key" {
  description = "Enter secret Key"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-south-1"
}
/*
                       create Ubuntu server
                          put ami id
                          attach security group
                          run script
*/
resource "aws_instance" "Ubuntu" {
  ami                    = data.aws_ami.Ubuntu.image_id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.Ubuntu_security.id]
  user_data              = file("script.sh")

  tags = {
    Name = "Ubuntu_Server"
  }
}

/*
                       create Amazon_Linux server
                          put ami id
                          attach security group
*/
resource "aws_instance" "Amazon_Linux" {
  ami                    = data.aws_ami.Amazon_Linux.image_id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.Amazon_Linux.id]
  tags = {
    Name = "Amazon_Linux_Server"
  }
}
