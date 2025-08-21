resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "vpc"
  }
}