provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type  = "t2.micro"
  key_name = "for terraform"
}

provider "aws" {
  region = "us-west-1"
  alias = "us-west-1"
}

resource "aws_s3_bucket" "name" {
  bucket = "multiprovider"
  provider = aws.us-west-1
}