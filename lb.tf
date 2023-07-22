# Create security group for load balancer

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.demoVPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name    = "alb-sg"
    Project = "demo-app"
  }
}



resource "aws_lb" "my-lb" {
  name               = "capstone-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.private_subnet2.id]

  enable_deletion_protection = false


  tags = {
    Name = "capstone-lb"
  }
}
# Create Target group

resource "aws_lb_target_group" "target-grp" {
  name       = "Demo-TargetGroup-tf"
  depends_on = [aws_vpc.demoVPC]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.demoVPC.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-grp.arn
  }
}
