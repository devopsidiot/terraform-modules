output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "availability_zones" {
  value = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = [
    aws_subnet.private-1a[0].id,
    aws_subnet.private-1b[0].id,
    aws_subnet.private-1c[0].id
  ]
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = [
    aws_subnet.private-1a[0].arn,
    aws_subnet.private-1b[0].arn,
    aws_subnet.private-1c[0].arn
  ]
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = [
    aws_subnet.private-1a[0].cidr_block,
    aws_subnet.private-1b[0].cidr_block,
    aws_subnet.private-1c[0].cidr_block
  ]
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = [
    aws_subnet.private-1a[0].ipv6_cidr_block,
    aws_subnet.private-1b[0].ipv6_cidr_block,
    aws_subnet.private-1c[0].ipv6_cidr_block
  ]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = [
    aws_subnet.public-1a[0].id,
    aws_subnet.public-1b[0].id,
    aws_subnet.public-1c[0].id
  ]
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = [
    aws_subnet.public-1a[0].arn,
    aws_subnet.public-1b[0].arn,
    aws_subnet.public-1c[0].arn
  ]
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = [
    aws_subnet.public-1a[0].cidr_block,
    aws_subnet.public-1b[0].cidr_block,
    aws_subnet.public-1c[0].cidr_block
  ]
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = [
    aws_subnet.public-1a[0].ipv6_cidr_block,
    aws_subnet.public-1b[0].ipv6_cidr_block,
    aws_subnet.public-1c[0].ipv6_cidr_block
  ]
}

output "private_subnets_id_cidr_block_map" {
  value = (var.subnet_cidr_blocks_private != {}) ? {
    (aws_subnet.private-1a[0].id) = aws_subnet.private-1a[0].cidr_block,
    (aws_subnet.private-1b[0].id) = aws_subnet.private-1b[0].cidr_block,
    (aws_subnet.private-1c[0].id) = aws_subnet.private-1c[0].cidr_block,
   } : {}
}

output "public_subnets_id_cidr_block_map" {
  value = (var.subnet_cidr_blocks_public != {}) ? {
    (aws_subnet.public-1a[0].id) = aws_subnet.public-1a[0].cidr_block,
    (aws_subnet.public-1b[0].id) = aws_subnet.public-1b[0].cidr_block,
    (aws_subnet.public-1c[0].id) = aws_subnet.public-1c[0].cidr_block,
   } : {}
}

output "database_subnets" {
  value = []
}

output "default_security_group_id" {
  description = "The ID of the security group created by control tower on VPC creation."
  value       = aws_vpc.vpc.default_security_group_id
}
