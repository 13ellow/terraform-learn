output "vpc_id" {
  value = aws_vpc.learning-vpc.id
}

output "public_subnet_ids" {
  description = "public subnets ids"
  value = [for subnet in aws_subnet.public-subnet: subnet.id]
}

output "private_subnet_ids" {
  description = "private subnets ids"
  value = [for subnet in aws_subnet.private-subnet: subnet.id]
}

output "internet_gateway_id" {
  description = "internet gateway"
  value = aws_internet_gateway.learning-igw.id
}

output "nat_gateway_ids" {
  description = "nat gateway"
  value = [for nat_gateway in aws_nat_gateway.learning-ngw: nat_gateway.id]  
}

output "vpc_cidr_block" {
  description = "vpc cidr"
  value = aws_vpc.learning-vpc.cidr_block
}