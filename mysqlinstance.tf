resource "aws_db_subnet_group" "my_db_subnets" {
  subnet_ids = [aws_subnet.private_subnet3.id, aws_subnet.private_subnet4.id]
}



resource "aws_db_instance" "rds_instance" {
  allocated_storage      = 10
  db_name                = "mydatabasesql"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "foo"
  password               = "foobarbaz"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnets.id
  vpc_security_group_ids = [aws_security_group.project-security-group.id]
