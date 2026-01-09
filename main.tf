# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf-vpc-ec2-lab"
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "tf-vpc-ec2-lab-igw"
  }
}

# ---------------------------
# Public Subnet
# ---------------------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-vpc-ec2-lab-public-subnet"
  }
}

# ---------------------------
# Public Route Table (IMPORTANT: route is inside this resource)
# ---------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "tf-vpc-ec2-lab-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ---------------------------
# Security Group
# ---------------------------
resource "aws_security_group" "this" {
  name        = "tf-vpc-ec2-lab-sg"
  description = "Allow SSH from my IP and HTTP from internet"
  vpc_id      = aws_vpc.this.id

  # SSH (only from your public IP)
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  # HTTP (from everywhere)
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-vpc-ec2-lab-sg"
  }
}

# ---------------------------
# Key Pair (imports your local key.pub)
# Make sure key.pub exists in this folder
# ---------------------------
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${path.module}/key.pub")
}

# ---------------------------
# EC2 Instance (Ubuntu + Nginx)
# ---------------------------
resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.this.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -e
              apt-get update -y
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "tf-vpc-ec2-lab-ec2"
  }
}
