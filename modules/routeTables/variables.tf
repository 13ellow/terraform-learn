variable "vpc_id" {
    description = "vpc id"
    type = number
}

variable "internet_gateway_id" {
    description = "internet gateway"
    type = number
}

variable "public_subnet_ids" {
    description = "public subnets ids"
    type = list(number)

}
variable "private_subnet_ids" {
    description = "private subnets ids"
    type = list(number)
}

variable "nat_gateway_ids" {
  description = "nat gateway ids"
  type = list(number)
}