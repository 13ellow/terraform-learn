resource "aws_vpc" "learning-vpc" {
    cidr_block = var.cidr_block
    tags = {
        Name = "terraform-vpc"
    }
}

resource "aws_subnet" "public-subnet"{
  for_each = {for idx,az in var.az : idx =>{
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
  for_each = {for idx, az in var.az : idx =>{
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
  for_each = {for idx,_ in var.az : idx => true}

  vpc = true

  tags = {
    Name = "terraform-vpc-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "learning-ngw" {
  for_each = {for idx,_ in var.az : idx => true}

  subnet_id = aws_subnet.public-subnet[each.key].id
  allocation_id = aws_eip.learning-vpc-eip[each.key].id

  tags = {
    Name = "terraform-nat-gateway-${each.key}"
  }

  depends_on = [ aws_internet_gateway.learning-igw ]
}