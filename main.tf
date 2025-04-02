terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "172.16.0.0/16"
}

module "routeTable" {
  source              = "./modules/routeTables"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  nat_gateway_ids     = module.vpc.nat_gateway_ids
}

# module "securityGroup" {
#   source = "./modules/securityGroup"
# }

# module "alb" {
#   source = "./modules/alb"
#   pubic_subnets_ids = [for subnet in aws_subnet.public-subnet: subnet_id] 
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }