provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ex" {
  ami = var.ami
  key_name = var.key
  instance_type = var.ins-type
  
  tags = {
    name = var.name
  }
}