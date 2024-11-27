# creating a vpc
resource "aws_vpc" "dev-victor" {
  cidr_block = "12.0.0.0/16"
  tags = {
    name="dev-vpc"
  }
}

# creating subnet
resource "aws_subnet" "dev-victor" {
  vpc_id = aws_vpc.dev-victor.id
  cidr_block = "12.0.1.0/24"
  tags = {
    name="dev-subnet"
  }
}

# creating internet gateway
resource "aws_internet_gateway" "dev-victor" {
  vpc_id = aws_vpc.dev-victor.id
  tags = {
    name = "dev-IG"
  }
}

resource "aws-instance" "dev-victor" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type  = "t2.micro"
  key_name = "for terraform"

  userdata = file("script1.sh")

  tags ={
    name="dev-victor"
  }

}