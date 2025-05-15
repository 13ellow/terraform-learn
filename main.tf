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

module "securityGroup" {
  source         = "./modules/securityGroup"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.securityGroup.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "db" {
  source            = "./modules/db"
  availability_zone = local.availability_zones[0]
  username          = var.DB_USERNAME
  password          = var.DB_PASSWORD
  db_name           = "test"
  subnet_ids        = module.vpc.private_subnet_ids
  security_groups   = [module.securityGroup.db_sg_id]
}

module "ecs" {
  source           = "./modules/ecs"
  target_group_arn = module.alb.target_group_arn
}
