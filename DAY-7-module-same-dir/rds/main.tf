resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
}

resource "aws_subnet" "name1" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.cidr_block_subnet

}