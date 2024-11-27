module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = var.type
  key_name               = "for terraform"
  monitoring             = true
  

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}