variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "alb_sg_id" {
    description = "security group for alb"
    type = string
}

variable "public_subnet_ids" {
    description = "public subnets ids"
    type = list(string)
}