module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs 
  public_subnets  = var.public_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false
  enable_dns_hostnames = true
  enable_dns_support  = true

  tags = var.vpc_tags

}

