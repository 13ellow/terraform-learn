resource "aws_lb" "learning-alb" {
  name = "terraform-learning-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]

  subnets = var.public_subnet_ids

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "terraform-learning-alb"
  }
}

resource "aws_lb_target_group" "alb-target-group" {
  name = "alb-target-group-ecs"
  target_type = "alb"
  port = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.learning-alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
  }
}