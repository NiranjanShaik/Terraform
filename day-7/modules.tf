module "name" {
  source = "../day-6"
  ami = "ami-0e959ab503d46b6ea"
  type = "t2.micro"
  key = "for terraform"
}