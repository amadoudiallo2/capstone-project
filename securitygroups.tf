resource "aws_security_group" "project-security-group" {
  name   = "CapstoneSecurityGroup"
  vpc_id = aws_vpc.demoVPC.id

  ingress {
    from_port = "3306"
    to_port   = "3306"
    protocol  = "tcp"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "CapstoneSecurityGroup"
  }
}

resource "aws_network_acl" "mainProject" {
  vpc_id     = aws_vpc.demoVPC.id
  subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id, aws_subnet.private_subnet1.id]

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    from_port  = 80
    to_port    = 80
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "mainProject"
  }
}
