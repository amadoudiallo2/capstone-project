# Create EIP for NAT GW1
resource "aws_eip" "eip_gtw_1" {
  count = "1"
}

# Create NAT gateway1

resource "aws_nat_gateway" "nat_gateway_1" {
  count         = "1"
  allocation_id = aws_eip.eip_gtw_1[count.index].id
  subnet_id     = aws_subnet.private_subnet2.id
}

# Create EIP for NAT GW2

resource "aws_eip" "eip_gtw_2" {
  count = "1"
}

# Create NAT gateway2

resource "aws_nat_gateway" "nat_gateway_2" {
  count         = "1"
  allocation_id = aws_eip.eip_gtw_2[count.index].id
  subnet_id     = aws_subnet.private_subnet3.id
}
