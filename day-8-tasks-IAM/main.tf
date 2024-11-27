resource "aws_iam_role" "ec2-role" {
    name = "ec2_role"
  assume_role_policy =  jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"  # EC2 can assume this role
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "CustomS3FullAccessPolicy"
  description = "Custom policy to allow full access to S3 resources"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  role       = aws_iam_role.ec2-role.assume_role_policy
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}

resource "aws_instance" "name" {
  ami = "ami-0e959ab503d46b6ea"
  instance_type = "t2.micro"
  key_name = "for tereraform"

  iam_instance_profile = aws_iam_role.ec2-role.assume_role_policy

  tags = {
    name = "IAM_attached_ec2"
  }
}