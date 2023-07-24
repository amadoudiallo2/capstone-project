# Create my VPC

resource "aws_vpc" "demoVPC" {
  cidr_block = var.vpc-cidr-block

  tags = {
    Name = "CapstoneVPC"
  }
}

# Create my 3 Subnets

resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.demoVPC.id
  cidr_block        = var.public-sn-1-cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "CapstonePublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.demoVPC.id
  cidr_block        = var.public-sn-2-cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "CapstonePublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.demoVPC.id
  cidr_block        = var.private-sn-1-cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "CapstonePrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.demoVPC.id
  cidr_block        = var.private-sn-2-cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "CapstonePrivateSubnet2"
  }
}


resource "aws_internet_gateway" "int_gtw" {
  vpc_id = aws_vpc.demoVPC.id
}


resource "aws_route_table" "rou_tab" {
  vpc_id = aws_vpc.demoVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gtw.id
  }
}

resource "aws_route_table_association" "rt_assoc" {

  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rou_tab.id
}
