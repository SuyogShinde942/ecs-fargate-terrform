variable "vpc_name" {
  type = string
  default = "vpc-default"
}

variable "env" {
    type = string
}

variable "vpc_cidr" {
   type = string
}

variable "vpc_azs" {
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  default     = []
}

variable "vpc_tags" {
    type = map

}

variable "cluster_name" {
    type = string
    description = "ecs_cluster_task"
}