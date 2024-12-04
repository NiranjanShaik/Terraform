provider "aws" {
  region = "us-east-1"
}

locals {
  ami = "ami-0e959ab503d46b6ea"
  type = "t2.micro"
  key = "for terraform"
}

resource "aws_instance" "ex" {
  ami = local.ami
  key_name = local.key
  instance_type = local.type

  tags = {
    name = "ex"
  }
}