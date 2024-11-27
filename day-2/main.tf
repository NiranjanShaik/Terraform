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

# creating route table

resource "aws_route_table" "dev-victor" {
  vpc_id = aws_vpc.dev-victor.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id= aws_internet_gateway.dev-victor.id
  }
}

# subnet association
resource "aws_route_table_association" "dev-victor" {
  subnet_id = aws_subnet.dev-victor.id
  route_table_id = aws_route_table.dev-victor.id
}

# creating security groups
resource "aws_security_group" "dev-victor-sg" {
  name        = "dev-victor-sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.dev-victor.id

  # Inbound rule - allows all traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule - allows all traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Create a private subnet
resource "aws_subnet" "dev-victor-private" {
  vpc_id            = aws_vpc.dev-victor.id
  cidr_block        = "12.0.2.0/24"
  tags = {
    name = "dev-private-subnet"
  }
}


# Elastic IP for NAT Gateway
resource "aws_eip" "dev-victor-nat" {
  
}

# Create a NAT Gateway in the public subnet
resource "aws_nat_gateway" "dev-victor" {
  allocation_id = aws_eip.dev-victor-nat.id
  subnet_id     = aws_subnet.dev-victor.id
  tags = {
    Name = "dev-victor-nat"
  }
}


# Create route table for the private subnet, pointing to the NAT Gateway
resource "aws_route_table" "dev-victor-private" {
  vpc_id = aws_vpc.dev-victor.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-victor.id
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "dev-victor-private" {
  subnet_id      = aws_subnet.dev-victor-private.id
  route_table_id = aws_route_table.dev-victor-private.id
}

# # Public EC2 instance
# resource "aws_instance" "dev-victor-public" {
#   ami           = "ami-0e959ab503d46b6ea"  
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.dev-victor.id
#   # security_groups = [ aws_security_group.dev-victor-sg ]
  
#   associate_public_ip_address = true
  
#   tags = {
#     Name = "dev-victor-public-ec2"
#   }
# }

# # Private EC2 instance
# resource "aws_instance" "dev-victor-private" {
#   ami           = "ami-0e959ab503d46b6ea" 
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.dev-victor-private.id
#   # security_groups = [ aws_security_group.dev-victor-sg ]

#   associate_public_ip_address = false  # No public IP for private EC2
  
#   tags = {
#     Name = "dev-victor-private-ec2"
#   }
# }

