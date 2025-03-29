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
  source = "./modules/vpc"
}

module "securityGroup" {
  source = "./modules/securityGroup"
}

module "alb" {
  source = "./modules/alb"
}

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }