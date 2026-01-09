output "ec2_public_ip" {
  value = aws_instance.this.public_ip
}

output "ssh_command" {
  value = "ssh -i key.pem ubuntu@${aws_instance.this.public_ip}"
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "security_group_id" {
  value = aws_security_group.this.id
}
