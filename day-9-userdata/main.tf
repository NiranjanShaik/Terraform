
resource "aws_instance" "dev-victor" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type  = "t2.micro"
  key_name = "for terraform"
  user_data = file("script1.sh")

  tags ={
    name="dev-victor"
  }

}

