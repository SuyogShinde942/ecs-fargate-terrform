env      = "dev"
vpc_name = "ecs_vpc"
vpc_cidr = "10.0.0.0/16"
vpc_azs = [ "ap-south-1a", "ap-south-1b" ]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_tags = {
    Terraform = "true"
    Environment = "dev"
}


#ClusterVars. 

cluster_name = "bigdata"