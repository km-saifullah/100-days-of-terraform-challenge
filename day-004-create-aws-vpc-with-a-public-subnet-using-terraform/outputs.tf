output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "public_subnet_cidr" {
  description = "CIDR block of the public subnet."
  value       = aws_subnet.public.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "availability_zone" {
  description = "Availability Zone of the public subnet."
  value       = aws_subnet.public.availability_zone
}

output "network_summary" {
  description = "Summary of the created network."
  value = {
    vpc_id             = aws_vpc.main.id
    vpc_cidr           = aws_vpc.main.cidr_block
    public_subnet_id   = aws_subnet.public.id
    public_subnet_cidr = aws_subnet.public.cidr_block
    internet_gateway   = aws_internet_gateway.main.id
    route_table        = aws_route_table.public.id
    availability_zone  = aws_subnet.public.availability_zone
  }
}