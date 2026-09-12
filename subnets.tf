resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.app1.id

  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.az_1

  tags = {
    Name = "${terraform.workspace}-public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.app1.id

  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.az_2

  tags = {
    Name = "${terraform.workspace}-public-2"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.app1.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = var.az_1

  tags = {
    Name = "${terraform.workspace}-private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.app1.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = var.az_2

  tags = {
    Name = "${terraform.workspace}-private-2"
  }
}
