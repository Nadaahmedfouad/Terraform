resource "aws_vpc" "app1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}
