resource "aws_security_group" "alb-sg" {
  name = "alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "terraform-learn-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-tls-ipv4" {
    security_group_id = aws_security_group.alb-sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-ipv4-for-alb-sg" {
    security_group_id = aws_security_group.alb-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1" 
}


resource "aws_security_group" "db-sg" {
  name = "db-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "terraform-learn-db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-mysql-ipv4" {
    security_group_id = aws_security_group.db-sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 3306
    ip_protocol = "tcp"
    to_port = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-ipv4-for-db-sg" {
    security_group_id = aws_security_group.db-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1" 
}


