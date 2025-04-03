resource "aws_lb" "learning-alb" {
  name = "learning-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]

  subnets = var.public_subnet_ids

  tags = {
    Name = "terraform-learning-alb"
  }
}