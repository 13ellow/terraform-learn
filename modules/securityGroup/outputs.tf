output "alb_sg_id" {
  description = "security group for alb"
  value = aws_security_group.alb-sg.id
}

output "db_sg_id" {
  description = "secuirty group for db"
  value = aws_security_group.db-sg.id
}