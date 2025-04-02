resource "aws_lb" "learning-alb" {
  name = "learning-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]

  subnets = [var.pubic_subnets_ids]

  enable_deletion_protection = true

  tags = {
    Name = "terraform-learning-alb"
  }
}