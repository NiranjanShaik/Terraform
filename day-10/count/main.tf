resource "aws_instance" "name" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type = "t2.micro"
  key_name = "for terraform"

  count = length(var.names)

  tags = {
    Name = var.names[count.index]
  }
}

variable "names" {
  type = list(string)
  default = [ "dev","test","prod" ]
}