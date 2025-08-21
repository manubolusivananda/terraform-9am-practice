terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}
module "vpc" {
    source = "./module/vpc"
    cidr_block_vpc = var.cidr_block_vpc
  
}
module "ec2" {
    source = "./module/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
  

}
module "rds" {
    source = "./module/rds"
    identifier = var.identifier
   engine = var.engine
   engine_version = var.engine_version
   instance_class = var.instance_class
   allocated_storage = var.allocated_storage
   username = var.username
   password = var.password
   publicly_accessible = var.publicly_accessible
   skip_final_snapshot = var.skip_final_snapshot
   backup_retention_period = var.backup_retention_period



}
  