variable "alb_sg_id" {
    description = "security group for alb"
    type = string
}

variable "public_subnet_ids" {
    description = "public subnets ids"
    type = list(string)
}