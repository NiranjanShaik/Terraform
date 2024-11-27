module "name" {
  source = "github.com/CloudTechDevOps/terraform-10-30am/day-2-basic-ec2"
  ami = "ami-0e959ab503d46b6ea"
  instance_type = "t2.micro"
  key_name = "for terraform"
}