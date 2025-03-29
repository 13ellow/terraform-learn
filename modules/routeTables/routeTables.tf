# publicルートテーブル自体の定義
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.learning-vpc.id

    tags = {
      Name = "terraform-rtable"
    }
}

# インターネットゲートウェイへのルート
resource "aws_route" "public" {
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.public.id
    gateway_id = aws_internet_gateway.learning-igw.id
}

# Publicサブネット・ルートテーブルへの関連付け
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public.id
}

# ========================================================

# privateルートテーブルの定義
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.learning-vpc.id

  tags = {
    Name = "Learning"
  }
}

# nag gatewayへのルート
resource "aws_route" "private" {
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.private.id
    nat_gateway_id = aws_nat_gateway.learning-ngw.id
}

# Privateサブネットへの関連付け 
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private.id
}