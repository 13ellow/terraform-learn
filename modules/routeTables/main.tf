# publicルートテーブル自体の定義
resource "aws_route_table" "public" {
    vpc_id = var.vpc_id

    tags = {
      Name = "terraform-rtable-public"
    }
}

# インターネットゲートウェイへのルート
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = var.internet_gateway_id
}

# Publicサブネット・ルートテーブルへの関連付け
resource "aws_route_table_association" "public" {
  for_each = {for idx,subnet_id in var.public_subnet_ids: idx => {
    id = subnet_id
  }}

  route_table_id = aws_route_table.public.id
  subnet_id = each.value.id
}

# ========================================================

# privateルートテーブルの定義
resource "aws_route_table" "private" {
  for_each = {for idx,nat_gateway in var.nat_gateway_ids: idx => {
    id = nat_gateway
  }}

  vpc_id = var.vpc_id

  tags = {
    Name = "terraform-rtable-private-${each.key}"
  }
}

# nag gatewayへのルート
resource "aws_route" "private" {
  for_each = {for idx,nat_gateway in var.nat_gateway_ids: idx => {
    id = nat_gateway
  }}

  route_table_id = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = each.value.id
}

# Privateサブネットへの関連付け 
resource "aws_route_table_association" "private" {
  for_each = {for idx,subnet_id in var.private_subnet_ids: idx => {
    id = subnet_id
  }}

  route_table_id = aws_route_table.private[each.key].id
  subnet_id = each.value.id
}