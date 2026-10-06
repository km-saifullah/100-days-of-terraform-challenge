output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the web server security group."
  value       = aws_security_group.web.id
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "Public IPv4 address of the EC2 instance."
  value       = aws_instance.web.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance."
  value       = aws_instance.web.public_dns
}

output "website_url" {
  description = "URL of the Nginx web server."
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_command" {
  description = "SSH command template for connecting to the EC2 instance."
  value       = "ssh -i <your-private-key> ec2-user@${aws_instance.web.public_ip}"
}

output "ami_id" {
  description = "AMI ID used by the EC2 instance."
  value       = data.aws_ami.amazon_linux.id
}