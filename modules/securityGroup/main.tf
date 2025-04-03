resource "aws_security_group" "alb-sg" {
  name = "alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "terraform-learn-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.alb-sg.id
    cidr_ipv4 = var.vpc_cidr_block
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.alb-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1" 
}