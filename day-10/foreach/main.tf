resource "aws_instance" "name" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type = "t2.micro"
  key_name = "for terraform"

  for_each = toset(var.names)

  tags = {
    Name = each.value
  }
}

variable "names" {
  type = list(string)
  default = [ "for-each-1","for-each-3" ]
}