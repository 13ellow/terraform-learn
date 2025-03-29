locals {
  availability_zones =["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}

resource "aws_vpc" "learning-vpc" {
    cidr_block = "172.16.0.0/16"
    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "public-subnet"{
  for_each = {for idx,az in local.availability_zones : idx =>{
    cidr_block = cidrsubnet(aws_vpc.learning-vpc.cidr_block,8,idx)
    availability_zone = az
  }}

  vpc_id = aws_vpc.learning-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "terraform-vpc-public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private-subnet"{
  for_each = {for idx, az in local.availability_zones : idx =>{
    cidr_block = cidrsubnet(aws_vpc.learning-vpc.cidr_block,8,10+idx)
    availability_zone = az
  }}

  vpc_id = aws_vpc.learning-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "terraform-vpc-private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "learning-igw"{
    vpc_id = aws_vpc.learning-vpc.id

    tags = {
        Name = "terraform-vpc-igw"
    }
}

resource "aws_eip" "learning-vpc-eip" {
  for_each = {for idx,_ in local.availability_zones : idx => true}

  vpc = true

  tags = {
    Name = "terraform-vpc-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "learning-ngw" {
  for_each = {for idx,_ in local.availability_zones : idx => true}

  subnet_id = aws_subnet.public-subnet[each.key].id
  allocation_id = aws_eip.learning-vpc-eip[each.key].id

  tags = {
    Name = "terraform-nat-gateway-${each.key}"
  }

  depends_on = [ aws_internet_gateway.learning-igw ]
}