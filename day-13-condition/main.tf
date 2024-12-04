provider "aws" {
  region = "us-east-1"
}

variable "createbuc" {
  description = "for creation true or else false"
  type = bool
  default = true
}

resource "random_string" "suffix" {
  count = var.createbuc ? 1 : 0 
  length = 5
  special = false
  upper = false

}

resource "aws_s3_bucket" "ex" {
  count = var.createbuc ?1 : 0
  bucket = "terraform-${random_string.suffix[count.index].id}"

  
}