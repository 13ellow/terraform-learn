variable "vpc_id" {
    description = "vpc id"
    type = string
}

variable "internet_gateway_id" {
    description = "internet gateway"
    type = string
}

variable "public_subnet_ids" {
    description = "public subnets ids"
    type = list(string)

}
variable "private_subnet_ids" {
    description = "private subnets ids"
    type = list(string)
}

variable "nat_gateway_ids" {
  description = "nat gateway ids"
  type = list(string)
}