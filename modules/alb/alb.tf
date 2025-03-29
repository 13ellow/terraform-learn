resource "aws_lb" "learning-alb" {
  name = "learning-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]

  subnets = [for subnet in aws_subnet.public-subnet : subnet.id]

  enable_deletion_protection = true

  tags = {
    Name = "terraform-learning-alb"
  }
}