module "rds" {
  source            = "./DAY-7-module-same-dir/rds"
  cidr_block_vpc    = "10.0.0.0/16"
  cidr_block_subnet = "10.0.0.0/24"
}
