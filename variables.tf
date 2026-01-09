variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "eu-west-2"
}

variable "ami_id" {
  type        = string
  description = "Ubuntu AMI ID for the region (eu-west-2)"
  # From your AWS console screenshot (Ubuntu Server 22.04 LTS in eu-west-2)
  default = "ami-0850ab57897dcaa32"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Key pair name for EC2"
  default     = "tf-vpc-ec2-lab-key"
}

variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR format for SSH access (example: 80.6.138.183/32)"
}
